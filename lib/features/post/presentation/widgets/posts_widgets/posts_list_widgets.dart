import 'package:flutter/material.dart';
import '../../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Dismissible(key:Key(posts[index].id.toString()),
         background:  Container(
            color: Colors.cyan,
                    child:const Icon(Icons.delete,size: 40,color: Colors.white,),
          ),
            onDismissed: (direction){
             ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${posts[index].title} Deleted"))
                );
             },
          child: 
             ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () { },
        )
       );
        
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}