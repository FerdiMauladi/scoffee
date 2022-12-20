import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/screen/discussion/detail/detail_discuss_screen.dart';
import 'package:scoffee/screen/discussion/update/update_discuss_screen.dart';
import 'package:scoffee/screen/profile/home/profile_home_controller.dart';
import 'package:scoffee/screen/profile/update/profile_update_screen.dart';

import '../../../data/model/forum_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.state == ProfileViewState.loading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF362204),
              centerTitle: true,
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
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF362204),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(() {
                controller.pagingController.itemList!.clear();
                controller.pagingController.refresh();
                controller.getUser();
              }),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 20.0,
                            ),
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: controller.userModel.userDetail!.image !=
                                    null
                                ? CircleAvatar(
                                    backgroundColor: const Color(0xFF362204),
                                    foregroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        AppConst.baseImageProfileUrl +
                                            controller
                                                .userModel.userDetail!.image!),
                                    maxRadius: 80,
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Color(0xFF362204),
                                    foregroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                      'assets/images/profile/profile.png',
                                    ),
                                    maxRadius: 80,
                                  ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.3,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(
                                        () => const ProfileUpdateScreen(),
                                      )!
                                          .then((_) {
                                        controller.getUser();
                                        controller.pagingController.refresh();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFBF8E2C),
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      elevation: 2,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Update Profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                  width: Get.width * 0.3,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.logout();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      elevation: 2,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'LOGOUT',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            controller.userModel.name ?? '-',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.userModel.email ?? '-',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          if (controller.userModel.userDetail?.description !=
                              null)
                            Text(
                              controller.userModel.userDetail?.description ??
                                  '-',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          if (controller.userModel.userDetail?.born != null)
                            Text(
                              "Born ${controller.userModel.userDetail?.born}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          if (controller.userModel.userDetail?.academic != null)
                            Text(
                              "Last Education ${controller.userModel.userDetail?.academic}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          if (controller.userModel.userDetail?.work != null)
                            Text(
                              "Work in ${controller.userModel.userDetail?.work}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 8.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFF362204),
                            width: 4,
                          ),
                        ),
                      ),
                      child: const Text(
                        'My Posts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 4,
                    ),
                    PagedListView<int, Data?>.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                                  .then((_) =>
                                      controller.pagingController.refresh());
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
                                      item!.userImage != null
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
                                        item.name ?? '-',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      PopupMenuButton(
                                        onSelected: (value) {
                                          if (value == 'delete') {
                                            controller
                                                .postDelete(item.forumId!);
                                          }
                                          if (value == 'edit') {
                                            Get.to(
                                              () => const UpdateDiscussScreen(),
                                              arguments: {
                                                'id': item.forumId,
                                              },
                                            );
                                          }
                                        },
                                        padding: EdgeInsets.zero,
                                        position: PopupMenuPosition.under,
                                        itemBuilder: (BuildContext bc) {
                                          return const [
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: Text("Edit"),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Text("Delete"),
                                            ),
                                          ];
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  if (item.image != null)
                                    CachedNetworkImage(
                                      imageUrl: AppConst.baseImagePostingUrl +
                                          item.image!,
                                      width: width,
                                      height: 350,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        const Icon(Icons.mode_comment_outlined),
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
          ),
        );
      },
    );
  }
}
