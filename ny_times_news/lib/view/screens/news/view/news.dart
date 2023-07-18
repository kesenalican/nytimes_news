import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ny_times_news/core/constants/app_contants.dart';
import 'package:ny_times_news/core/extensions/extension.dart';
import 'package:ny_times_news/view/common/common_loading.dart';
import 'package:ny_times_news/view/screens/news/service/most_popular_service.dart';
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          AppConstants.title,
          style: kTitleStyle,
        ),
        elevation: 10,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color:
                    Color(MyColors.primary), // Change Custom Drawer Icon Color
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Color(MyColors.primary),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Color(MyColors.primary),
              )),
        ],
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
         
          return SizedBox(
            height: context.dynamicHeight * 0.9,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var day = list[index].publishedDate.day;
                var month = list[index].publishedDate.month;
                var year = list[index].publishedDate.year;
                var date = '$year-$month-$day';

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(MyColors.bg01),
                    child: Image.network(
                        list[index].media[0].mediaMetadata[0].url),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        list[index].byline,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, color: Colors.black.withOpacity(0.5)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'THOMPSON',
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
                                date,
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
