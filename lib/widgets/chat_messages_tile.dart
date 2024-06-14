import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';

class ChatMessageTile extends StatelessWidget {
  final String msg;
  final String time;

  final AlignmentGeometry alignment;

  const ChatMessageTile({
    super.key,
    required this.msg,
    this.alignment = Alignment.topRight,
    required this.time,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: shapeDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            msg,
                            style:
                                const TextStyle(fontSize: FontConstants.medium),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Text(
                          time,
                          style:
                              const TextStyle(fontSize: FontConstants.exsmall),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
