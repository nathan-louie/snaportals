import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepository {
  static final FirebaseFirestore _fs = FirebaseFirestore.instance;
  static final CollectionReference _cr = _fs.collection('snaps');
  static final String username = 'userA';

  static Future<List> getPhotos() async {
    var a = [];
    var querySnapshot = await _cr.get();
    for (var element in querySnapshot.docs) {
      a.add(element['snap']);
    }
    return a;
  }

  static Future<void> addUser(String user, String url, String friends) async {
    return _cr
        .doc(user)
        .set({
          'snap': url,
          'users': friends,
        })
        .then((value) => print('User Added.'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  static Future<void> updatePhoto(String url) async {
    return _cr
        .doc('userA')
        .update({'snap': url})
        .then((value) => print('User A Updated.'))
        .catchError((error) => print('Failed to update user: $error'));
  }

  static Future<bool> listenForChanges() async {
    var result = false;
    _cr.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        result = true;
      }
      // event.docs.forEach((element) {
      //   result = true;
      // });
    });
    return result;
  }

  static Stream<QuerySnapshot> getDatabaseStream() {
    return _cr.snapshots(includeMetadataChanges: true);
  }
}
