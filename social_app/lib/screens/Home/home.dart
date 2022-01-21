import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/screens/Post/new_post.dart';
import 'package:social_app/shared/Styles/icon_broken.dart';

class Home extends StatelessWidget {
  const Home() : super();

  @override
  Widget build(BuildContext context) {
    // Todo :
    // 1- Run This app (Done)
    // 2- Design UI for send verf.
    return BlocConsumer<HomeCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewPost()));
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Soicallawy',
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndexButtomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Feed'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
