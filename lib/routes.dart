import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/models/chat_models/chat_all_participants_model.dart';
import 'package:urgentrishtapp/models/user_model.dart';
import 'package:urgentrishtapp/screens/chat_screen/all_participants_user.dart';
import 'package:urgentrishtapp/screens/chat_screen/chat_main_screen.dart';
import 'package:urgentrishtapp/screens/screens.dart';

import 'screens/chat_screen/individual_messages_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return animatePage(_getPage(settings));
  }

  static Widget _getPage(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return const SplashScreen();
      case AppRoutes.login:
        return const LoginScreen();
      case AppRoutes.register:
        return const RegistrationScreen();
      case AppRoutes.forgotPassword:
        return const ForgotPasswordScreen();
      case AppRoutes.createNewPassword:
        return const CreateNewPasswordScreen();
      case AppRoutes.verifyPassword:
        return const VerifyPasswordScreen();
          case AppRoutes.pendingStatus:
        return const PendingStatusScreen();
          case AppRoutes.pendingVerify:
        return const PendingVerificationScreen();
      case AppRoutes.verifyEmail:
        final dynamic arguments = settings.arguments;
        return VerifyEmailScreen(
          paymentStatus: arguments['paymentStatus'],
          email: arguments['email'],
          password: arguments['password'],
          phone: arguments['phoneNo'],
          name: arguments['name'],
          fatherName: arguments['fatherName'],
          motherName: arguments['motherName'],
          cnic: arguments['cnic'],
          currentAddress: arguments['address'],
          gender: arguments['gender'],
          cast: arguments['cast'],
          religion: arguments['religion'],
          sect: arguments['sect'],
          maritalStatus: arguments['maritalStatus'],
          job: arguments['job'],
          kids: arguments['kids'],
          qualification: arguments['qualification'],
          height: arguments['height'],
          weight: arguments['weight'],
          age: arguments['age'],
          home: arguments['home'],
          city: arguments['city'],
          province: arguments['province'],
          smoking: arguments['smoking'],
          disability: arguments['disability'],
          skinColor: arguments['skinColor'],
          brother: arguments['brother'],
          sister: arguments['sister'],
          bio: arguments['bio'],
          interest: arguments['interest'],
          partnerPref: arguments['partnerPref'],
          dateOfBirth: arguments['dateOfBirth'],
          image: arguments['image'],
          imageFrontCnic: arguments['frontCnic'],
          imageBackCnic: arguments['backCnic'],
          imageSelfie: arguments['imageSelfie'],
          cnicAddress: arguments['cnicAddress'],
          motherAlive: arguments['motherAlive'],
          fatherAlive: arguments['fatherAlive'],
          jointFamily: arguments['jointFamily'],
        );
      case AppRoutes.basicInfo:
        final dynamic arguments = settings.arguments;
        return BasicInformationScreen(
            email: arguments['email'],
            password: arguments['password'],
            phone: arguments['phoneNo'],
            name: arguments['name'],
            fatherName: arguments['fatherName'],
            motherName: arguments['motherName'],
            cnic: arguments['cnic'],
            currentAddress: arguments['address'],
            cnicAddress: arguments['cnicAddress']);
      case AppRoutes.basicInfoMore:
        final dynamic arguments = settings.arguments;
        return BasicInformationMoreScreen(
          email: arguments['email'],
          password: arguments['password'],
          phone: arguments['phoneNo'],
          name: arguments['name'],
          fatherName: arguments['fatherName'],
          motherName: arguments['motherName'],
          cnic: arguments['cnic'],
          currentAddress: arguments['address'],
          gender: arguments['gender'],
          cast: arguments['cast'],
          religion: arguments['religion'],
          sect: arguments['sect'],
          maritalStatus: arguments['maritalStatus'],
          job: arguments['job'],
          kids: arguments['kids'],
          qualification: arguments['qualification'],
          height: arguments['height'],
          weight: arguments['weight'],
          age: arguments['age'],
          home: arguments['home'],
          cnicAddress: arguments['cnicAddress'],
        );
      case AppRoutes.termsAgree:
        final dynamic arguments = settings.arguments;
        return TermsAgreeScreen(
          email: arguments['email'],
          password: arguments['password'],
          phone: arguments['phoneNo'],
          name: arguments['name'],
          fatherName: arguments['fatherName'],
          motherName: arguments['motherName'],
          cnic: arguments['cnic'],
          currentAddress: arguments['address'],
          gender: arguments['gender'],
          cast: arguments['cast'],
          religion: arguments['religion'],
          sect: arguments['sect'],
          maritalStatus: arguments['maritalStatus'],
          job: arguments['job'],
          kids: arguments['kids'],
          qualification: arguments['qualification'],
          height: arguments['height'],
          weight: arguments['weight'],
          age: arguments['age'],
          home: arguments['home'],
          city: arguments['city'],
          province: arguments['province'],
          smoking: arguments['smoking'],
          disability: arguments['disability'],
          skinColor: arguments['skinColor'],
          brother: arguments['brother'],
          sister: arguments['sister'],
          bio: arguments['bio'],
          interest: arguments['interest'],
          partnerPref: arguments['partnerPref'],
          dateOfBirth: arguments['dateOfBirth'],
          image: arguments['image'],
          imageFrontCnic: arguments['frontCnic'],
          imageBackCnic: arguments['backCnic'],
          imageSelfie: arguments['imageSelfie'],
          paymentStatus: arguments['paymentStatus'],
          cnicAddress: arguments['cnicAddress'],
          motherAlive: arguments['motherAlive'],
          fatherAlive: arguments['fatherAlive'],
          jointFamily: arguments['jointFamily'],
        );
      case AppRoutes.profile:
        final dynamic arguments = settings.arguments;
        return CreateProfileScreen(
          email: arguments['email'],
          password: arguments['password'],
          phone: arguments['phoneNo'],
          name: arguments['name'],
          fatherName: arguments['fatherName'],
          motherName: arguments['motherName'],
          cnic: arguments['cnic'],
          currentAddress: arguments['address'],
          gender: arguments['gender'],
          cast: arguments['cast'],
          religion: arguments['religion'],
          sect: arguments['sect'],
          maritalStatus: arguments['maritalStatus'],
          job: arguments['job'],
          kids: arguments['kids'],
          qualification: arguments['qualification'],
          height: arguments['height'],
          weight: arguments['weight'],
          age: arguments['age'],
          home: arguments['home'],
          city: arguments['city'],
          province: arguments['province'],
          smoking: arguments['smoking'],
          disability: arguments['disability'],
          skinColor: arguments['skinColor'],
          brother: arguments['brother'],
          sister: arguments['sister'],
          cnicAddress: arguments['cnicAddress'],
          motherAlive: arguments['motherAlive'],
          fatherAlive: arguments['fatherAlive'],
          jointFamily: arguments['jointFamily'],
        );
      case AppRoutes.profileDetails:
        final userData = settings.arguments as UserData;
        return ProfileDetailScreen(userData: userData);
      case AppRoutes.individualMessagesScreen:
        {
          ChatParticipantsModel userData =
              settings.arguments as ChatParticipantsModel;
          return IndividualMessagesScreen(
            userdata: userData,
          );
        }
      case AppRoutes.home:
        return const HomeScreen();
      case AppRoutes.chatMainScreen:
        return const ChatMainScreen();
      case AppRoutes.allParticipantsUserScreen:
        return const AllParticipantsUser();

      case AppRoutes.payment:
        final dynamic arguments = settings.arguments;
        return PaymentScreen(
          email: arguments['email'],
          password: arguments['password'],
          phone: arguments['phoneNo'],
          name: arguments['name'],
          fatherName: arguments['fatherName'],
          motherName: arguments['motherName'],
          cnic: arguments['cnic'],
          currentAddress: arguments['address'],
          gender: arguments['gender'],
          cast: arguments['cast'],
          religion: arguments['religion'],
          sect: arguments['sect'],
          maritalStatus: arguments['maritalStatus'],
          job: arguments['job'],
          kids: arguments['kids'],
          qualification: arguments['qualification'],
          height: arguments['height'],
          weight: arguments['weight'],
          age: arguments['age'],
          home: arguments['home'],
          city: arguments['city'],
          province: arguments['province'],
          smoking: arguments['smoking'],
          disability: arguments['disability'],
          skinColor: arguments['skinColor'],
          brother: arguments['brother'],
          sister: arguments['sister'],
          bio: arguments['bio'],
          interest: arguments['interest'],
          partnerPref: arguments['partnerPref'],
          dateOfBirth: arguments['dateOfBirth'],
          image: arguments['image'],
          imageFrontCnic: arguments['frontCnic'],
          imageBackCnic: arguments['backCnic'],
          imageSelfie: arguments['imageSelfie'],
          cnicAddress: arguments['cnicAddress'],
          motherAlive: arguments['motherAlive'],
          fatherAlive: arguments['fatherAlive'],
          jointFamily: arguments['jointFamily'],
        );

      case AppRoutes.paymentMethod:
        final dynamic arguments = settings.arguments;
        return PaymentMetodScreen(
          email: arguments['email'],
          password: arguments['password'],
          phone: arguments['phoneNo'],
          name: arguments['name'],
          fatherName: arguments['fatherName'],
          motherName: arguments['motherName'],
          cnic: arguments['cnic'],
          currentAddress: arguments['address'],
          gender: arguments['gender'],
          cast: arguments['cast'],
          religion: arguments['religion'],
          sect: arguments['sect'],
          maritalStatus: arguments['maritalStatus'],
          job: arguments['job'],
          kids: arguments['kids'],
          qualification: arguments['qualification'],
          height: arguments['height'],
          weight: arguments['weight'],
          age: arguments['age'],
          home: arguments['home'],
          city: arguments['city'],
          province: arguments['province'],
          smoking: arguments['smoking'],
          disability: arguments['disability'],
          skinColor: arguments['skinColor'],
          brother: arguments['brother'],
          sister: arguments['sister'],
          bio: arguments['bio'],
          interest: arguments['interest'],
          partnerPref: arguments['partnerPref'],
          dateOfBirth: arguments['dateOfBirth'],
          image: arguments['image'],
          imageFrontCnic: arguments['frontCnic'],
          imageBackCnic: arguments['backCnic'],
          imageSelfie: arguments['imageSelfie'],
          cnicAddress: arguments['cnicAddress'],
          motherAlive: arguments['motherAlive'],
          fatherAlive: arguments['fatherAlive'],
          jointFamily: arguments['jointFamily'],
        );
      case AppRoutes.verifyDocument:
        final dynamic arguments = settings.arguments;
        return VerifyDocuments(
          email: arguments['email'],
          password: arguments['password'],
          phone: arguments['phoneNo'],
          name: arguments['name'],
          fatherName: arguments['fatherName'],
          motherName: arguments['motherName'],
          cnic: arguments['cnic'],
          currentAddress: arguments['address'],
          gender: arguments['gender'],
          cast: arguments['cast'],
          religion: arguments['religion'],
          sect: arguments['sect'],
          maritalStatus: arguments['maritalStatus'],
          job: arguments['job'],
          kids: arguments['kids'],
          qualification: arguments['qualification'],
          height: arguments['height'],
          weight: arguments['weight'],
          age: arguments['age'],
          home: arguments['home'],
          city: arguments['city'],
          province: arguments['province'],
          smoking: arguments['smoking'],
          disability: arguments['disability'],
          skinColor: arguments['skinColor'],
          brother: arguments['brother'],
          sister: arguments['sister'],
          bio: arguments['bio'],
          interest: arguments['interest'],
          partnerPref: arguments['partnerPref'],
          dateOfBirth: arguments['dateOfBirth'],
          image: arguments['image'],
          cnicAddress: arguments['cnicAddress'],
          motherAlive: arguments['motherAlive'],
          fatherAlive: arguments['fatherAlive'],
          jointFamily: arguments['jointFamily'],
        );
      case AppRoutes.invite:
        return const InviteScreen();
      case AppRoutes.contact:
        return const ContactScreen();
      case AppRoutes.editProfile:
        return const EditProfileScreen();
      case AppRoutes.deleteAccount:
        return const DeleteAccountScreen();
      default:
        AppRoutes.splash;
        return const SplashScreen();
    }
  }

  static PageRouteBuilder animatePage(Widget widget) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, __, ___) => widget,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return customLeftSlideTransition(animation, child);
      },
    );
  }

  static Widget customLeftSlideTransition(
      Animation<double> animation, Widget child) {
    Tween<Offset> tween =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
    return SlideTransition(
      position: tween.animate(animation),
      child: child,
    );
  }
}
