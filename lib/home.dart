// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WheelNotifier(),
      builder: (context, _) {
        final isLoading = context.watch<WheelNotifier>().isLoading;
        final controller1 = context.watch<WheelNotifier>().controller1;
        final controller2 = context.watch<WheelNotifier>().controller2;
        final controller3 = context.watch<WheelNotifier>().controller3;
        final controller4 = context.watch<WheelNotifier>().controller4;
        final controller5 = context.watch<WheelNotifier>().controller5;
        final controller6 = context.watch<WheelNotifier>().controller6;
        final items1 = context.watch<WheelNotifier>().items1;
        final items2 = context.watch<WheelNotifier>().items2;
        final items3 = context.watch<WheelNotifier>().items3;
        final items4 = context.watch<WheelNotifier>().items4;
        final items5 = context.watch<WheelNotifier>().items5;
        final items6 = context.watch<WheelNotifier>().items6;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Let\'s see what\'s God got for you today!'),
            centerTitle: true,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              context.read<WheelNotifier>().spin();
              await Future.delayed(const Duration(seconds: 5));
              final word1 = context.read<WheelNotifier>().word1;
              final word2 = context.read<WheelNotifier>().word2;
              final word3 = context.read<WheelNotifier>().word3;
              final word4 = context.read<WheelNotifier>().word4;
              final word5 = context.read<WheelNotifier>().word5;
              final word6 = context.read<WheelNotifier>().word6;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('God says:'),
                    content: Text(
                      '${items1![word1]} ${items2![word2]} ${items3![word3]} ${items4![word4]} ${items5![word5]} ${items6![word6]}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            label: const Text('Spin'),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : LayoutBuilder(builder: (context, constraints) {
                  return GridView(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    children: [
                      Wheel(items: items1!, controller: controller1),
                      Wheel(items: items2!, controller: controller2),
                      Wheel(items: items3!, controller: controller3),
                      Wheel(items: items4!, controller: controller4),
                      Wheel(items: items5!, controller: controller5),
                      Wheel(items: items6!, controller: controller6),
                    ],
                  );
                }),
        );
      },
    );
  }
}

class Wheel extends StatelessWidget {
  const Wheel({super.key, required this.items, required this.controller});

  final List<String> items;
  final StreamController<int> controller;

  @override
  Widget build(BuildContext context) {
    return FortuneWheel(
      animateFirst: false,
      physics: NoPanPhysics(),
      selected: controller.stream,
      items: [
        for (var it in items)
          FortuneItem(
            style: FortuneItemStyle(
              color: Color(Random().nextInt(0xFFFFFFFF)),
              borderColor: Colors.black,
              borderWidth: 5,
            ),
            child: Text(
              it,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black,
                shadows: [
                  Shadow(
                    color: Colors.white,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class WheelNotifier extends ChangeNotifier {
  WheelNotifier() {
    http.get(Uri.parse('https://random-word-api.herokuapp.com/word?number=8')).then((value) {
      final list = json.decode(value.body) as List<dynamic>;
      items1 = list.cast<String>();
      notifyListeners();
    });
    http.get(Uri.parse('https://random-word-api.herokuapp.com/word?number=8')).then((value) {
      final list = json.decode(value.body) as List<dynamic>;
      items2 = list.cast<String>();
      notifyListeners();
    });
    http.get(Uri.parse('https://random-word-api.herokuapp.com/word?number=8')).then((value) {
      final list = json.decode(value.body) as List<dynamic>;
      items3 = list.cast<String>();
      notifyListeners();
    });
    http.get(Uri.parse('https://random-word-api.herokuapp.com/word?number=8')).then((value) {
      final list = json.decode(value.body) as List<dynamic>;
      items4 = list.cast<String>();
      notifyListeners();
    });
    http.get(Uri.parse('https://random-word-api.herokuapp.com/word?number=8')).then((value) {
      final list = json.decode(value.body) as List<dynamic>;
      items5 = list.cast<String>();
      notifyListeners();
    });
    http.get(Uri.parse('https://random-word-api.herokuapp.com/word?number=8')).then((value) {
      final list = json.decode(value.body) as List<dynamic>;
      items6 = list.cast<String>();
      notifyListeners();
    });
  }
  final controller1 = StreamController<int>();
  List<String>? items1;
  var word1 = Fortune.randomInt(0, 8);
  final controller2 = StreamController<int>();
  List<String>? items2;
  var word2 = Fortune.randomInt(0, 8);
  final controller3 = StreamController<int>();
  List<String>? items3;
  var word3 = Fortune.randomInt(0, 8);
  final controller4 = StreamController<int>();
  List<String>? items4;
  var word4 = Fortune.randomInt(0, 8);
  final controller5 = StreamController<int>();
  List<String>? items5;
  var word5 = Fortune.randomInt(0, 8);
  final controller6 = StreamController<int>();
  List<String>? items6;
  var word6 = Fortune.randomInt(0, 8);

  bool get isLoading =>
      items1 == null || items2 == null || items3 == null || items4 == null || items5 == null || items6 == null;

  void spin() {
    word1 = Fortune.randomInt(0, items1!.length);
    word2 = Fortune.randomInt(0, items2!.length);
    word3 = Fortune.randomInt(0, items3!.length);
    word4 = Fortune.randomInt(0, items4!.length);
    word5 = Fortune.randomInt(0, items5!.length);
    word6 = Fortune.randomInt(0, items6!.length);

    controller1.add(word1);
    controller2.add(word2);
    controller3.add(word3);
    controller4.add(word4);
    controller5.add(word5);
    controller6.add(word6);

    notifyListeners();
  }

  @override
  void dispose() {
    controller1.close();
    controller2.close();
    controller3.close();
    controller4.close();
    controller5.close();
    controller6.close();
    super.dispose();
  }
}
