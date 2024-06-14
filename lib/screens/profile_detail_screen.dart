import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/models/chat_models/chat_all_participants_model.dart';
import 'package:urgentrishtapp/models/user_model.dart';

class ProfileDetailScreen extends StatelessWidget {
  final UserData userData;

  const ProfileDetailScreen({Key? key, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Profile Details',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    userData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userData.name,
                            style: const TextStyle(
                              fontSize: FontConstants.xxxlarge,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final userDetail = ChatParticipantsModel(
                                userUID: userData.uid,
                                name: userData.name,
                                imageURL: userData.imageUrl,
                              );
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.individualMessagesScreen,
                                arguments: userDetail,
                              );
                            },
                            child: const Icon(Icons.chat_bubble_outline),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: ColorConstants.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${userData.province},',
                            style: const TextStyle(
                              fontSize: FontConstants.large,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            userData.city,
                            style: const TextStyle(
                              fontSize: FontConstants.large,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userData.bio,
                        style: const TextStyle(
                          fontSize: FontConstants.large,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Basic Information',
                        style: TextStyle(
                          fontSize: FontConstants.large,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        child: SingleChildScrollView(
                          child: Wrap(
                            children: [
                              CustomTextContainer(
                                text: userData.gender,
                                heading: 'Gender',
                              ),
                              CustomTextContainer(
                                text: userData.age,
                                heading: 'Age',
                              ),
                              CustomTextContainer(
                                text: userData.cast,
                                heading: 'Cast',
                              ),
                              CustomTextContainer(
                                text: userData.height,
                                heading: 'Height',
                              ),
                              CustomTextContainer(
                                text: userData.weight,
                                heading: 'Weight',
                              ),
                              CustomTextContainer(
                                text: userData.religion,
                                heading: 'Religion',
                              ),
                              CustomTextContainer(
                                text: userData.sect,
                                heading: 'Sect',
                              ),
                              CustomTextContainer(
                                text: userData.qualification,
                                heading: 'Qualification',
                              ),
                              CustomTextContainer(
                                text: userData.brother,
                                heading: 'Brother',
                              ),
                              CustomTextContainer(
                                text: userData.sister,
                                heading: 'Sister',
                              ),
                              CustomTextContainer(
                                text: userData.fatherAlive,
                                heading: 'Father alive',
                              ),
                              CustomTextContainer(
                                text: userData.motherAlive,
                                heading: 'Mother alive',
                              ),
                              CustomTextContainer(
                                text: userData.jointFamily,
                                heading: 'Joint family',
                              ),
                              CustomTextContainer(
                                text: userData.maritalStatus,
                                heading: 'Marital status',
                              ),
                              if (userData.maritalStatus != 'Single')
                                CustomTextContainer(
                                  text: userData.kids,
                                  heading: 'Kids',
                                ),
                              CustomTextContainer(
                                text: userData.home,
                                heading: 'Home',
                              ),
                              CustomTextContainer(
                                text: userData.skinColor,
                                heading: 'Skin Color',
                              ),
                              CustomTextContainer(
                                text: userData.interest,
                                heading: 'Interest',
                              ),
                              CustomTextContainer(
                                text: userData.smoking,
                                heading: 'Smoking',
                              ),
                              CustomTextContainer(
                                text: userData.disability,
                                heading: 'Disability',
                              ),
                              CustomTextContainer(
                                text: userData.job,
                                heading: 'Job/Business',
                              ),
                              CustomTextContainer(
                                text: userData.partnerPref,
                                heading: 'Partner preference',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String text;
  final String heading;
  const CustomTextContainer(
      {Key? key, required this.text, required this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: FontConstants.small),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorConstants.pink,
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: FontConstants.small,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
