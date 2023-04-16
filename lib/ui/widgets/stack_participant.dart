import 'package:event_app/app/configs/colors.dart';
import 'package:flutter/material.dart';

class StackParticipant extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final double positionText;
  const StackParticipant(
      {required this.fontSize,
      required this.width,
      required this.height,
      required this.positionText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.whiteColor,
                width: 2,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.whiteColor,
                width: 2,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 32,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.whiteColor,
                width: 2,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 48,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.whiteColor,
                width: 2,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 64,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.whiteColor,
                width: 2,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: positionText,
          child: Text(
            "",
            style: TextStyle(color: AppColors.primaryColor, fontSize: fontSize),
          ),
        )
      ],
    );
  }
}
