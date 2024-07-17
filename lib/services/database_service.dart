import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dressbook/models/dress_card.dart';

const DRESSBOOK_COLLECTION_REF = 'dress-book';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _dressBookRef;

  DatabaseService() {
    _dressBookRef = _firestore
        .collection(DRESSBOOK_COLLECTION_REF)
        .withConverter<DressCard>(
            fromFirestore: (snapshots, _) =>
                DressCard.fromJson(snapshots.data()!),
            toFirestore: (dressCard, _) => dressCard.toJson());
  }

  Stream<QuerySnapshot> getDressBook() {
    return _dressBookRef.snapshots();
  }

  void addDressCard(DressCard dressCard) {
    _dressBookRef.add(dressCard);
  }
}
