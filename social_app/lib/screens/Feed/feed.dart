import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/screens/Comments/comments.dart';
import 'package:social_app/shared/Styles/icon_broken.dart';

class Feed extends StatelessWidget {
  Feed();
  List<TextEditingController> _controllers = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.posts.length > 0 && cubit.postsIds.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  _controllers.add(new TextEditingController());
                  return buildPostItem(cubit.posts[index], context, index,
                      cubit, _controllers[index]);
                },
                itemCount: cubit.posts.length)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget Sperator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
  }

  Widget buildPostItem(PostModel post, context, int index, HomeCubit cubit,
      TextEditingController textController) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${post.profileImage}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${post.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      Text(
                        '${post.dateTime}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),
            Sperator(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${post.post}',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontFamily: 'Fav',
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      fontSize: 20,
                      color: Colors.black,
                    ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            HomeCubit.get(context).postImage != null
                ? Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      width: double.infinity,
                      height: 150,
                      image: FileImage(HomeCubit.get(context).postImage),
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(
                    height: 1,
                  ),
            Sperator(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          cubit.setLikes(HomeCubit.get(context).IDs[index]);
                          cubit.refreshLikes(cubit.IDs[index]);
                          cubit.changeLikeColor(index);
                        },
                        // store temp map Likes in compontents to save data
                        icon: cubit.postsIds[index]
                            ? Icon(Icons.favorite_rounded, color: Colors.red)
                            : Icon(
                                Icons.favorite_rounded,
                              ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${cubit.Likes[index]}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          cubit.getComments(cubit.IDs[index]);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Comments()));
                        },
                        icon: Icon(IconBroken.Message),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '0',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.share_rounded),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '0',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Sperator(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${post.profileImage}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Type Something ..',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: IconButton(
                        onPressed: () {
                          cubit.createComment(
                              textController.text, cubit.IDs[index]);
                          cubit.refreshComments(cubit.IDs[index]);
                          textController.clear();
                        },
                        icon: Icon(Icons.send_rounded)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
