import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/shared/custom_button.dart';
import 'package:news_app/shared/custom_text_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  final String userName;
  final String email;
  const ProfileInfoBottomSheet({
    super.key,
    required this.userName,
    required this.email,
  });

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController.text = widget.userName;
    emailController.text = widget.email;
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void save() {
    if (!formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      "userName": userNameController.text.trim(),
      "email": emailController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.w16),
      height: MediaQuery.of(context).size.height * 0.50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r18)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: AppSizes.w45,
                    height: AppSizes.h4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(AppSizes.r20),
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.h20),

                Text(
                  "Profile Info",
                  style: TextStyle(
                    fontSize: AppSizes.font18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textThirdColor,
                  ),
                ),

                SizedBox(height: AppSizes.h20),

                CustomTextField(
                  titleText: "User Name",
                  hintText: "User Name",
                  myController: userNameController,
                  validatorText: "Please Enter User Name",
                ),

                SizedBox(height: AppSizes.h16),

                CustomTextField(
                  titleText: "Email",
                  hintText: "Email",
                  myController: emailController,
                  validatorText: "Please Enter Email",
                ),

                SizedBox(height: AppSizes.h30),

                CustomButton(buttonText: "Save", onPressed: save),

                SizedBox(height: AppSizes.h16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
