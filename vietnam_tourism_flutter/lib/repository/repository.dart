import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';

class DataRepository{
  final CollectionReference collectionPlace = FirebaseFirestore.instance.collection('places');
  final CollectionReference collectionPost = FirebaseFirestore.instance.collection('posts');
  final CollectionReference collectionAccount = FirebaseFirestore.instance.collection('accounts');

  Stream<QuerySnapshot> getStreamPlace(){
    return collectionPlace.snapshots();
  }
  Stream<QuerySnapshot> getStreamPost(){
    return collectionPost.snapshots();
  }
  Stream<QuerySnapshot> getStreamAccount(){
    return collectionAccount.snapshots();
  }

  Future<DocumentReference> addPlace(Place place){
    return collectionPlace.add(place.toJson());
  }

  void updatePlace(Place place) async{
    await collectionPlace.doc(place.referenceId).update(place.toJson());
  }

  void deletePlace(Place place) async{
    await collectionPlace.doc(place.referenceId).delete();
  }
    Future<DocumentReference> addPost(Post post){
    return collectionPost.add(post.toJson());
  }

  void updatePet(Post post) async{
    await collectionPost.doc(post.referenceId).update(post.toJson());
  }

  void deletePet(Post post) async{
    await collectionPost.doc(post.referenceId).delete();
  }
  
  Future<DocumentReference> addAccount(Account account){
    return collectionAccount.add(account.toJson());
  }

  void updateAccount(Account account) async{
    await collectionAccount.doc(account.referenceId).update(account.toJson());
  }

  void deleteAccount(Account account) async{
    await collectionAccount.doc(account.referenceId).delete();
  }
}