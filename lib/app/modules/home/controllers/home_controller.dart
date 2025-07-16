import 'dart:convert';

import 'package:chat_ai/app/modules/home/models/history_model.dart';
import 'package:chat_ai/app/modules/home/models/message_model.dart';
import 'package:chat_ai/app/modules/home/views/drawer_home.dart';
import 'package:chat_ai/app/modules/home/views/list_model_ai.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final models = <ListModelAI>[].obs;
  final selectedModel = ListModelAI().obs;
  final messages = <MessageModel>[
    MessageModel(
      user: false,
      message: 'Hi this is demo apps',
      time: DateTime.now(),
    ),
  ].obs;
  final messageController = TextEditingController();
  final isLoading = false.obs;
  final scrollController = ScrollController();
  final box = GetStorage();
  final apiKey = ''.obs;

  final loadingListModel = true.obs;
  final histories = <HistoryModel>[].obs;
  final selectedHistories = HistoryModel().obs;

  void loadApiKey() {
    try {
      final api = box.read('apiKey');
      if (api != null) {
        final base64 = base64Decode(api);
        apiKey.value = utf8.decode(base64);
      }
    } catch (e) {
      debugPrint('Failed to load apiKeys $e');
    }
  }

  void saveApiKey(String api) async {
    final bytes = utf8.encode(api);
    final encode = base64Encode(bytes);
    await box.write('apiKey', encode);
    loadApiKey();
  }

  void sendMessage() async {
    isLoading.value = true;
    final message = messageController.text;
    messageController.clear();
    messages.add(
      MessageModel(user: true, message: message, time: DateTime.now()),
    );
    final dio = Dio();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(microseconds: 500),
      curve: Curves.linearToEaseOut,
    );

    final history = messages
        .map(
          (m) => {"role": m.user ? "user" : "assistant", "content": m.message},
        )
        .toList();

    try {
      if (apiKey.value.isEmpty) {
        throw Exception('apiKey required');
      }
      final request = {
        "model": selectedModel.value.id,
        "messages": [
          ...history,
          {"role": "user", "content": message},
        ],
        'stream': true,
      };

      final url = 'https://openrouter.ai/api/v1/chat/completions';
      final asisten = MessageModel(user: false);
      messages.add(asisten);
      final response = await dio.post(
        url,
        data: request,
        options: Options(
          headers: {
            "Authorization": "Bearer ${apiKey.value}",
            "Content-Type": "application/json",
          },
          responseType: ResponseType.stream,
        ),
      );
      if (response.statusCode == 200) {
        final body = response.data as ResponseBody;
        body.stream.listen((data) {
          final decode = utf8.decode(data).split('\n');
          for (var split in decode) {
            if (split.startsWith('data: ') && split != 'data: [DONE]') {
              try {
                final json = jsonDecode(split.substring(6));

                final content = json["choices"][0]["delta"]["content"];

                asisten.message += content;
                messages.refresh();
              } catch (_) {}
            }
            asisten.time = DateTime.now();
            messages.refresh();
          }
        });
      }
    } catch (e) {
      messages.add(MessageModel(user: false, message: 'Error $e'));
    } finally {
      dio.close();
      isLoading.value = false;
    }
  }

  void getListModel() async {
    loadingListModel.value = true;
    try {
      final dio = Dio();

      final response = await dio.get(
        'https://openrouter.ai/api/v1/models',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        for (var item in data) {
          final id = item['id'] as String;
          if (id.endsWith(':free')) {
            models.add(ListModelAI(id: id, name: item['name']));
          }
        }
      }
      selectedModel.value = models.first;
      dio.close();
    } catch (e) {
      snackError(message: 'Failed to get list model ai $e');
    } finally {
      loadingListModel.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadApiKey();
    getListModel();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

extension FormatDateTime on DateTime {
  String get formatDays {
    final formatter = DateFormat('EEEE, d MMMM yyyy hh:mm:ss');
    return formatter.format(this);
  }
}
