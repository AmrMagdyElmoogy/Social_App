import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/model/comment_model.dart';

class Comments extends StatelessWidget {
  const Comments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: BlocConsumer<HomeCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var usersComments = HomeCubit.get(context).usersComments;
          return usersComments != null
              ? ListView.builder(
                  itemBuilder: (context, index) =>
                      buildCommentItem(usersComments[index], context, index),
                  itemCount: usersComments.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget buildCommentItem(CommentModel commentModel, context, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                    backgroundImage:
                        NetworkImage('${commentModel.profileImage}'),
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
                            '${commentModel.name}',
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
                '${commentModel.commentText}',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontFamily: 'Fav',
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      fontSize: 20,
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        ),
      ),
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
}
