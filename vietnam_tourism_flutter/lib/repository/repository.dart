import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';

class DataRepository{
  final CollectionReference collection = FirebaseFirestore.instance.collection('pets');

  Stream<QuerySnapshot> getStream(){
    return collection.snapshots();
  }

  // Future<DocumentReference> addPost(Post post){
  //   return collection.add(post.toJson());
  // }

  void updatePet(Post post) async{
    //await collection.doc(post.referenceId).update(post.toJson());
  }

  void deletePet(Post post) async{
    //await collection.doc(post.referenceId).delete();
  }
}