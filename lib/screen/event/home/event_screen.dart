import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/data/model/event_model.dart';
import 'package:scoffee/screen/event/detail/detail_event_screen.dart';
import 'package:scoffee/screen/event/home/event_controller.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      init: EventController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF362204),
            title: const Text(
              'Event',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              PagedSliverGrid<int, Data?>(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3/2,
                ),
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Data?>(
                  itemBuilder: (context, item, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                              () => const DetailEventScreen(),
                          arguments: {
                            'id': item.id,
                          },
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(14.0),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 16.0,
                                bottom: 8.0,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      AppConst.baseImageEventUrl + item!.image!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item.title ?? '-',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
