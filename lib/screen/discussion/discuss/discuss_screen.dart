import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/data/model/education_model.dart';
import 'package:scoffee/screen/discussion/add/add_discuss_screen.dart';
import 'package:scoffee/screen/discussion/detail/detail_discuss_screen.dart';
import 'package:scoffee/screen/discussion/detail/education/detail_education_screen.dart';
import 'package:scoffee/screen/discussion/discuss/discuss_controller.dart';

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
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.isDiscuss = true;
                        controller.categoryTerm =
                            controller.listCategory[0]!.name!;
                        controller.update();
                        controller.pagingController.refresh();
                        controller.pagingControllerEdu.refresh();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.bounceIn,
                        padding: const EdgeInsets.all(12.0),
                        decoration: controller.isDiscuss
                            ? const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: Color(0xFF674109),
                                  width: 4,
                                )),
                              )
                            : null,
                        child: Text(
                          'Discuss',
                          style: TextStyle(
                              color: controller.isDiscuss
                                  ? const Color(0xFF674109)
                                  : Colors.grey,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.isDiscuss = false;
                        controller.categoryTerm =
                            AppConst.listCategoryStatis[0];
                        controller.update();
                        controller.pagingController.refresh();
                        controller.pagingControllerEdu.refresh();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.bounceOut,
                        padding: const EdgeInsets.all(12.0),
                        decoration: controller.isDiscuss
                            ? null
                            : const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: Color(0xFF674109),
                                  width: 4,
                                )),
                              ),
                        child: Text(
                          'Education',
                          style: TextStyle(
                            color: controller.isDiscuss
                                ? Colors.grey
                                : const Color(0xFF674109),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
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
                    itemCount: controller.isDiscuss
                        ? controller.listCategory.length
                        : AppConst.listCategoryStatis.length,
                    itemBuilder: (context, index) {
                      var dataIndex = controller.listCategory[index];
                      if (!controller.isDiscuss) {
                        var statisIndex = AppConst.listCategoryStatis[index];

                        return GestureDetector(
                          onTap: () {
                            controller.categoryTerm = statisIndex;
                            controller.update();
                            controller.pagingController.refresh();
                            controller.pagingControllerEdu.refresh();
                            print(statisIndex);
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
                                color: controller.categoryTerm == statisIndex
                                    ? const Color(0xFFBF8E2C)
                                    : const Color(0xFF362204),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    statisIndex,
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
                      }
                      return GestureDetector(
                        onTap: () {
                          controller.categoryTerm = dataIndex.name!;
                          controller.indexCategory = dataIndex.id!;
                          controller.update();
                          controller.pagingController.refresh();
                          controller.pagingControllerEdu.refresh();
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
                              color: controller.categoryTerm == dataIndex!.name
                                  ? const Color(0xFFBF8E2C)
                                  : const Color(0xFF362204),
                            ),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: AppConst.baseImageCategoryUrl +
                                      dataIndex.image!,
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
                if (controller.isDiscuss == true)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => controller.pagingController.refresh(),
                      ),
                      child: CustomScrollView(
                        slivers: [
                          PagedSliverList<int, Data?>.separated(
                            pagingController: controller.pagingController,
                            separatorBuilder: (context, index) =>
                                const Divider(thickness: 2),
                            builderDelegate: PagedChildBuilderDelegate<Data?>(
                              itemBuilder: (context, item, index) {
                                var width = Get.width;
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => const DetailDiscussScreen(),
                                      arguments: {
                                        'id': item.forumId,
                                      },
                                    )!
                                        .then((_) => controller.pagingController
                                            .refresh());
                                  },
                                  onDoubleTap: () {
                                    controller.postLike(item.forumId!);
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    margin: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            item!.userImage !=
                                                null
                                                ? CircleAvatar(
                                              backgroundColor:
                                              const Color(0xFF362204),
                                              foregroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                AppConst.baseImageProfileUrl +
                                                    item.userImage!,
                                              ),
                                              maxRadius: 25,
                                            )
                                                : const CircleAvatar(
                                              backgroundColor:
                                              Color(0xFF362204),
                                              foregroundColor: Colors.white,
                                              backgroundImage: AssetImage(
                                                'assets/images/profile/profile.png',
                                              ),
                                              maxRadius: 25,
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              item?.name ?? '-',
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
                                        if (item!.image != null)
                                          CachedNetworkImage(
                                            imageUrl:
                                                AppConst.baseImagePostingUrl +
                                                    item.image!,
                                            width: width,
                                            height: 350,
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
                                          child: Row(
                                            children: [
                                              const Icon(
                                                  Icons.mode_comment_outlined),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                "${item.totalComment}",
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              const Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                "${item.totalLike}",
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
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
                  ),
                if (controller.isDiscuss == false)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => controller.pagingControllerEdu.refresh(),
                      ),
                      child: CustomScrollView(
                        slivers: [
                          PagedSliverList<int, DataEdu?>(
                            pagingController: controller.pagingControllerEdu,
                            builderDelegate:
                                PagedChildBuilderDelegate<DataEdu?>(
                              animateTransitions: true,
                              itemBuilder: (context, item, index) {
                                var width = Get.width;
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => const DetailEducationScreen(),
                                        arguments: {
                                          'id': item.id,
                                        },
                                      );
                                    },
                                    child: Card(
                                      elevation: 8,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                        side: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                AppConst.baseImageEducationUrl +
                                                    item!.image!,
                                            width: width,
                                            height: 180,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) {
                                              return const SizedBox.shrink();
                                            },
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    item.title ?? '-',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: const EdgeInsets.only(
                                                      top: 8.0),
                                                  child: Text(
                                                    item.body
                                                            ?.replaceAll(
                                                                '<p>', '')
                                                            .replaceAll(
                                                                '</p>', '') ??
                                                        '-',
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: controller.isDiscuss
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(
                      () => const AddDiscussScreen(),
                      arguments: {
                        'id': controller.indexCategory,
                      },
                    )!
                        .then((_) => controller.pagingController.refresh());
                  },
                  elevation: 8,
                  child: const Icon(
                    Icons.edit,
                  ),
                )
              : null,
        );
      },
    );
  }
}
