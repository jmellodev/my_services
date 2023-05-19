import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_services/controllers/client_services_controller.dart';
import 'package:my_services/models/service_model.dart';

class ServiceDetail extends StatelessWidget {
  ServiceDetail({super.key, required this.model});

  final ServiceModel model;

  final _controller = Get.put(ClientServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
      ),
      body: Center(
        child: Column(
          children: [Text(model.name)],
        ),
      ),
    );
  }
}
