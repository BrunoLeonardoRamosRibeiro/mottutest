// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mottu/domain/usecases/get_all_states.usecase.dart';
import 'package:mottu/ui/controllers/home.controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(usecase: Get.find<GetAllStates>()),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Teste Mottu - Consumo de Api'),
            actions: [
              IconButton(
                onPressed: () async {
                  await controller.getAll();
                },
                icon: const Icon(
                  Icons.download,
                ),
              ),
            ],
          ),
          body: Obx(() {
            return Visibility(
              visible: !controller.isLoading,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return ListTile(
                        title: Text(
                            'Nível da Bateria ${controller.batteryLevel}'),
                      );
                    }),
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: controller.ufStates.length,
                        itemBuilder: (_, index) {
                          var item = controller.ufStates[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: Card(child: ListTile(
                              title: Text(item.nome),
                              trailing: Text(item.sigla),
                              leading: Text(item.id.toString()),
                            ),),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
