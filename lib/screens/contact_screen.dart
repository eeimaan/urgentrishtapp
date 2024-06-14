import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> _sendEmail() async {
    final String name = nameController.text;
    final String message = messageController.text;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'emanysqoob379@gmail.com',
      query: 'subject=Contact Us&body=Name: $name\n \nMessage:\n$message',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email app')),
      );
    }
  }

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
          'Contact us',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(fontSize: FontConstants.large),
            ),
            TextFieldWidget(
              hintText: 'Enter your name',
              obscureText: false,
              controller: nameController,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'Please enter name';
                } else if (!isValidName(input)) {
                  return 'Please enter valid name';
                }
                return null;
              },
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 0.3),
              ),
            ),
            const SizedBox(height: 10),
           
            const Text(
              'Message',
              style: TextStyle(fontSize: FontConstants.large),
            ),
            TextFieldWidget(
              hintText: 'Enter a description...',
              obscureText: false,
              maxLines: 4,
              controller: messageController,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'Please enter message';
                }
                return null;
              },
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 0.3),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ButtonWidget(
                  onPressed: _sendEmail,
                  text: 'Send',
                  width: 350,
                  btnColor: ColorConstants.orange,
                  textColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
