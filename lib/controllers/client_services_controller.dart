import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:my_services/constants/firebase_constants.dart';
import 'package:my_services/models/service_model.dart';

class ClientServicesController extends GetxController {
  final RxList<ServiceModel> serviceModel = <ServiceModel>[].obs;

  Stream<List<ServiceModel>> getServicesByClientId(String clientId) {
    final services = servicesCollection
        .where('clientId', isEqualTo: clientId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot query) => query.docs.map((doc) {
              final data = doc.data();
              // print(data);
              return ServiceModel.fromJson(data as Map<String, dynamic>);
            }).toList());
    getAllFeedPosts(clientId);
    return services;
  }

  Future<List<ServiceModel>> getAllFeedPosts(String clientId) async {
    debugPrint("ID do usuário: $clientId");
    List<ServiceModel> allPosts = [];
    var query =
        await servicesCollection.where('clientId', isEqualTo: clientId).get();
    for (var userdoc in query.docs) {
      debugPrint("Serviços do usuário: ${userdoc.id}");
      QuerySnapshot feed =
          await servicesCollection.doc(userdoc.id).collection("days").get();
      for (var postDoc in feed.docs) {
        final xereca = postDoc.data() as Map<String, dynamic>;
        debugPrint(xereca.toString());
        print(DaysModel.fromJson(xereca).toString());
      }
    }
    return allPosts;
  }

  static viewServiceClient(String docId) {
    final service = servicesCollection.doc(docId);

    service.get().then((doc) {
      final data = doc.data() as Map<String, dynamic>;
      debugPrint(data.toString());
      return ServiceModel.fromJson(data);
    }, onError: (e) => debugPrint("Erro: $e"));
  }

  cereca(String docId) async {
    var result = await FirebaseFirestore.instance
        .collection('services')
        .doc(docId)
        .collection('days')
        .get();
    debugPrint(docId);
    debugPrint(
        "#######################################################################");
    debugPrint(result.docs.toString());
  }

  @override
  void onInit() {
    // getAllFeedPosts();
    super.onInit();
  }
}
