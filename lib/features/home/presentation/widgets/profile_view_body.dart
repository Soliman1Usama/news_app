import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watcher/constants.dart';
import 'package:news_watcher/core/utils/app_router.dart';
import 'package:news_watcher/core/utils/assets.dart';
import 'package:news_watcher/core/utils/styles.dart';
import 'package:news_watcher/features/auth/firebase_auth_implementaion/firebase_auth_services.dart';
import 'package:news_watcher/features/home/data/models/users_data.dart';
import 'package:provider/provider.dart';


class ProfileViewBody extends StatelessWidget {
   const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
           const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(AssetsData.userImage),
          ),
          const SizedBox(height: 50),
          itemProfile('Name', 'UserName', CupertinoIcons.person),
          const SizedBox(height: 20),
          itemProfile('Phone','**************', CupertinoIcons.phone),
          const SizedBox(height: 20),
          itemProfile(
              'Email', FirebaseAuthService.auth.currentUser?.email ?? 'You are logged out', CupertinoIcons.mail),
          const SizedBox(height: 50,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  FirebaseAuthService.auth.signOut();
                  GoRouter.of(context).push(AppRouter.kLogin);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.all(15),
                ),
                child: Text('Log Out',style: AppStyles.textStyleSemiBold14.copyWith(color: Colors.white),)
            ),
          )
        ],
      ),
    );
  }
   itemProfile(String title, String subtitle, IconData iconData) {
     return Container(
       decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(10),
           boxShadow: [
             BoxShadow(
                 offset: const Offset(0, 5),
                 color: Colors.black.withOpacity(.2),
                 spreadRadius: 2,
                 blurRadius: 10
             )
           ]
       ),
       child: ListTile(
         title: Text(title,style: AppStyles.textStyleBold16,),
         subtitle: Text(subtitle,style: AppStyles.textStyleSemiBold14,),
         leading: Icon(iconData),
         trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
         tileColor: Colors.white,
       ),
     );
   }

}



