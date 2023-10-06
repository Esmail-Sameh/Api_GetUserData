import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intg_api/user.dart';
import 'package:http/http.dart' as http;

void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Screen'),
        ),
        body: FutureBuilder(
          future: get_user_data(),
          builder: (context, snapshot) {
            if (snapshot == false) {
              return CircularProgressIndicator();
            } else {}
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  '${userData[index].name}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  child: Text('${userData[index].id}'),
                ),
                subtitle: Text(
                  '${userData[index].email}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              itemCount: userData.length,
            );
          },
        ),
      ),
    );
  }

  List<User> userData = [];
  Future<List<User>> get_user_data() async {
    userData.clear();
    var userUrl = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var jesonUserData = await jsonDecode(userUrl.body);
    
    for (var u in jesonUserData) {
      userData.add(User(id: u['id'], name: u['name'], email: u['email']));
    }
    return userData;
  }

}
