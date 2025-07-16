import 'package:chat_ai/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogListModelAI extends GetView<HomeController> {
  const DialogListModelAI({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Row(
          children: [
            Text(
              'Select Model AI',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),

            if (!controller.loadingListModel.value)
              IconButton(
                onPressed: () {
                  controller.getListModel();
                },
                icon: Icon(Icons.refresh),
              ),
          ],
        ),
        content: controller.loadingListModel.value
            ? SizedBox(
                height: 75,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              )
            : Container(
                height: Get.height * 0.5,
                width: Get.width * 0.8,
                constraints: BoxConstraints(
                  maxHeight: Get.height * 0.5,
                  maxWidth: Get.width * 0.8,
                ),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.models.length,
                    itemBuilder: (context, index) {
                      final item = controller.models[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.selectedModel.value == item
                              ? Colors.deepPurple
                              : const Color.fromARGB(255, 212, 207, 188),
                        ),
                        child: ListTile(
                          title: Text(
                            item.name,
                            style: TextStyle(
                              color: controller.selectedModel.value == item
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            item.id,

                            style: TextStyle(
                              color: controller.selectedModel.value == item
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          onTap: () {
                            Get.back();
                            controller.selectedModel.value = item;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
      );
    });
  }
}
