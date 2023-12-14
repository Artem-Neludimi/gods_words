// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WheelNotifier(),
      builder: (context, _) => Scaffold(
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
        body: const Wheel(),
      ),
    );
  }
}

class Wheel extends StatelessWidget {
  const Wheel({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.read<WheelNotifier>().items;
    final controller = context.read<WheelNotifier>().controller1;
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Expanded(
            child: FortuneWheel(
              selected: controller.stream,
              items: [
                for (var it in items) FortuneItem(child: Text(it)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WheelNotifier extends ChangeNotifier {
  StreamController<int> controller1 = StreamController<int>();
  final items = <String>[
    'Grogu',
    'Mace Windu',
    'Obi-Wan Kenobi',
    'Han Solo',
    'Luke Skywalker',
    'Darth Vader',
    'Yoda',
    'Ahsoka Tano',
  ];

  void spin() {
    controller1.add(
      Fortune.randomInt(0, items.length),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    controller1.close();
    super.dispose();
  }
}
