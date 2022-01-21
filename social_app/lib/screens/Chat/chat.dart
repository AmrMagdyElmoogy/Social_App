import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/model/social_user_create.dart';
import 'package:social_app/screens/Chat_Talking/chat_screen.dart';

class Chat extends StatelessWidget {
  const Chat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var usersContacts = HomeCubit.get(context).users;
          return ListView.separated(
              itemBuilder: (context, index) =>
                  buildChatItem(usersContacts[index], context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: usersContacts.length);
        },
      ),
    );
  }

  Widget buildChatItem(SocialUserCreate model, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          HomeCubit.get(context).getMessages(model.uid);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                model: model,
              ),
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '${model.name}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
