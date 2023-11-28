import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/client_controller.dart';

class ClientView extends GetView<ClientController> {
  const ClientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClientView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClientView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
