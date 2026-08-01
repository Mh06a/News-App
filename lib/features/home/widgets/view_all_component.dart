import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class ViewAllComponent extends StatelessWidget {
  //step1 -->> class's variables :
  final String title;
  final Color titleColor;
  final VoidCallback onTap;

  //step2 -->> Constructor :
  const ViewAllComponent({
    super.key,
    required this.title,
    required this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: AppSizes.font18,
              fontWeight: FontWeight.w600,
            ),
          ),

          InkWell(
            onTap: onTap,
            child: Text(
              "View all",
              style: TextStyle(
                color: titleColor,
                fontSize: AppSizes.font16,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationColor: titleColor,
                decorationThickness: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
