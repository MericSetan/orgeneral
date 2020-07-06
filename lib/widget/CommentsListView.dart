import 'package:flutter/material.dart';
import 'package:orgeneral/model/Comment.dart';

class CommentListView extends StatelessWidget {
  final List<Comment> comments;
  CommentListView({this.comments});

  @override
  Widget build(BuildContext context) {
    var _content = [
      Text('Boş'),
    ];
    if (comments != null && comments.isNotEmpty) {
      _content = List.generate(comments.length, (index) {
        return Text(comments[index].content);
      });
    }
    return Container(
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: _content,
      ),
    );
  }
}
