import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_services/firebase_options.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

final usersCollection = firestore.collection('users');
final cartsCollection = firestore.collection('carts');
final servicesCollection = firestore.collection('services');
