import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/shared/Styles/icon_broken.dart';

class NewPost extends StatelessWidget {
  NewPost();
  var textController = TextEditingController();
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  //Not Show postImage ??
                  if (cubit.postImage != null) {
                    cubit.uploadPostImage(
                        textController.text, DateTime.now().toString());
                    cubit.getPosts();
                    Navigator.of(context).pop();
                  } else {
                    cubit.createPost(
                        post: textController.text,
                        date: DateTime.now().toString());
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            title: Text(
              'New Post',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${cubit.model.image}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${cubit.model.name}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'What\'s happening?',
                      border: InputBorder.none,
                    ),
                  ),
                  state is SocialSuccessPostImageState
                      ? Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image(
                                  width: double.infinity,
                                  height: 250,
                                  image: FileImage(cubit.postImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: AlignmentDirectional.topCenter,
                            ),
                            CircleAvatar(
                              radius: 19,
                              child: Center(
                                child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      cubit.removePostImage();
                                    }),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 1,
                        ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Photo',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.tag_sharp),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Tags',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
