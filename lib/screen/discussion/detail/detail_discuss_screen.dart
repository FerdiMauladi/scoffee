import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/screen/discussion/detail/detail_discuss_controller.dart';
import 'package:scoffee/screen/discussion/discuss/discuss_screen.dart';
import '../../../data/model/detail_discuss_model.dart';

class DetailDiscussScreen extends StatelessWidget {
  const DetailDiscussScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailDiscussController>(
      init: DetailDiscussController(),
      didChangeDependencies: (state) {
        state.controller!.pagingController.refresh();
      },
      builder: (controller) {
        if (controller.state == DetailDiscussViewState.loading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Comments',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF362204),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Get.offAll(() => const DiscussScreen());
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Color(0xFF362204),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF362204),
            title: const Text(
              'Comments',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => controller.pagingController.refresh(),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 25.0,
                          ),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          )),
                          child: Column(
                            children: [
                              Container(
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
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          controller.detailForums.forums!.user!,
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
                                    if (controller.detailForums.forums!.image !=
                                        null)
                                      CachedNetworkImage(
                                        imageUrl: AppConst.baseImagePostingUrl +
                                            controller
                                                .detailForums.forums!.image!,
                                        width: Get.width,
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
                                              controller.detailForums.forums!
                                                  .description!,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      PagedSliverList<int, Data?>(
                        pagingController: controller.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Data?>(
                          itemBuilder: (context, item, index) {
                            var width = Get.width;
                            return Container(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              margin: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xFF362204),
                                        foregroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                          'assets/images/profile/profile.png',
                                        ),
                                        radius: 15,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item?.user ?? '-',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              item?.content ?? '-',
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                              ),
                                              maxLines: 5,
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 75,
                decoration: const BoxDecoration(
                  color: Color(0xFF362204),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF362204),
                      foregroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        'assets/images/profile/profile.png',
                      ),
                      radius: 25,
                    ),
                    SizedBox(
                      height: 60,
                      width: Get.width * 0.65,
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: controller.commentController,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          hintText: 'Masukan komentar anda...',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: controller.commentController.text.isEmpty
                            ? null
                            : () {
                                controller
                                    .postComment(
                                        controller.detailForums.forums!.id!)
                                    .then((_) {
                                  controller.commentController.clear();
                                  controller.pagingController.refresh();
                                  controller.update();
                                });
                              },
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                            color: controller.commentController.text.isEmpty
                                ? Colors.grey
                                : Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
