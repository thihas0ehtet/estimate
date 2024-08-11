import 'package:estimate/ui/earthwork.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List menus = [
      {
        "label": "Earthwork",
        "bgColor": Colors.teal[100],
        "action": () => Get.to(() => const EarthworkPage())
      },
      {"label": "Button 2", "bgColor": Colors.green, "action": () {}},
      {"label": "Button 3", "bgColor": Colors.blue, "action": () {}}
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Estimate Calculation for Engineering",
        ),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          for (var menu in menus)
            InkWell(
              onTap: menu['action'],
              child: Container(
                decoration: BoxDecoration(
                    color: menu['bgColor'],
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Text(
                  menu['label'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
        ],
      ),
    );
  }
}
