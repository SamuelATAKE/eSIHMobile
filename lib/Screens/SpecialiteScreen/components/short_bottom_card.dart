import 'package:esihapp/Screens/SpecialiteScreen/components/style.dart';
import 'package:flutter/material.dart';

class ShortBottomCard extends StatelessWidget {
  final Color background;
  final String title;
  final String subtitle;
  final String image;
  final Function()? onPress;
  const ShortBottomCard(
      {Key? key,
        required this.background,
        required this.title,
        required this.subtitle,
        required this.image,
        this.onPress
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        width: 155,
        height: 163,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: Colors.white, width: 10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 50,
                  color: const Color(0xFF0B0C2A).withOpacity(.09),
                  offset: const Offset(10, 10))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 8),
          Expanded(child: Image.asset(image)),
          Text(title, style: AppStyle.m12w),
          Text(subtitle, style: AppStyle.r10wt),
          const SizedBox(height: 12),
        ]),
      ),
    );
  }

}
