// ignore_for_file: library_private_types_in_public_api

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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Let\'s see what\'s God got for you today!'),
            centerTitle: true,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<WheelNotifier>().spin();
            },
            child: const Text('Spin'),
          ),
          body: isLoading ? const Center(child: CircularProgressIndicator()) : const Wheel(),
        );
      },
    );
  }
}

class Wheel extends StatelessWidget {
  const Wheel({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.read<WheelNotifier>().items1!;
    final controller = context.read<WheelNotifier>().controller1;
    return FortuneWheel(
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
  }
  StreamController<int> controller1 = StreamController<int>();
  List<String>? items1;

  bool get isLoading => items1 == null;

  void spin() {
    controller1.add(
      Fortune.randomInt(0, items1!.length),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    controller1.close();
    super.dispose();
  }
}
