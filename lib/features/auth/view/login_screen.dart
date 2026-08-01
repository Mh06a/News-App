import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/view/register_screen.dart';
import 'package:news_app/features/user/repository/user_repository.dart';
import 'package:news_app/main_screen.dart';
import 'package:news_app/shared/custom_button.dart';
import 'package:news_app/shared/custom_nav_butoon.dart';
import 'package:news_app/shared/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (_) => AuthCubit(UserRepository()),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_image.png"),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.w16),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/news_image.png",
                              height: 74,
                            ),
                          ),

                          SizedBox(height: AppSizes.h40),

                          Text(
                            "Welcome to Newts",
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: AppSizes.font20,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                          ),

                          SizedBox(height: AppSizes.h16),

                          CustomTextField(
                            titleText: "Email",
                            hintText: "mansour@gmail.com",
                            myController: emailController,
                            validatorText: "Please Enter your email.",
                          ),

                          SizedBox(height: AppSizes.h12),

                          CustomTextField(
                            titleText: "Password",
                            hintText: "**********",
                            myController: passwordController,
                            validatorText: "Please Enter your password.",
                            obscureText: true,
                          ),

                          SizedBox(height: AppSizes.h8),
                          Text(
                            state.errorMessage ?? "",
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: AppSizes.font15,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: AppSizes.h24),

                          CustomButton(
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                final success = await context
                                    .read<AuthCubit>()
                                    .login(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    );

                                if (success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const MainScreen(),
                                    ),
                                  );
                                }
                              }
                            },
                            buttonText: "Sig In",
                          ),

                          SizedBox(height: AppSizes.h24),

                          CustomNavButoon(
                            title: "Don’t have an account ?",
                            secondTitle: "Sign Up",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
