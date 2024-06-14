import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/providers/providers.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    TextEditingController genderController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController sectController = TextEditingController();
    TextEditingController castController = TextEditingController();
    TextEditingController qualificationController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),
            ),
            const Text(
              TextConstants.filter,
              style: TextStyle(
                fontSize: FontConstants.xxlarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFieldWidget(
              readOnly: true,
              hintText: 'Gender',
              obscureText: false,
              controller: genderController,
              suffixIcon: DropDownsWidget(
                itemList: TextConstants.genderList,
                controller: genderController,
                onChanged: (String? selectedOption) {
                  genderController.text = selectedOption ?? '';
                },
              ),
            ),
            TextFieldWidget(
              readOnly: true,
              hintText: 'Sect',
              obscureText: false,
              controller: sectController,
              suffixIcon: DropDownsWidget(
                itemList: TextConstants.sectList,
                controller: sectController,
                onChanged: (String? selectedOption) {
                  sectController.text = selectedOption ?? '';
                },
              ),
            ),
            TextFieldWidget(
              readOnly: true,
              hintText: 'Cast',
              obscureText: false,
              controller: castController,
              suffixIcon: DropDownsWidget(
                itemList: TextConstants.casteList,
                controller: castController,
                onChanged: (String? selectedOption) {
                  castController.text = selectedOption ?? '';
                },
              ),
            ),
            TextFieldWidget(
              readOnly: true,
              hintText: 'Qualification',
              obscureText: false,
              controller: qualificationController,
              suffixIcon: DropDownsWidget(
                itemList: TextConstants.qualificationList,
                controller: qualificationController,
                onChanged: (String? selectedOption) {
                  qualificationController.text = selectedOption ?? '';
                },
              ),
            ),
            TextFieldWidget(
              readOnly: true,
              hintText: 'City',
              obscureText: false,
              controller: cityController,
              suffixIcon: DropDownsWidget(
                itemList: TextConstants.pakistanCitiesList,
                controller: cityController,
                onChanged: (String? selectedOption) {
                  cityController.text = selectedOption ?? '';
                },
              ),
            ),
            TextFieldWidget(
              readOnly: true,
              hintText: 'Age',
              obscureText: false,
              controller: ageController,
              suffixIcon: DropDownsWidget(
                itemList: TextConstants.ageList,
                controller: ageController,
                onChanged: (String? selectedOption) {
                  ageController.text = selectedOption ?? '';
                },
              ),
            ),
            Center(
              child: ButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                  filterProvider.setAge(ageController.text);
                  filterProvider.setGender(genderController.text);
                  filterProvider.setSect(sectController.text);
                  filterProvider.setCast(castController.text);
                  filterProvider.setCity(cityController.text);
                  filterProvider.setQualification(qualificationController.text);
                },
                text: 'Apply',
                width: 350,
                btnColor: ColorConstants.orange,
                textColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetPaymentWidget extends StatelessWidget {
  final VoidCallback onTap;
  const BottomSheetPaymentWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),
            ),
            const Icon(
              Icons.verified,
              color: ColorConstants.orange,
              size: 100,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Congrats! your payment is successfull',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontConstants.xxlarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: ButtonWidget(
                    onPressed: onTap,
                    text: 'Continue',
                    width: 350,
                    btnColor: ColorConstants.orange,
                    textColor: Colors.black)),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
