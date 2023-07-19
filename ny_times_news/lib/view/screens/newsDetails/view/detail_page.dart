import 'package:flutter/material.dart';
import 'package:ny_times_news/core/constants/app_constants.dart';
import 'package:ny_times_news/core/extensions/extension.dart';
import 'package:ny_times_news/view/common/common_appbar.dart';
import 'package:ny_times_news/view/screens/news/model/news_model.dart';
import 'package:ny_times_news/view/styles/colors.dart';

class NewsDetails extends StatefulWidget {
  final Result news;
  const NewsDetails({super.key, required this.news});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  String? date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(isHomePage: false, text: widget.news.title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            articleImage(context),
            Padding(
              padding: context.paddingDefault,
              child: articleTitle(),
            ),
            Padding(
              padding: context.paddingDefault,
              child: publishedDate(),
            ),
            Padding(
              padding: context.paddingDefault,
              child: Text(
                widget.news.resultAbstract,
                style: TextStyle(
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text publishedDate() {
    return Text(
      '${AppConstants.publishedDate}: ${widget.news.publishedDate.year}-${widget.news.publishedDate.month}-${widget.news.publishedDate.day}',
      style: TextStyle(
        color: Color(MyColors.purple01),
        fontSize: 15,
      ),
      textAlign: TextAlign.left,
    );
  }

  Text articleTitle() {
    return Text(
      widget.news.title,
      style: TextStyle(
        color: Color(MyColors.primary),
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
    );
  }

  Container articleImage(BuildContext context) {
    return Container(
      height: context.dynamicHeight * 0.2,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(MyColors.bg),
      ),
      child: widget.news.media.isNotEmpty
          ? FittedBox(
              fit: BoxFit.contain,
              child: Image.network(
                widget.news.media[0].mediaMetadata[2].url,
              ))
          : Center(
              child: Text(
                AppConstants.noImage,
                style: TextStyle(color: Color(MyColors.primary)),
              ),
            ),
    );
  }
}
