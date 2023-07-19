import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ny_times_news/core/constants/app_contants.dart';
import 'package:ny_times_news/core/extensions/extension.dart';
import 'package:ny_times_news/view/common/common_appbar.dart';
import 'package:ny_times_news/view/common/common_loading.dart';
import 'package:ny_times_news/view/screens/news/service/most_popular_service.dart';
import 'package:ny_times_news/view/screens/newsDetails/view/detail_page.dart';
import 'package:ny_times_news/view/styles/colors.dart';
import 'package:ny_times_news/view/styles/styles.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  Widget build(BuildContext context) {
    var get = ref.watch(getMostPopularNews);
    return Scaffold(
      appBar: const CommonAppbar(
        isHomePage: true,
        text: AppConstants.title,
      ),
      drawer: Drawer(
        backgroundColor: Color(MyColors.bg),
      ),
      body: get.when(
        loading: () => const CommonLoading(),
        error: (error, stackTrace) {
          return Center(
            child: Text('${AppConstants.error} ${error.toString()}'),
          );
        },
        data: (data) {
          var list = data.map((e) => e).toList();
          List<dynamic> sortedData = sortDataByDate(list);
          return SizedBox(
            height: context.dynamicHeight * 0.9,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsDetails(
                                  news: sortedData[index],
                                )));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(MyColors.bg01),
                      child: list[index].media.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                sortedData[index].media[0].mediaMetadata[0].url,
                                fit: BoxFit.contain,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sortedData[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          sortedData[index].byline,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sortedData[index].section,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                SizedBox(
                                  width: context.dynamicWidth * 0.005,
                                ),
                                Text(
                                  '${sortedData[index].publishedDate.year}-${sortedData[index].publishedDate.month}-${sortedData[index].publishedDate.day}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  List<dynamic> sortDataByDate(List<dynamic> data) {
    data.sort((a, b) {
      DateTime dateA = a.publishedDate;
      DateTime dateB = b.publishedDate;
      return dateB.compareTo(dateA);
    });
    return data;
  }
}
