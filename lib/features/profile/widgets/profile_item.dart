import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/shared/custom_svg_picture.dart';

class ProfileItem extends StatelessWidget {
  //step1 -->> class's variables :
  final String title;
  final Widget leadingIcon;
  final VoidCallback onTap;
  final Color? color;

  //step2 -->> class's Con :
  const ProfileItem({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: leadingIcon,

          title: Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.font18,
              fontWeight: FontWeight.w400,
              color: color ?? AppColors.fourthText,
            ),
          ),

          trailing: CustomSvgPicture(
            path: "assets/icons/higher_arrow.svg",
            height: AppSizes.h12,
            width: AppSizes.w6,
            color: color,
          ),
        ),

        Divider(color: AppColors.divider),
      ],
    );
  }
}
