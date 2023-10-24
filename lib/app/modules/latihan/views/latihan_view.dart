import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:project/app/Models/todo.dart';

class LatihanView extends StatefulWidget {
  const LatihanView({super.key});

  @override
  State<LatihanView> createState() => _LatihanViewState();
}

class _LatihanViewState extends State<LatihanView> {
  late Future<Todos> _futureTodos;

  @override
  void initState() {
    super.initState();
    _futureTodos = fetchTodos();
  }

  Future<Todos> fetchTodos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/5'));
    if (response.statusCode == 200) {
      return Todos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Todos>(
          future: _futureTodos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text('userId: '),
                      Text('${snapshot.data!.userId}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('id: '),
                      Text('${snapshot.data!.id}'),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text('title: '),
                      Text(snapshot.data!.title),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
