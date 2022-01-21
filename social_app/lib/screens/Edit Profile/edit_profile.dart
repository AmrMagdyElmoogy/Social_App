import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/business_logic/cubit/social_states/social_states.dart';
import 'package:social_app/shared/Styles/icon_broken.dart';

class EditProfile extends StatelessWidget {
  EditProfile();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              HomeCubit.get(context).updatedate(nameController.text,
                  bioController.text, phoneController.text);
              Navigator.of(context).pop();
            },
            child: Text(
              'Update',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = HomeCubit.get(context).model;
          var profileImage = HomeCubit.get(context).profileImage;
          var coverImage = HomeCubit.get(context).coverImage;
          var cubit = HomeCubit.get(context);
          nameController.text = model.name;
          bioController.text = model.bio;
          phoneController.text = model.phone;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image(
                                width: double.infinity,
                                height: 150,
                                image: coverImage == null
                                    ? NetworkImage('${model.cover}')
                                    : FileImage(coverImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          CircleAvatar(
                            radius: 19,
                            child: IconButton(
                                icon: Icon(Icons.camera_alt_rounded),
                                onPressed: () {
                                  cubit.getCoverImage();
                                }),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${model.image}')
                                  : FileImage(profileImage),
                            ),
                          ),
                          CircleAvatar(
                            radius: 19,
                            child: IconButton(
                                icon: Icon(Icons.camera_alt_rounded),
                                onPressed: () {
                                  cubit.getProfileImage();
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(IconBroken.User),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: bioController,
                    decoration: InputDecoration(
                      labelText: 'bio',
                      prefixIcon: Icon(IconBroken.Activity),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'phone',
                      prefixIcon: Icon(IconBroken.Call),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
