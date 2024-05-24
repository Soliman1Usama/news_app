import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watcher/constants.dart';
import 'package:news_watcher/core/utils/app_router.dart';
import 'package:news_watcher/core/utils/styles.dart';

class CustomHomeViewAppBar extends StatelessWidget {
  const CustomHomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 46),
      child: Row(
        children: [
          SizedBox(
              height: 32,
              width: width * .8,
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    // Set border color to grey
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  filled: true,
                  hintStyle: AppStyles.textStyleSemiBold12,
                  hintText: "Dogecoin to the Moon...",
                  fillColor: Colors.white70,
                ),
              )),
          const Spacer(),
          GestureDetector(
            onTap: (){
              GoRouter.of(context).push(AppRouter.kProfile);

            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(18)),
              child: Center(
                child: Icon(
                  size: 20,
                  Icons.person,
                  color: Colors.white,
                )),
              ),
          ),

        ],
      ),
    );
  }
}
