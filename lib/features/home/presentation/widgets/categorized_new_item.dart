import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_watcher/core/utils/styles.dart';
import 'package:news_watcher/core/widgets/loading_indicator.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CategorizedNewsItem extends StatefulWidget {
  const CategorizedNewsItem({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  State<CategorizedNewsItem> createState() => _CategorizedNewsItemState();
}

class _CategorizedNewsItemState extends State<CategorizedNewsItem> {
  @override
  Widget build(BuildContext context) {

    String? url = widget.articleModel.url;
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(

          onProgress: (int progress) {
            // Update loading bar.


          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},

        ),
      )..loadRequest(Uri.parse('$url'));


    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 30,
                    backgroundColor: const Color(0x00000000),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context); // This will pop the current screen off the navigation stack
                      },
                    ),
                  ),
                  body: WebViewWidget(controller: controller)
              );

            }),
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)), // Adjust radius as needed

          child: SizedBox(
            width: 345,
            height: 128,
            child: Stack(
              children: [
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      Center(child: SizedBox(width: 25, height: 25, child: LoadingIndicator())),
                  fit: BoxFit.fill,
                  width: width, imageUrl: widget.articleModel.image ?? '',
                ),
                // Container(
                //   height: 128,
                //   color: Colors.black.withOpacity(.2),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Text(
                    widget.articleModel.title,
                    style:
                        AppStyles.textStyleSemiBold14.copyWith(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                          Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1),
                          blurRadius: 13,
                        ),
                    ], ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 100, bottom: 10),
                  child: Text(
                    widget.articleModel.subtitle ?? 'Null',
                    style:
                        AppStyles.textStyleSemiBold12.copyWith(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0, 1),
                            blurRadius: 13,
                          ),
                        ],),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
