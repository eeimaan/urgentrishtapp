
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/text_constant.dart';

class ButtonWidget extends StatefulWidget {
  final String text;
  final double width;
  final void Function()? onPressed; 
  final Color btnColor;
  final Color textColor;

  const ButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
    required this.width,
    required this.btnColor,
    required this.textColor,
  }) : super(key: key);

  @override
  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async {
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
            if (widget.onPressed != null) {
              widget.onPressed!(); // No need to await
            }
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Container(
          height: 40,
          width: widget.width,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(15),
            color: widget.btnColor,
          ),
          child: Center(
            child: isLoading
                ? const    CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor,
                      letterSpacing: 0.50,
                      fontSize: FontConstants.medium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
