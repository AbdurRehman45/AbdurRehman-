import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sendme/fireStoreReference/fireStorReferences.dart';
import 'package:sendme/main.dart';

class SendoMainPage extends StatefulWidget {
  final currentUserId;
  SendoMainPage({this.currentUserId});
  FireStoreReference fireStoreRef = FireStoreReference();

  @override
  _SendoMainPageState createState() => _SendoMainPageState();
}

class _SendoMainPageState extends State<SendoMainPage> {
  void setData() async {
    try {
      final fireStore = widget.fireStoreRef.fireStoreReference;
      await FirebaseFirestore.instance
          .collection("Chat")
          .doc("3")
          .set({"name": "Saif", "msg": "Hello Abdur"}).then((value) {
        Fluttertoast.showToast(msg: "Successfully added");
        print("Successfully added");
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      print(e.toString());
    }
  }

  void updateData() async {
    try {
      final fireStore = widget.fireStoreRef.fireStoreReference;
      await FirebaseFirestore.instance
          .collection("Chat")
          .doc("2")
          .update({"name": "Saif", "msg": "Hello me"}).then((vlaue) {
        Fluttertoast.showToast(msg: "Successfully updated");
        print("Successfully updated");
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      print(e.toString());
    }
  }

  void deleteData() async {
    final fireStore = widget.fireStoreRef.fireStoreReference;
    await fireStore
        .collection("Chat")
        .doc("2")
        .delete()
        .then((value) => {Fluttertoast.showToast(msg: "deleted")});
  }

  void getData() async {
    final fireStore = widget.fireStoreRef.fireStoreReference;
    try {
      await fireStore.collection("Chat").doc("3").get().then((value) {
        Fluttertoast.showToast(
            msg: "name: " +
                value.get("name").toString() +
                "  " +
                "Msg: " +
                value.get("msg").toString());
//            .forEach((key, value) {
//          Fluttertoast.showToast(msg: value.toString());
//        });
      });
    } catch (e) {
      print("Exception is " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: (context, snapShot) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setData();
              },
              color: Colors.indigo,
              child: Text("Create"),
              textColor: Colors.white,
            ),
            FlatButton(
                onPressed: () {
                  updateData();
                },
                color: Colors.indigo,
                child: Text("Update"),
                textColor: Colors.white),
            FlatButton(
                onPressed: () {
                  getData();
                },
                color: Colors.indigo,
                child: Text("Show"),
                textColor: Colors.white),
            FlatButton(
                onPressed: () {
                  deleteData();
                },
                color: Colors.indigo,
                child: Text("Delete"),
                textColor: Colors.white)
          ],
        ),
      );
    });
  }
}
