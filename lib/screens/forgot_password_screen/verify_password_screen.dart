import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class VerifyPasswordScreen extends StatefulWidget {
  const VerifyPasswordScreen({super.key});

  @override
  State<VerifyPasswordScreen> createState() => _VerifyPasswordScreenState();
}

class _VerifyPasswordScreenState extends State<VerifyPasswordScreen> {
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
        title: const Text(
          TextConstants.forgotpsd,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.large, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(children: [
            const Text(
              TextConstants.verify,
              style: TextStyle(
                  fontSize: FontConstants.xlarge, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              TextConstants.verifyDetail,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontConstants.medium, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerifyContainer(number: ''),
                SizedBox(
                  width: 10,
                ),
                VerifyContainer(number: ''),
                SizedBox(
                  width: 10,
                ),
                VerifyContainer(number: ''),
                SizedBox(
                  width: 10,
                ),
                VerifyContainer(number: ''),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              TextConstants.notReceive,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontConstants.medium, fontWeight: FontWeight.w500),
            ),
            const Text(
              TextConstants.resent,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontConstants.medium, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 100,
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                '1 of 2',
              
                style: TextStyle(
                    fontSize: FontConstants.medium, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: HalfColoredProgressBar(progress: 0.5),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: ButtonWidget(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.createNewPassword);
                    },
                    text: TextConstants.verify,
                    width: 350,
                    btnColor: ColorConstants.orange,
                    textColor: Colors.black)),
          ]),
        ),
      ),
    );
  }
}

class VerifyContainer extends StatelessWidget {
  final String number;

  const VerifyContainer({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorConstants.orange, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: FontConstants.medium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HalfColoredProgressBar extends StatelessWidget {
  final double progress;

  const HalfColoredProgressBar({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                ColorConstants.orange,
                ColorConstants.grey,
              ],
              stops: [progress, progress],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
