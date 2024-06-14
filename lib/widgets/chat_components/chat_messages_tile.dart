import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/models/chat_models/chat_messages_model.dart';
import 'package:urgentrishtapp/utils/utils.dart';
import 'package:urgentrishtapp/widgets/custom_diaplay_image.dart';

class ChatMessageTile extends StatelessWidget {
  final ChatMessagesModel msg;
  final Color containerColor;
  final AlignmentGeometry alignment;
  final double? height;
  final double? width;

  const ChatMessageTile({
    super.key,
    required this.containerColor,
    required this.msg,
    this.alignment = Alignment.topRight,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    ShapeDecoration shapeDecoration;

    if (alignment == Alignment.topRight) {
      shapeDecoration = const ShapeDecoration(
        color: ColorConstants.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
        ),
      );
    } else {
      shapeDecoration = const ShapeDecoration(
         color: ColorConstants.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      );
    }

    return Align(
      alignment: alignment,
      child: Container(
        width: width,
        height: height,
        decoration: shapeDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: msg.type == 'msg'
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              msg.message!,   style: const TextStyle(fontSize: FontConstants.medium),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            msg.time == null
                                ? '   '
                                : convertDateTimeToOnlyTime(msg.time),
                            style: const TextStyle(fontSize: FontConstants.exsmall),
                          ),
                        ),
                      ],
                    )
                  : msg.type == 'image'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                  height: 300,
                                  width: 200,
                                  child: CustomDisplayImage(
                                    isOpenForMsg: true,
                                    height: 300,
                                    width: 200,
                                    imageUrl: msg.fileURL!,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                msg.time == null
                                    ? '   '
                                    : convertDateTimeToOnlyTime(msg.time),
                                style: const TextStyle(fontSize: FontConstants.exsmall),
                              ),
                            ),
                          ],
                        )
                      : Container(), // Handle other message types if any
            ),
          ],
        ),
      ),
    );
  }
}
