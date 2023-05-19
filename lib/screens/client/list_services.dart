import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_services/controllers/client_services_controller.dart';
import 'package:my_services/models/service_model.dart';

class ServicesView extends StatelessWidget {
  final String clientId;
  final ClientServicesController _controller =
      Get.put(ClientServicesController());

  ServicesView({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
      ),
      body: StreamBuilder<List<ServiceModel>>(
        stream: _controller.getServicesByClientId(clientId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final services = snapshot.data!;
          return services.isEmpty
              ? const Center(
                  child: Text('Este usuário ainda não tem serviços.'))
              : ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];

                    return ListTile(
                      onTap: () => _controller.cereca(service.id),
                      title: Text(service.name),
                      subtitle: Text(service.description),
                      trailing: Text(
                        "R\$${service.price.toStringAsFixed(2).replaceAll('.', ',')}",
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
