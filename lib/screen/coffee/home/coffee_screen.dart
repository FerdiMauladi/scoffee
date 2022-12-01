import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/screen/coffee/detail/detail_coffee_screen.dart';
import 'package:scoffee/screen/coffee/home/coffee_controller.dart';

import '../../../data/model/coffee_model.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoffeeController>(
      init: CoffeeController(),
      builder: (controller) {
        if (controller.state == CoffeeViewState.loading) {
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
          //     'Home',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 24,
          //     ),
          //   ),
          //   centerTitle: true,
          // ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hallo, ${controller.userModel.name}',
                                style: TextStyle(
                                  color: const Color(0xFF674109),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Semoga harimu menyenangkan...',
                                style: TextStyle(
                                  color: const Color(0xFF674109),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/icon/coffee.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => controller.pagingController.refresh(),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        PagedSliverGrid<int, Data?>(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            childAspectRatio: 3 / 2,
                          ),
                          pagingController: controller.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<Data?>(
                            itemBuilder: (context, item, index) {
                              var width = Get.width;
                              var height = Get.height;
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => const DetailCoffeeScreen(),
                                      arguments: {
                                        'id': item.id,
                                      },
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: width,
                                        height: height * 0.4,
                                      ),
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: width * 0.8,
                                          height: height * 0.4,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                image: NetworkImage(AppConst
                                                        .baseImageCoffeeUrl +
                                                    item!.image!),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            item.name!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(4.0, 4.0),
                                                  blurRadius: 8.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
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
                ),
              ],
            ),
          ),
          // body: SafeArea(
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Hallo, Ferdi',
          //               style: TextStyle(
          //                 color: const Color(0xFF674109),
          //                 fontSize: 24,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             Text(
          //               'Semoga harimu menyenangkan...',
          //               style: TextStyle(
          //                 color: const Color(0xFF674109),
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.w400,
          //               ),
          //             ),
          //             const SizedBox(
          //               height: 25,
          //             ),
          //             Material(
          //               elevation: 5,
          //               shadowColor: const Color(0xFF362204),
          //               color: Colors.white,
          //               borderRadius: const BorderRadius.all(
          //                 Radius.circular(15),
          //               ),
          //               child: TextField(
          //                 controller: controller.searchController,
          //                 onChanged: (dataSearch) {
          //
          //                 },
          //                 decoration: const InputDecoration(
          //                   fillColor: Colors.white,
          //                   hintText: 'Cari di scoffee',
          //                   border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.all(
          //                       Radius.circular(15),
          //                     ),
          //                   ),
          //                   prefixIcon: Icon(
          //                     Icons.search,
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: AppConst.dataKategori.map(
          //             (dataIndex) {
          //               var index = AppConst.dataKategori.indexOf(dataIndex);
          //               return GestureDetector(
          //                 onTap: () {
          //                   controller.pageController.animateToPage(
          //                     index,
          //                     duration: const Duration(milliseconds: 400),
          //                     curve: Curves.easeIn,
          //                   );
          //                 },
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: AnimatedContainer(
          //                     duration: const Duration(milliseconds: 400),
          //                     padding: const EdgeInsets.all(16.0),
          //                     curve: Curves.easeIn,
          //                     alignment: Alignment.center,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(8.0),
          //                       color: controller.currentPage == index
          //                           ? const Color(0xFF674109)
          //                           : const Color(0xFF362204),
          //                     ),
          //                     child: Text(
          //                       dataIndex,
          //                       style: const TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           ).toList(),
          //         ),
          //       ),
          //       Expanded(
          //         child: PageView.builder(
          //           controller: controller.pageController,
          //           physics: const BouncingScrollPhysics(),
          //           itemCount: controller.listAllDummy.length,
          //           onPageChanged: (int index) {
          //             controller.currentPage = index;
          //             controller.searchController.clear();
          //             controller.listAllDummy =
          //                 List.from(controller.listAllDataDummy);
          //             controller.update();
          //           },
          //           itemBuilder: (context, index) {
          //             var dataList = controller.listAllDummy[index];
          //             print(dataList);
          //             return CustomScrollView(
          //               physics: const AlwaysScrollableScrollPhysics(
          //                 parent: BouncingScrollPhysics(),
          //               ),
          //               slivers: [
          //                 if (dataList.isEmpty)
          //                   SliverFillRemaining(
          //                     hasScrollBody: false,
          //                     child: Container(
          //                       margin:
          //                           const EdgeInsets.only(top: 10, bottom: 10),
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Container(
          //                             margin: const EdgeInsets.only(top: 10),
          //                             padding: const EdgeInsets.only(
          //                                 left: 20, right: 20),
          //                             child: const Text(
          //                               'Data Masih Kosong',
          //                               textAlign: TextAlign.center,
          //                               style: TextStyle(
          //                                 fontSize: 24,
          //                                 color: Colors.black,
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 SliverList(
          //                   delegate: SliverChildBuilderDelegate(
          //                     (context, index) {
          //                       final listDataIndex = dataList[index];
          //                       var width = Get.width;
          //                       var height = Get.height;
          //                       return Padding(
          //                         padding: const EdgeInsets.all(16.0),
          //                         child: Stack(
          //                           children: [
          //                             SizedBox(
          //                               width: width,
          //                               height: height * 0.4,
          //                             ),
          //                             Positioned(
          //                               top: 0,
          //                               bottom: 0,
          //                               left: 0,
          //                               right: 0,
          //                               child: Container(
          //                                 alignment: Alignment.center,
          //                                 width: width * 0.8,
          //                                 height: height * 0.4,
          //                                 decoration: BoxDecoration(
          //                                     borderRadius:
          //                                         BorderRadius.circular(8.0),
          //                                     image: DecorationImage(
          //                                       image: NetworkImage(
          //                                           listDataIndex.image),
          //                                       fit: BoxFit.cover,
          //                                     )),
          //                               ),
          //                             ),
          //                             Positioned(
          //                               bottom: 10,
          //                               left: 0,
          //                               right: 0,
          //                               child: Padding(
          //                                 padding: const EdgeInsets.all(8.0),
          //                                 child: Text(
          //                                   listDataIndex.title,
          //                                   style: TextStyle(
          //                                     color: Colors.white,
          //                                     fontWeight: FontWeight.bold,
          //                                     fontSize: 24,
          //                                     shadows: <Shadow>[
          //                                       Shadow(
          //                                         offset: Offset(4.0, 4.0),
          //                                         blurRadius: 8.0,
          //                                         color: Colors.black,
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     },
          //                     childCount: dataList.length,
          //                   ),
          //                 ),
          //               ],
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
