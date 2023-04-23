import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IBaseFirestore<Response> {
  final CollectionReference<Response> collection;
  final FirebaseAuth auth;

  IBaseFirestore({required String path})
      : collection = FirebaseFirestore.instance.collection(path)
            as CollectionReference<Response>,
        auth = FirebaseAuth.instance;

  Future<QuerySnapshot<Response>> fetchData() async {
    return await collection.get().timeout(const Duration(seconds: 10));
  }

  /// It returns the value of the key
  Future<dynamic> fetchSomeData(String id, String key) async {
    var response = await collection
        .doc(id)
        .get()
        .then((value) => value.data())
        .timeout(const Duration(seconds: 10));
    return (response as Map)[key];
  }

  Future<DocumentSnapshot<Response>> fetchOneData(String id) async {
    return await collection.doc(id).get().timeout(const Duration(seconds: 10));
  }

  /// It returns the id of the document
  Future<String> addData(dynamic data, String? id) async {
    final doc = id != null ? collection.doc(id) : collection.doc();
    data['id'] = doc.id;
    return await doc
        .set(data)
        .then((value) => doc.id)
        .timeout(const Duration(seconds: 10));
  }

  Future<void> updateData(dynamic data, String id) async {
    return await collection
        .doc(id)
        .update(data as Map<Object, Object?>)
        .timeout(const Duration(seconds: 10));
  }

  Future<void> updateSomeData(dynamic key, dynamic data, String id) async {
    return await collection
        .doc(id)
        .update({key: data}).timeout(const Duration(seconds: 10));
  }

  Future<void> deleteData(String id) async {
    return await collection
        .doc(id)
        .delete()
        .timeout(const Duration(seconds: 10));
  }

  // SUB COLLECTION PART
  Future<QuerySnapshot<Map<String, dynamic>>> fetchSubdata(
      String id, String insidePath) {
    return collection
        .doc(id)
        .collection(insidePath)
        .get()
        .timeout(const Duration(seconds: 10));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchOneSubdata(
      String id, String insidePath, String insideId) {
    return collection
        .doc(id)
        .collection(insidePath)
        .doc(insideId)
        .get()
        .timeout(const Duration(seconds: 10));
  }

  Future<void> deleteSubdata(
      String id, String insidePath, String insideId) async {
    return await collection
        .doc(id)
        .collection(insidePath)
        .doc(insideId)
        .delete()
        .timeout(const Duration(seconds: 10));
  }

  Future<void> addSubdata(
      String id, String insidePath, dynamic data, String? insideId) async {
    final doc = insideId != null
        ? collection.doc(id).collection(insidePath).doc(insideId)
        : collection.doc(id).collection(insidePath).doc();
    data['id'] = doc.id;
    return await doc.set(data).timeout(const Duration(seconds: 10));
  }
}
