import 'package:flutter/material.dart';
import 'package:urgentrishtapp/widgets/custom_diaplay_image.dart';
import '../../constants/constants.dart';

class ChatTile extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? msg;
  final String? type;
  final Widget? trailing;
  final bool isOnline;
  final bool isOpenedForGroupChat;

  const ChatTile({
    Key? key,
    this.msg,
    this.type,
    this.isOpenedForGroupChat = false,
    this.title,
    this.imagePath,
    this.trailing,
    this.isOnline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDarkMode ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        leading: Stack(
          children: [
            isOpenedForGroupChat
                ? Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    clipBehavior: Clip.hardEdge,
                    child: const Image(image: AssetImage(ImageConstants.profileImage)))
                : CustomDisplayImage(
                    imageUrl: imagePath!,
                  ),
            if (isOnline)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        subtitle: type! == 'msg'
            ? Text(
                '$msg',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff999CA0),
                ),
              )
            : type! == 'image'
                ? const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Icon(
                          Icons.photo,
                          color: Color(0xff999CA0),
                          size: 17,
                        ),
                      ),
                      Text(
                     'image',
                       
                      )
                    ],
                  )
                : type! == 'image'
                    ? const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 3.0),
                            child: Icon(
                              Icons.video_camera_back_rounded,
                              color: Color(0xff999CA0),
                              size: 17,
                            ),
                          ),
                         Text(
                            'image',
                           
                          )
                        ],
                      )
                    : const SizedBox(),
        title: Text(
          '$title',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: fillColor,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

class ParticipantUserTile extends StatelessWidget {
  final String imagePath;
  final String titleText;
  final String actionTitle;

  const ParticipantUserTile({
    super.key,
    
    required this.actionTitle,
    required this.imagePath,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
     Container(
          width: double.infinity,
          height: 64,
          decoration: ShapeDecoration(
         
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
               side: const BorderSide(
           
            width: 0.5, 
          ),
            ),
            
          ),
          child: Row(
            children: [
               const SizedBox(width: 10,),
              CustomDisplayImage(
                imageUrl: imagePath,
              ),
             const SizedBox(width: 10,),
              Expanded(
                child: Text(
                  titleText,
                 
                ),
              ),
             Container(
                width: 82,
                height: 28,
                decoration: ShapeDecoration(
                  color: ColorConstants.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    actionTitle,
                   
                  ),
                ),
              ),
                const SizedBox(width: 10,),
            ],
          ),
        ),
      ],
    );
  }
}
