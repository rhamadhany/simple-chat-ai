import 'package:chat_ai/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          controller: controller.messageController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Type message...',
            labelStyle: TextStyle(color: Colors.black),
            fillColor: const Color.fromARGB(255, 250, 240, 215),
            filled: true,
            suffix: controller.isLoading.value
                ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: Colors.grey),
                  )
                : null,
            suffixIcon: controller.isLoading.value
                ? null
                : IconButton(
                    onPressed: () {
                      controller.sendMessage();
                    },
                    icon: Icon(Icons.send, color: Colors.black),
                  ),
          ),
        ),
      ),
    );
  }
}
