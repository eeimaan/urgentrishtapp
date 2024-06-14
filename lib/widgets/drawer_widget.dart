import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/auth.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Drawer(
      backgroundColor: ColorConstants.pink,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: user?.photoURL != null
                      ? Image.network(
                          user!.photoURL!,
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: 160,
                              height: 160,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              ImageConstants.profileImage,
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                            );
                          },
                        )
                      : Image.asset(
                          ImageConstants.profileImage,
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: FontConstants.large),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.editProfile);
              },
            ),
            ListTile(
              title: const Text(
                'Invite Friends',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: FontConstants.large),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.invite);
              },
            ),
            ListTile(
              title: const Text(
                'Contact Us',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: FontConstants.large),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.contact);
              },
            ),
            ListTile(
              title: const Text(
                'Feedback',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: FontConstants.large),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Delete Account',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: FontConstants.large),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.deleteAccount);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: ColorConstants.red),
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: FontConstants.large,
                    color: ColorConstants.red),
              ),
              onTap: () {
                DbAuthService.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
