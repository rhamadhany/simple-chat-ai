import 'package:chat_ai/app/modules/home/views/dialog_list_model_ai.dart';
import 'package:chat_ai/app/modules/home/views/drawer_home.dart';
import 'package:chat_ai/app/modules/home/views/message_input.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      drawer: DrawerHome(),
      appBar: AppBar(
        title: const Text(
          'Chat AI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                Get.dialog(DialogListModelAI());
              },
              child: Text(controller.selectedModel.value.name),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.messages.length,
                  controller: controller.scrollController,
                  padding: EdgeInsets.only(bottom: Get.height * 0.25),
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];

                    return Container(
                      alignment: message.user
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          color: message.user
                              ? const Color.fromARGB(255, 154, 70, 214)
                              : const Color.fromARGB(255, 255, 242, 202),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.message,
                              style: TextStyle(
                                color: message.user
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              message.time.formatDays,
                              style: TextStyle(
                                fontSize: 12,
                                color: message.user
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            MessageInput(controller: controller),
          ],
        ),
      ),

      // bottomNavigationBar:
    );
  }
}
