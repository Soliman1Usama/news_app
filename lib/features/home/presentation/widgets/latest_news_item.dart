import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_watcher/core/utils/assets.dart';
import 'package:news_watcher/core/utils/styles.dart';
import 'package:news_watcher/core/widgets/loading_indicator.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LatestNewsItem extends StatefulWidget {
  const LatestNewsItem({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  State<LatestNewsItem> createState() => _LatestNewsItemState();
}

class _LatestNewsItemState extends State<LatestNewsItem> {
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
      )
      ..loadRequest(Uri.parse('$url'));
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 30,
                  backgroundColor: const Color(0x00000000),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(
                          context); // This will pop the current screen off the navigation stack
                    },
                  ),
                ),
                body: WebViewWidget(controller: controller));
          }),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        // Adjust radius as needed

        child: SizedBox(
          width: 321,
          height: 240,
          child: Stack(
            children: [
              CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) =>
                    Center(child: SizedBox(width: 25, height: 25, child: LoadingIndicator())),
                imageUrl: widget.articleModel.image ?? '',
                height: 240,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                height: 240,
                color: Colors.black.withOpacity(.2),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 8, left: 8, top: 94, bottom: 75),
                child: Text(
                  widget.articleModel.title,
                  style: AppStyles.textStyleBold16.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 1),
                        blurRadius: 13,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 8,
                  top: 180,
                ),
                child: Text(
                  widget.articleModel.subtitle ?? 'Empty',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleRegular12.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 1),
                        blurRadius: 13,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
