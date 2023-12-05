
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'users_model.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final String url = 'https://randomuser.me/api/?results=20';
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.mediumPictureUrl),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetch,
        child: Icon(Icons.refresh),
      ),
    );
  }

  void fetch() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];

      final convertedUsers = results.map((userJson) => User.fromJson(userJson)).toList();

      setState(() {
        users = convertedUsers;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: FirstScreen(),
  ));
}
