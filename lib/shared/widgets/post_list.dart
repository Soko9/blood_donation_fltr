import 'package:blood_donation/models/post/post.dart';
import 'package:blood_donation/shared/widgets/post_tile.dart';
import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key, required this.posts}) : super(key: key);

  final List<Post>? posts;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    if (widget.posts!.isEmpty) {
      return const Center(
        child: Text("No Posts Found!"),
      );
    } else {
      // inspect(widget.posts);
      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.posts?.length,
        itemBuilder: (context, index) => PostTile(
          post: widget.posts![index],
        ),
      );
    }
  }
}
