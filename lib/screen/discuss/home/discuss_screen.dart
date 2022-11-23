import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/screen/discuss/detail/detail_discuss_screen.dart';
import 'package:scoffee/screen/discuss/home/discuss_controller.dart';

import '../../../data/model/forum_model.dart';

class DiscussScreen extends StatelessWidget {
  const DiscussScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscussController>(
      init: DiscussController(),
      builder: (controller) {
        if (controller.state == DiscussViewState.loading) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Color(0xFF362204),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF362204),
          //   title: const Text(
          //     'Forum',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 24,
          //     ),
          //   ),
          //   centerTitle: true,
          // ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Color(0xFF674109),
                          width: 4,
                        )),
                      ),
                      child: const Text(
                        'Discuss',
                        style: TextStyle(
                            color: Color(0xFF674109),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.transparent,
                          width: 4,
                        )),
                      ),
                      child: const Text(
                        'Education',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listCategory.length,
                    itemBuilder: (context, index) {
                      var dataIndex = controller.listCategory[index];
                      return GestureDetector(
                        onTap: () {
                          // controller.pageController.animateToPage(
                          //   index,
                          //   duration: const Duration(milliseconds: 400),
                          //   curve: Curves.easeIn,
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            padding: const EdgeInsets.all(16.0),
                            curve: Curves.easeIn,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0xFF362204),
                            ),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: AppConst.baseImageCategoryUrl +
                                      dataIndex!.image!,
                                  fit: BoxFit.contain,
                                  errorWidget: (context, url, error) {
                                    return const SizedBox.shrink();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  dataIndex.name ?? '-',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      PagedSliverList<int, Data?>(
                        pagingController: controller.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Data?>(
                          itemBuilder: (context, item, index) {
                            var width = Get.width;
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const DetailDiscussScreen(),
                                  arguments: {
                                    'id': item.forumId,
                                    'comment': item.totalComment,
                                  },
                                )!
                                    .then((_) =>
                                        controller.pagingController.refresh());
                              },
                              child: Container(
                                color: Colors.white,
                                margin: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              const Color(0xFF362204),
                                          foregroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                            'assets/images/profile/profile.png',
                                          ),
                                          radius: 25,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          item!.name!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    CachedNetworkImage(
                                      imageUrl: AppConst.baseImagePostingUrl +
                                          item.image!,
                                      width: width,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 15.0,
                                            ),
                                            child: Text(
                                              item.description!,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Lihat ${item.totalComment} Komentar",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            elevation: 8,
            child: const Icon(
              Icons.edit,
            ),
          ),
        );
      },
    );
  }
}
