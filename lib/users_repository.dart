import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UsersRepository {
  static final FirebaseFirestore _fs = FirebaseFirestore.instance;
  static final CollectionReference cr = _fs.collection('snaps');
  static const String username = 'userA';

  static Future<List> getPhotos() async {
    var a = [];
    var querySnapshot = await cr.get();
    for (var element in querySnapshot.docs) {
      a.add(element['snap']);
    }
    return a;
  }

  static Future<void> addUser(String user, String url, String friends) async {
    return cr
        .doc(user)
        .set({
          'snap': url,
          'users': friends,
        })
        .then((value) => print('User Added.'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  static Future<void> updatePhoto(String url) async {
    return cr
        .doc(username)
        .update({'snap': url})
        .then((value) => print('User Updated.'))
        .catchError((error) => print('Failed to update user: $error'));
  }

  static Future<bool> listenForChanges() async {
    var result = false;
    cr.snapshots().listen((event) {
      event.docs.forEach((element) {
        result = true;
      });
    });
    return result;
  }

  static Stream<QuerySnapshot> getDatabaseStream() {
    return cr.snapshots(includeMetadataChanges: true);
  }
}

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      UsersRepository.getDatabaseStream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            var data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
  }
}
