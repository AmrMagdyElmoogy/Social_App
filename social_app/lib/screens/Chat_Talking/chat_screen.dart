import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/model/chat_model.dart';
import 'package:social_app/model/social_user_create.dart';
import 'package:social_app/shared/compontents.dart';

class ChatScreen extends StatelessWidget {
  SocialUserCreate model;
  ChatScreen({this.model});
  var chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<HomeCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            var messages = HomeCubit.get(context).messages;
            return Column(
              children: [
                messages != null
                    ? Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (model.uid != messages[index].sendId) {
                                return myMessages(messages[index]);
                              } else {
                                return hisMessages(messages[index]);
                              }
                            },
                            itemCount: messages.length),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(decoration: TextDecoration.none),
                          controller: chatController,
                          decoration: InputDecoration(
                            hintText: 'Message .. ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        radius: 25,
                        child: IconButton(
                            onPressed: () {
                              cubit.sendMessages(
                                sendId: uid,
                                receiveId: model.uid,
                                dateTime: DateTime.now().toIso8601String(),
                                message: chatController.text,
                              );
                              chatController.clear();
                            },
                            icon: Icon(Icons.send_rounded)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget hisMessages(ChatModel chatModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '${chatModel.message}',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Widget myMessages(ChatModel chatModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${chatModel.message}',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
