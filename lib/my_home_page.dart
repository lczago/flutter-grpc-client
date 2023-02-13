import 'package:first_project/post.dart';
import 'package:first_project/post_list.dart';
import 'package:first_project/text_input_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String name;
  const MyHomePage(this.name, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> post = [];

  void newPost(String text) {
    setState(() {
      post.add(Post(text, widget.name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello World!"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: PostList(post)),
          TextInputWidget(newPost),
        ],
      ),
    );
  }
}
