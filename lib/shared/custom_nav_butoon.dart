import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';

class CustomNavButoon extends StatelessWidget {
  //step1 -->>  Class variables :
  final String title;
  final String secondTitle;
  final void Function()? onTap;

  //step2 -->> Constructor :
  const CustomNavButoon({
    super.key,
    required this.title,
    required this.secondTitle,
    required this.onTap,
  });

  //step3 -->> call a build function :
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textThirdColor,
            fontSize: AppSizes.font16,
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(width: AppSizes.w8),

        InkWell(
          onTap: onTap,
          child: Text(
            secondTitle,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
