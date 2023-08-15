import 'package:flutter/material.dart';

import 'package:internship/base/baseWidget.dart';
import 'package:internship/models/models.dart';
import 'package:internship/pages/homeNews/newsView.dart';

class HomeNews extends BaseWidget {
  const HomeNews({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _HomeNewsState();
  }
}

class _HomeNewsState extends BaseWidgetState<HomeNews> {
  List<News> listNews = [];
  bool isLoadingData = false;
  int index = 0;

  // Recuperation des donnees
  getData() {
    getMap(
        searchName: "tesla",
        callback: (callback) {
          if (callback["status"] == "ok") {
            for (var news in callback["articles"]) {
              listNews.add(News.fromJson(news));
            }
            if (listNews.length >= 20) {
              index = 20;
            } else {
              index = listNews.length;
            }
          }
          isLoadingData = true;
          rebuidState();
        });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (p0, p1) {
        Size s = p1.biggest;
        return c(
          h: s.height,
          w: s.width,
          child: Column(
            children: [
              c(
                  h: yy(14, widgetSize: s),
                  w: s.width,
                  alig: Alignment.bottomLeft,
                  leftM: xx(2),
                  child:
                      txtw("News", fontWeight: FontWeight.bold, size: xx(10))),
              Expanded(
                child: isLoadingData
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: index,
                        itemBuilder: (context, index) {
                          News news = listNews[index];
                          return c(
                            h: yy(17, widgetSize: s),
                            w: s.width,
                            allM: 4,
                            allP: 2,
                            child: NewsView(news: news),
                          );
                        },
                      )
                    : const Center(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
