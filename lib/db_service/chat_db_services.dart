import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:urgentrishtapp/db_service/auth.dart';
import 'package:urgentrishtapp/models/chat_models/chat_messages_model.dart';
import 'package:urgentrishtapp/providers/chat_providers/chat_file_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_models/chat_all_participants_model.dart';

class ChatDBServices {
  static get uniqueID {
    var uuid = const Uuid();
    return uuid.v4();
  }

  ///  send msg to firebase .............................
  static Future<void> sendIndividualMessages(
      {required ChatMessagesModel message}) async {
    String chatID =
        getMessagesHashCodeID(userIDReceiver: message.userIDReceiver!);
    FirebaseFirestore.instance
        .collection('chat_system')
        .doc('individual_messages')
        .collection(chatID)
        .add(message.toIndividualMessagesMap());
  }

  ///  get all messages from firebase ............................
  static Stream<List<ChatMessagesModel>> getIndividualMessages(
      {required String userIDReceiver}) {
    String chatID = getMessagesHashCodeID(userIDReceiver: userIDReceiver);
    return FirebaseFirestore.instance
        .collection('chat_system')
        .doc('individual_messages')
        .collection(chatID)
        .orderBy('time', descending: false)
        .snapshots()
        .map((messages) {
      List<ChatMessagesModel> chatMessages = [];

      for (var message in messages.docs) {
        chatMessages.add(ChatMessagesModel.fromIndividualMessagesMap(
            message.id, message.data()));
      }

      return chatMessages;
    });
  }

  ///delete individual message
  static Future<bool> deleteIndividualMessages(
      {required String messageId,
      required String userIDReceiver,
      required String messageType,
      String? fileUrl}) async {
    String chatID = getMessagesHashCodeID(userIDReceiver: userIDReceiver);
    await FirebaseFirestore.instance
        .collection('chat_system')
        .doc('individual_messages')
        .collection(chatID)
        .doc(messageId)
        .delete();

    if (messageType == 'image') {
      if (fileUrl != null) {
        try {
          await FirebaseStorage.instance.refFromURL(fileUrl).delete();
          log(' deleted ');
        } catch (error) {
          log('Error deleting file from storage: $error');
        }
      }
    }

    return true;
  }

  /// Get all group messages from Firebase along with user profiles.
  static Stream<List<ChatMessagesModel>> getGroupMessages(
      {required String groupID}) {
    return FirebaseFirestore.instance
        .collection('chat_system')
        .doc('group_messages')
        .collection(groupID)
        .orderBy('time', descending: false)
        .snapshots()
        .asyncMap((messages) async {
      List<ChatMessagesModel> chatMessages = [];

      for (var message in messages.docs) {
        // Listen for real-time changes to the user profile
        Stream<DocumentSnapshot> userProfileStream = FirebaseFirestore.instance
            .collection('users')
            .doc(message['user_id_sender'])
            .snapshots();

        // Await the first snapshot of the user profile
        await for (var userProfileSnapshot in userProfileStream) {
          if (userProfileSnapshot.exists) {
            chatMessages.add(ChatMessagesModel.fromGroupMessagesMap(
                id: message.id,
                messageData: message.data(),
                userProfileData:
                    userProfileSnapshot.data() as Map<String, dynamic>));
            break; // Exit the loop after adding the data
          }
        }
      }
      return chatMessages;
    });
  }

  static String getMessagesHashCodeID({required String userIDReceiver}) {
    String currentUserUID = DbAuthService.getCurrentUser!.uid;
    String chatHashID = '';
    if (currentUserUID.hashCode <= userIDReceiver.hashCode) {
      chatHashID = '$currentUserUID-$userIDReceiver';
    } else {
      chatHashID = '$userIDReceiver-$currentUserUID';
    }
    return chatHashID;
  }

  ///  fetch individual chat user .......................................
  static Stream<List<ChatParticipantsModel>> fetchIndividualChatUsers({
    required bool isConnected,
  }) async* {
    String currentUserUID = DbAuthService.getCurrentUser!.uid;

    log('.....$isConnected....   current user id  =  $currentUserUID}');

    List<dynamic> connectionList = [];
    List<ChatParticipantsModel> allParticipants = [];

    StreamController<List<ChatParticipantsModel>> userConnectionController =
        StreamController();

    FirebaseFirestore.instance
        .collection('chat_system')
        .doc('connections')
        .collection('individual_connection')
        .doc(currentUserUID)
        .snapshots()
        .listen((snapshot) async {
      connectionList.clear();

      if (snapshot.exists) {
        connectionList.addAll(snapshot.data()!['connections'] as List<dynamic>);
      }

      Query<Map<String, dynamic>> query =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot<Map<String, dynamic>> userData = await query.get();

      allParticipants.clear();

      for (var data in userData.docs) {
        // Skip the current user
        if (data.id == currentUserUID) continue;

        bool isUserConnected = connectionList.contains(data.id);

        if (isConnected && isUserConnected) {
          String chatID = getMessagesHashCodeID(userIDReceiver: data.id);
          log('....................  chat id  ==  $chatID');

          Query<Map<String, dynamic>> lastMsg = FirebaseFirestore.instance
              .collection('chat_system')
              .doc('individual_messages')
              .collection(chatID)
              .orderBy('time', descending: true)
              .limit(1);

          QuerySnapshot<Map<String, dynamic>> msgData = await lastMsg.get();

          for (var msg in msgData.docs) {
            log('....................  data msg  ==  ${msg.data()}');
            allParticipants.add(
              ChatParticipantsModel.fromMapConnectedParticipants(
                  data: data.data(),
                  userUID: data.id,
                  chatMsg: ChatMessagesModel.fromIndividualMessagesMap(
                    msg.id,
                    msg.data(),
                  )),
            );
          }
        } else if (!isConnected && !isUserConnected) {
          allParticipants.add(
            ChatParticipantsModel.fromMapAllParticipants(
              data: data.data(),
              userUID: data.id,
            ),
          );
        } else if (!isConnected) {
          // Add both connected and non-connected users when isConnected is false
          allParticipants.add(
            ChatParticipantsModel.fromMapAllParticipants(
              data: data.data(),
              userUID: data.id,
            ),
          );
        }
      }

      userConnectionController.add(allParticipants);
    });

    yield* userConnectionController.stream;
  }

  // static Stream<List<ChatParticipantsModel>> fetchAllParticipants() {
  //   String currentUserUID = AuthServices.getCurrentUser!.uid;
  //   List<ChatParticipantsModel> allParticipants = [];
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .where(FieldPath.documentId, isNotEqualTo: currentUserUID)
  //       .snapshots()
  //       .map((userData) {
  //     allParticipants.clear();
  //     for (var data in userData.docs) {
  //       allParticipants.add(ChatParticipantsModel.fromMapAllParticipants(
  //           data: data.data(), userUID: data.id));
  //     }
  //     return allParticipants;
  //   });
  // }

  static Future<void> addIndividualConnectionHashCode(
      {required String userIDReceiver}) async {
    String? currentUserID =DbAuthService.getCurrentUser?.uid;

    if (currentUserID != null) {
      await FirebaseFirestore.instance
          .collection('chat_system')
          .doc('connections')
          .collection('individual_connection')
          .doc(currentUserID)
          .set({
        'connections': FieldValue.arrayUnion([userIDReceiver])
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('chat_system')
          .doc('connections')
          .collection('individual_connection')
          .doc(userIDReceiver)
          .set({
        'connections': FieldValue.arrayUnion([currentUserID])
      }, SetOptions(merge: true));
    }
  }

  static Future<String> uploadChatFile(
      {required String file,
      required ChatFileProvider chatFileProvider}) async {
    String? currentUserID = DbAuthService.getCurrentUser?.uid;
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child(
          'chat_images/$currentUserID/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(file));

      uploadTask.snapshotEvents.listen((event) {
        log('image uploaded  ==  ${event.bytesTransferred.toDouble() / event.totalBytes.toDouble() * 100}  ${event.totalBytes} ..... ${event.bytesTransferred}');

        chatFileProvider.setUploadingProgress =
            (event.bytesTransferred.toDouble() /
                    event.totalBytes.toDouble() *
                    100)
                .toInt();
      });
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return '';
    }
  }
}
