import 'package:first_project/post.dart';
import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  final List<Post> listItems;

  const PostList(this.listItems, {Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listItems.length,
      itemBuilder: (context, index) {
        var post = widget.listItems[index];
        return Card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(post.body),
                  subtitle: Text(post.author),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(post.likes.toString(),
                        style: const TextStyle(fontSize: 20)),
                  ),
                  IconButton(
                    onPressed: () => like(post.likePost),
                    icon: const Icon(Icons.thumb_up),
                    color: post.userLiked ? Colors.green : Colors.black,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
