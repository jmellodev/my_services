import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_services/constants/firebase_constants.dart';
import 'package:my_services/models/service_model.dart';

class ClientServicesController extends GetxController {
  final RxList<ServiceModel> services = <ServiceModel>[].obs;

  Stream<List<ServiceModel>> getServicesByClientId(String clientId) {
    final services = servicesCollection
        .where('clientId', isEqualTo: clientId)
        .snapshots()
        .map((QuerySnapshot query) => query.docs.map((doc) {
              final data = doc.data();
              return ServiceModel.fromJson(data as Map<String, dynamic>);
            }).toList());
    return services;
  }
}
