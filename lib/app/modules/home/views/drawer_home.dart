import 'package:chat_ai/app/modules/home/views/dialog_input_api_key.dart';
import 'package:chat_ai/app/modules/home/views/dialog_list_model_ai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.65,
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
            child: Center(
              child: Text(
                'Chat AI',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          cardModel(
            onTap: () {
              Get.back();
              Get.dialog(DialogListModelAI());
            },
            title: 'Model',
            icon: Icons.model_training,
          ),
          cardModel(
            onTap: () {
              Get.back();
              Get.dialog(DialogInputApiKey());
            },
            title: 'Api Key',
            icon: Icons.key,
          ),
        ],
      ),
    );
  }

  Widget cardModel({
    required String title,
    required Function() onTap,
    IconData? icon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),

      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 233, 199),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        onTap: onTap,
      ),
    );
  }
}

void snackError({String? title, required String message}) {
  Get.snackbar(
    title ?? 'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.withAlpha(225),
    colorText: Colors.white,
  );
}

void snackSuceed({String? title, required String message}) {
  Get.snackbar(
    title ?? 'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue.withAlpha(225),
    colorText: Colors.white,
  );
}
