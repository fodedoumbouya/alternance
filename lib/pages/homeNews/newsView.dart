import 'package:flutter/material.dart';

import 'package:internship/base/baseWidget.dart';
import 'package:internship/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends BaseWidget {
  final News news;
  const NewsView({required this.news, super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _NewsViewState();
  }
}

class _NewsViewState extends BaseWidgetState<NewsView> {
  Future<void> _launchUrl({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Impossible de lancer $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _launchUrl(url: widget.news.url ?? "");
      },
      child: Column(
        children: [
          Divider(
            color: bcGrey().withOpacity(0.5),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: c(
                        child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: c(
                              alig: Alignment.centerLeft,
                              child: txtw(widget.news.title ?? "",
                                  maxLines: 2,
                                  fontWeight: FontWeight.bold,
                                  size: xx(4.5)),
                            )),
                        Expanded(
                          flex: 3,
                          child: c(
                            alig: Alignment.bottomCenter,
                            child: txtw(widget.news.description ?? "",
                                maxLines: 3,
                                color: Colors.grey[600],
                                size: xx(3)),
                          ),
                        )
                      ],
                    ))),
                widget.news.urlToImage == null
                    ? sb
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(xx(2)),
                        child: imgw(
                          widget.news.urlToImage ?? "",
                          fit: BoxFit.cover,
                          width: xx(35),
                          height: yy(14),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
