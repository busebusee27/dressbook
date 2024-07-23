import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dressbook/models/dress_card.dart';

const DRESSBOOK_COLLECTION_REF = 'dress-book';
const USERS_COLLECTION_REF = 'users';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _usersRef;

  DatabaseService() {
    _usersRef = _firestore.collection(USERS_COLLECTION_REF);
  }

  CollectionReference getUserCollectionRef(String userUID) {
    return _usersRef
        .doc(userUID)
        .collection(DRESSBOOK_COLLECTION_REF)
        .withConverter<DressCard>(
            fromFirestore: (snapshots, _) =>
                DressCard.fromJson(snapshots.data()!),
            toFirestore: (dressCard, _) => dressCard.toJson());
  }

  Stream<QuerySnapshot> getDressBook(String userUID) {
    return getUserCollectionRef(userUID).snapshots();
  }

  void addDressCard(String userUID, DressCard dressCard) {
    getUserCollectionRef(userUID).add(dressCard);
  }

  void updateDressCard(
      String userUID, String dressCardID, DressCard dressCard) {
    getUserCollectionRef(userUID).doc(dressCardID).update(dressCard.toJson());
  }

  void deleteDressCard(String userUID, String dressCardID) {
    getUserCollectionRef(userUID).doc(dressCardID).delete();
  }
}
