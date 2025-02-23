import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository{

  Future getAllUsersDataRepositoryFunction()async
  {
    return await FirebaseFirestore.instance.collection('Users').get();
  }
}