import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => InviteScreenState();
}

class InviteScreenState extends State<InviteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Invite',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Center(
                child: SizedBox(
                  child: Image.asset(
                    ImageConstants.inviteImage,
                    height: 250,
                  ),
                ),
              ),
              const Text(
                'Invite Friends and Earn Rewards!',
                style: TextStyle(
                    fontSize: FontConstants.large, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Invite friends to join Rishta Registry and earn Rs. 100 for each friend who signs up using your invite link. Share your unique link below and start earning rewards today!',
                  style: TextStyle(fontSize: FontConstants.medium),
                ),
              ),
              const Row(
                children: [
                 Icon(Icons.link),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Invite friends via link',
                    style: TextStyle(
                        fontSize: FontConstants.large,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
