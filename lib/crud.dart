import 'package:cloud_firestore/cloud_firestore.dart';

// Model untuk ProfileAssisten
class ProfileAssistenModel {
  final String uid;
  final String nama, email, hobi;

  ProfileAssistenModel({
    required this.uid,
    required this.nama,
    required this.email,
    required this.hobi,
  });

  // Konversi dari Firestore Document ke Model
  factory ProfileAssistenModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProfileAssistenModel(
      uid: snapshot.id,
      nama: data['nama'],
      email: data['email'],
      hobi: data['hobi'],
    );
  }
}

// CRUD Class
class CRUD {
  static final firebase = FirebaseFirestore.instance;
  static final collection = firebase.collection('profileAssisten');

  // Tambah Assisten
  static Future<void> addAssisten({
    required String nama,
    required String email,
    required String hobi,
  }) async {
    DocumentReference docs = collection.doc();

    Map<String, dynamic> data = {
      "nama": nama,
      "email": email,
      "hobi": hobi,
    };

    await docs.set(data);
  }

  // Update Assisten
  static Future<void> updateAssisten({
    required String uid,
    required String nama,
    required String email,
    required String hobi,
  }) async {
    DocumentReference docs = collection.doc(uid);

    Map<String, dynamic> data = {
      "nama": nama,
      "email": email,
      "hobi": hobi,
    };

    await docs.update(data);
  }

  // Baca Data dari Firestore
  static Stream<QuerySnapshot> readItems() {
    return collection.snapshots();
  }

  // Hapus Assisten
  static Future<void> deleteAssisten({required String uid}) async {
    DocumentReference docs = collection.doc(uid);
    await docs.delete();
  }
}
