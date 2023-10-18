import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/app/modules/trend/views/widget/article_model.dart';
import 'package:project/app/utils/widgets/bottom_nav_bar.dart';
import 'package:project/app/utils/widgets/productCard.dart';

import '../controllers/trend_controller.dart';

class TrendView extends GetView<TrendController> {
  const TrendView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['All', 'Skincare', 'Bodycare', 'Haircare'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBar: const BottomNavBar(index: 2),
        body: Container(
          color: Colors.white, // Set the desired background color
          child: ListView(
            padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
            children: [const _DiscoverNews(), _CategoryNews(tabs: tabs)],
          ),
        ),
      ),
    );
  }
}

class _CategoryNews extends StatelessWidget {
  const _CategoryNews({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    final articles = Article.articles;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(height: 5),
                ProductCard(
                  imageAsset: 'lib/aset/product/or1.jpg',
                  productName: 'The Ordinary Moisturizer',
                  productPrice: 'RP. 270.000',
                ),
                ProductCard(
                  imageAsset: 'lib/aset/product/skintint.png',
                  productName: 'Somethinc Salmon DNA',
                  productPrice: 'RP. 120.000',
                ),
                ProductCard(
                  imageAsset: 'lib/aset/product/2.webp',
                  productName: 'The Ordinary Serum',
                  productPrice: 'RP. 500.000',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        TabBar(
          isScrollable: true,
          indicatorColor: Colors.brown,
          tabs: tabs
              .map(
                (tab) => Tab(
                  icon: Text(
                    tab,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            children: tabs
                .map(
                  (tab) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   // ArticleScreen.routeName,
                          //   arguments: articles[index],
                          // );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.asset(
                                articles[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    articles[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                '${articles[index].author}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite,
                                            size: 18,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${articles[index].views} like',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _DiscoverNews extends StatelessWidget {
  const _DiscoverNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'For Your Trend!!',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Text(
            'Find New Trend Skincare all over the world',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.tune,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
