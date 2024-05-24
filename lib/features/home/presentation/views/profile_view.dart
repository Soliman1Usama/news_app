import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_watcher/features/home/presentation/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: ProfileViewBody(),
    );
  }

}