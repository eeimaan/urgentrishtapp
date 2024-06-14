import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class IdentityVerifier {
  Future<bool> validateCnicFormat(File image) async {
    try {
      final inputImage = InputImage.fromFile(image);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRecognizer.processImage(inputImage);

      // Simple validation logic for Pakistani CNIC
      bool isValid = recognizedText.blocks.any((block) {
        final text = block.text;
        // Check for typical CNIC number pattern
        final cnicPattern = RegExp(r'\d{5}-\d{7}-\d');
        return cnicPattern.hasMatch(text);
      });

      textRecognizer.close();
      return isValid;
    } catch (e) {
      log('Error during CNIC validation: $e');
      return false;
    }
  }

  Future<void> verifyIdentity({
    required File? imageFrontCnic,
    required File? imageBackCnic,
    required File? imageSelfie,
    required Function(String) setResult,
  }) async {
    setResult('Verifying...');

    if (imageFrontCnic == null ||
        imageBackCnic == null ||
        imageSelfie == null) {
      setResult('Please provide all required images.');
      return;
    }

    // Validate front CNIC format
    bool isFrontCnicValid = await validateCnicFormat(imageFrontCnic);
    if (!isFrontCnicValid) {
      setResult(
          'The front CNIC image does not appear to be a valid.');
      return;
    }

    // // Validate back CNIC format
    // bool isBackCnicValid = await validateCnicFormat(imageBackCnic);
    // if (!isBackCnicValid) {
    //   setResult('The back image does not appear to be a valid Pakistani CNIC.');
    //   return;
    // }

    final options = FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    );
    final faceDetector = FaceDetector(options: options);
    final cnicInputImage = InputImage.fromFile(imageFrontCnic);
    final faceInputImage = InputImage.fromFile(imageSelfie);

    final cnicFaces = await faceDetector.processImage(cnicInputImage);
    final faceFaces = await faceDetector.processImage(faceInputImage);

    if (cnicFaces.isNotEmpty && faceFaces.isNotEmpty) {
      final cnicFace = cnicFaces.first;
      final faceFace = faceFaces.first;

      bool isMatching = compareFaces(cnicFace, faceFace);

      setResult(isMatching
          ? 'Identity verified successfully'
          : 'Face does not match the CNIC');
    } else {
      setResult('Face not detected in images.');
    }

    faceDetector.close();
  }

  bool compareFaces(Face cnicFace, Face faceFace) {
    double threshold = 20.0;

    Map<FaceLandmarkType, FaceLandmark?> cnicLandmarks = cnicFace.landmarks;
    Map<FaceLandmarkType, FaceLandmark?> faceLandmarks = faceFace.landmarks;

    for (FaceLandmarkType landmarkType in FaceLandmarkType.values) {
      final cnicLandmark = cnicLandmarks[landmarkType];
      final faceLandmark = faceLandmarks[landmarkType];

      if (cnicLandmark != null && faceLandmark != null) {
        int dx = (cnicLandmark.position.x - faceLandmark.position.x).abs();
        int dy = (cnicLandmark.position.y - faceLandmark.position.y).abs();

        if (dx > threshold || dy > threshold) {
          return false;
        }
      }
    }
    return true;
  }
}

class AppUtils {
  static Future<File?> captureImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static String formatDateWithoutTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}

String convertDateTimeToOnlyTime(timeStamp) {
  DateTime time = timeStamp.toDate();
  DateFormat timeFormat = DateFormat("h:mm a");
  String formattedTime = timeFormat.format(time);
  return formattedTime;
}

String convertDateTimeToMMMMDY({Timestamp? timestamp}) {
  if (timestamp != null) {
    DateTime time = timestamp.toDate();

    DateTime currentDate = DateTime.now();

    DateFormat dateFormat = DateFormat.yMd();

    String formattedServerDate = dateFormat.format(time);

    String formattedCurrentDate = dateFormat.format(currentDate);

    if (formattedServerDate == formattedCurrentDate) {
      return 'Today';
    } else {
      DateFormat dateFormat = DateFormat("MMMM d, y");
      String formattedDate = dateFormat.format(time);
      return formattedDate;
    }
  }
  return '';
}

String formatDateForChatTile({Timestamp? timestamp}) {
  if (timestamp != null) {
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

    if (dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (dateTime.day == yesterday.day &&
        dateTime.month == yesterday.month &&
        dateTime.year == yesterday.year) {
      return 'Yesterday';
    } else {
      return DateFormat('M/d/yy').format(dateTime);
    }
  }
  return '';
}

class AppImagePicker {
  static Future<String?> getImageFromGallery() async {
    final pickedFile = await ImagePicker()
        .pickImage(imageQuality: 100, source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image.path;
    } else {
      return null;
    }
  }

  static Future<String?> getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image.path;
    } else {
      return null;
    }
  }
}

class AppPayment {
  static const String baseUrl = 'https://gopayfast.com';

  static Future<void> sendPayment({
    required String nameOnCard,
    required String cardNumber,
    required String expiryDate,
    required String securityCode,
    required String basketId,
    required String totalAmount,
    required String email,
    required String transactionDate,
    required bool otpRequired,
    required bool recurringTxn,
    String? transactionId,
  }) async {
    try {
      String accessToken = await getAccessToken();

      String instrumentToken = await getTemporaryToken(
        accessToken: accessToken,
        basketId: basketId,
        totalAmount: totalAmount,
        email: email,
        accountNumber: cardNumber,
        accountTitle: nameOnCard,
        mobile: '',
        cnicNumber: '',
        bankCode: '',
      );

      var body = {
        'instrument_token': instrumentToken,
        'transaction_id': transactionId,
        'merchant_user_id': '20840',
        'basket_id': basketId,
        'order_date': transactionDate,
        'txndesc': 'Payment description',
        'txnamt': totalAmount,
        'recurring_txn': recurringTxn ? 'yes' : 'no',
        'otp_required': otpRequired ? 'yes' : 'no',
      };

      var response = await http.post(
        Uri.parse('$baseUrl/transaction/tokenized'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      log('Tokenized transaction response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String transactionId = jsonResponse['transaction_id'];
        log('Transaction ID: $transactionId');
      } else {
        log('Request failed with status: ${response.statusCode}');
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
      throw e;
    }
  }

  static Future<String> getTemporaryToken({
    required String accessToken,
    required String basketId,
    required String totalAmount,
    required String email,
    required String mobile,
    required String cnicNumber,
    required String accountNumber,
    required String accountTitle,
    required String bankCode,
  }) async {
    var body = {
      'merchant_user_id': '20840',
      'user_mobile_number': mobile,
      'basket_id': basketId,
      'txnamt': totalAmount,
      'account_type': '4',
      'bank_code': bankCode,
      'cnic_number': cnicNumber,
      'account_number': accountNumber,
      'account_title': accountTitle,
    };

    var response = await http.post(
      Uri.parse('$baseUrl/transaction/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    log('Temporary token response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['instrument_token'];
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static Future<String> getAccessToken() async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'client_id': 'BILLER-20840',
          'client_secret': 'SlObH6Os7RP7-j4meMzn3p9Ys',
          'grant_type': 'client_credentials',
        },
      );

      log('Access token response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse['access_token'];
      } else {
        throw Exception(
            'Failed to obtain access token. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error getting access token: $e');
      throw e;
    }
  }
}


























































//class IdentityVerifier {
//   final String appId;
//   final String appKey;

//   IdentityVerifier({required this.appId, required this.appKey});

//   Future<void> verification({
//     required File? imageFrontCnic,
//     required File? imageBackCnic,
//     required File? imageSelfie,
//     required Function(String) setResult,
//   }) async {
//     try {
//       // Step 1: POST request to get UUID
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('https://idv-eu.kairos.com/v0.1/full-id-verification'),
//       );

//       // Adding files
//       request.files.add(await http.MultipartFile.fromPath(
//         'selfie',
//         imageSelfie!.path,
//         contentType: MediaType('image', 'jpeg'),
//       ));
//       request.files.add(await http.MultipartFile.fromPath(
//         'document',
//         imageFrontCnic!.path,
//         contentType: MediaType('image', 'jpeg'),
//       ));
//       request.files.add(await http.MultipartFile.fromPath(
//         'document_back',
//         imageBackCnic!.path,
//         contentType: MediaType('image', 'jpeg'),
//       ));

//       // Adding headers
//       request.headers['app_id'] = appId;
//       request.headers['app_key'] = appKey;
//       request.headers['Content-Type'] = 'multipart/form-data';

//       var response = await request.send();
//       if (response.statusCode == 201) {
//         var responseData = await response.stream.bytesToString();
//         var jsonResponse = json.decode(responseData);
//         log('json response: $jsonResponse');
//         String uuid = jsonResponse['api_req_uuid'];

//         // Step 2: Continuously check for response until received
//         await _waitForResponse(uuid, setResult);
//       } else {
//         var responseData = await response.stream.bytesToString();
//         log('json response: $responseData');
//         setResult('Error in verification request: $responseData');
//       }
//     } catch (e) {
//       setResult('Exception: $e');
//     }
//   }

//   Future<void> _waitForResponse(String uuid, Function(String) setResult) async {
//     try {
//       log('uuid: $uuid');
//       var url = Uri.parse(
//           'https://idv-eu.kairos.com/v0.1/full-id-verification/$uuid');
//       var request = http.Request('GET', url)
//         ..headers['app_id'] = appId
//         ..headers['app_key'] = appKey
//         ..headers['Content-Type'] = 'application/json';

//       await Future.delayed(Duration(seconds: 30));

//       var response = await request.send();
//       var body = await response.stream.bytesToString();
//       log('Response status: ${response.statusCode}');
//       log('Response body: $body');

//       if (response.statusCode == 200) {
//         log('Verification result: $body');

//         var jsonResponse = json.decode(body);
//         var description = jsonResponse['response_data']['decision']['details']
//             [0]['description'];

//         setResult(description);
//       } else if (response.statusCode == 404) {
//         log('Error results: Not Found');
//         setResult('Not Found');
//       } else {
//         log('Error verification results: ${response.statusCode}');
//         setResult('Error verification results: ${response.statusCode}');
//       }
//     } catch (e) {
//       setResult('Exception: $e');
//     }
//   }
// }
//}