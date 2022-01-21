import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_cubit/login_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/screens/Edit%20Profile/edit_profile.dart';
import 'package:social_app/screens/Login/login_screen.dart';
import 'package:social_app/shared/local/cacheHelper.dart';

class Setting extends StatelessWidget {
  const Setting();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context).model;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        width: double.infinity,
                        height: 150,
                        image: NetworkImage('${cubit.cover}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: AlignmentDirectional.topCenter,
                  ),
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('${cubit.image}'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${cubit.name}',
              style: TextStyle(
                fontFamily: 'Fav',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${cubit.bio}',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontFamily: 'Fav',
                    fontSize: 15,
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '120',
                        style: TextStyle(
                          fontFamily: 'Fav',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Posts',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '60',
                        style: TextStyle(
                          fontFamily: 'Fav',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Photos',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '5k',
                        style: TextStyle(
                          fontFamily: 'Fav',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Followers',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '64',
                        style: TextStyle(
                          fontFamily: 'Fav',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Followings',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        CacheHelper.removeUID();
                        
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false);
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(color: Colors.blue),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfile()));
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(color: Colors.blue),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
