import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watcher/constants.dart';
import 'package:news_watcher/core/utils/app_router.dart';

import 'package:news_watcher/core/utils/toast.dart';
import 'package:news_watcher/core/widgets/custom_button.dart';
import 'package:news_watcher/core/widgets/custom_text_field.dart';
import 'package:news_watcher/core/widgets/loading_indicator.dart';
import 'package:news_watcher/features/auth/firebase_auth_implementaion/firebase_auth_services.dart';

class SignUpTextFieldsContainer extends StatefulWidget {
  const SignUpTextFieldsContainer({
    super.key,
  });

  @override
  State<SignUpTextFieldsContainer> createState() => _SignUpTextFieldsContainerState();
}

class _SignUpTextFieldsContainerState extends State<SignUpTextFieldsContainer> {
  final FirebaseAuthService _auth = FirebaseAuthService();


  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSigningUp = false;



  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.only(top: 35-17, left: 20, right: 30),
          child: Form(
            key: _formKey,

            child: Column(
              children: [
                CustomTextFiled(
                  controller: _usernameController,
                  passwordHide: false,
                  hintText: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },

                ),
                CustomTextFiled(
                  controller: _phoneController,
                  passwordHide: false,
                  hintText: 'Phone',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                CustomTextFiled(
                  controller: _emailController,
                  passwordHide: false,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                CustomTextFiled(
                  controller: _passwordController,
                  passwordHide: true,
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: isSigningUp
                      ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: LoadingIndicator(),
                      )
                      : CustomButton(
                    onPressed: _signUp,
                    backgroundColor: kPrimaryColor,
                    text: 'create an account',
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    buttonWidth: 343,
                    buttonHeight: 43,
                  ),
                ),

              ],
            ),
          )),
    );
  }
  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSigningUp = true;
      });

      final String username = _usernameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      final User? user =
      await _auth.signUpWithEmailAndPassword(email, password);

      setState(() {
        isSigningUp = false;
      });

      if (user != null) {
        await addUserDetails(_phoneController.text.trim(), username);
        showToast(message: "User successfully created");
        GoRouter.of(context).push(AppRouter.kHome);
      } else {
        showToast(message: "Some error occurred");
      }
    }
  }

  Future<void> addUserDetails(String phone, String username) async {
    await FirebaseFirestore.instance.collection('users').add({
      'phone': phone,
      'username': username,
      'uid': FirebaseAuth.instance.currentUser?.uid,
    });
  }

}
