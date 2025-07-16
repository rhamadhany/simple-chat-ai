import 'package:chat_ai/app/modules/home/controllers/home_controller.dart';
import 'package:chat_ai/app/modules/home/views/drawer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogInputApiKey extends GetView<HomeController> {
  const DialogInputApiKey({super.key});

  @override
  Widget build(BuildContext context) {
    final hidden = true.obs;
    final textController = TextEditingController(text: controller.apiKey.value);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Api Key', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => TextField(
              controller: textController,
              obscureText: hidden.value,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => hidden.value = !hidden.value,
                  icon: Icon(
                    hidden.value ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                labelText: 'Api Key OpenRouter',
              ),
            ),
          ),

          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              children: [
                TextSpan(text: 'Don`t have api key? get it free'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: TextButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://openrouter.ai/settings/keys'),
                      );
                    },
                    child: Text(
                      'Here',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            if (textController.text.isNotEmpty) {
              Get.back();
              controller.saveApiKey(textController.text);
            } else {
              snackError(
                title: 'Required',

                message: 'Please input your api key!',
              );
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  ButtonStyle get buttonStyle {
    return ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.blue),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    );
  }
}
