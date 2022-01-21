import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/chat_model.dart';
import 'package:social_app/model/comment_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/social_user_create.dart';
import 'package:social_app/screens/Chat/chat.dart';
import 'package:social_app/screens/Feed/feed.dart';
import 'package:social_app/screens/Post/new_post.dart';
import 'package:social_app/screens/Settings/settings.dart';
import 'package:social_app/shared/compontents.dart';
import '../social_states/social_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<SocialStates> {
  HomeCubit() : super(SocialInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  File profileImage;
  final pickerProfileImage = ImagePicker();

  File coverImage;
  final pickerCoverImage = ImagePicker();

  int currentIndex = 0;
  void changeIndexButtomNav(int index) {
    if (index == 1) {
      getAllUsersToChat();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeButtomNavState());
    }
  }

  SocialUserCreate model;
  List<Widget> Screens = [
    Feed(),
    Chat(),
    NewPost(),
    Setting(),
  ];
  void getUser() {
    emit(SocialGetUserLoadingState());
    print(uid);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((value) => {
              model = SocialUserCreate.fromJson(value.data()),
              print(model.name),
              print(model.email),
              emit(SocialGetUserSuccessState()),
            })
        .catchError((onError) {
      emit(SocialGetUserErrorState());
    });
  }

  Future getProfileImage() async {
    final pickImage =
        await pickerProfileImage.getImage(source: ImageSource.gallery);
    if (pickImage != null) {
      profileImage = File(pickImage.path);
      emit(SocialImagePickerSuccessState());
    } else {
      print('Image not found');
      emit(SocialImagePickerErrorState());
    }
  }

  Future getCoverImage() async {
    final pickImage =
        await pickerCoverImage.getImage(source: ImageSource.gallery);
    if (pickImage != null) {
      coverImage = File(pickImage.path);
      emit(SocialImagePickerCoverSuccessState());
    } else {
      print('Image not found');
      emit(SocialImagePickerCoverErrorState());
    }
  }

  var catchedProfileImage;
  var catchedCoverImage;

  void uploadProfileImage({String name, String bio, String phone}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) => {
              value.ref.getDownloadURL().then((value) => {
                    emit(SocialSuccessUploadProfileImageState()),
                    catchedProfileImage = value,
                    EditInfoUsers(
                        name: name,
                        bio: bio,
                        phone: phone,
                        catchedProfileImage: catchedProfileImage),
                  }),
            });
  }

  void uploadCoverImage({String name, String bio, String phone}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) => {
              value.ref.getDownloadURL().then((value) => {
                    catchedCoverImage = value,
                    emit(SocialSuccessUploadCoverImageState()),
                    EditInfoUsers(
                        name: name,
                        bio: bio,
                        phone: phone,
                        catchedCoverImage: catchedCoverImage),
                  }),
            });
  }

  void updatedate(String name, String bio, String phone) {
    if (coverImage != null) {
      uploadCoverImage();
    }
    if (profileImage != null) {
      uploadProfileImage();
    } else {
      EditInfoUsers(name: name, bio: bio, phone: phone);
    }
  }

  void EditInfoUsers(
      {String name,
      String bio,
      String phone,
      String catchedCoverImage,
      String catchedProfileImage}) {
    SocialUserCreate userModel = SocialUserCreate(
      name: name ?? model.name,
      bio: bio ?? model.bio,
      phone: phone ?? model.phone,
      email: model.email,
      uid: model.uid,
      image: catchedProfileImage ?? model.image,
      cover: catchedCoverImage ?? model.cover,
      isEmailVerified: model.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .update(userModel.toJson())
        .then((value) => {
              getUser(),
              emit(SocialSuccessUpdateUserInfoState()),
            });
  }

  File postImage;
  final pickerPostImage = ImagePicker();
  Future getPostImage() async {
    final pickImage =
        await pickerPostImage.getImage(source: ImageSource.gallery);
    if (pickImage != null) {
      postImage = File(pickImage.path);
      emit(SocialSuccessPostImageState());
    }
  }

  void uploadPostImage(String post, String date) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) => {
              value.ref.getDownloadURL().then((value) => {
                    emit(SocialSuccessUploadPostImageState()),
                    createPost(post: post, date: date, postImage: value),
                    getPosts(),
                  }),
            });
  }

  PostModel postModel;
  void createPost({String post, String date, String postImage}) {
    postModel = PostModel(
      name: model.name,
      post: post,
      dateTime: date,
      uId: model.uid,
      profileImage: model.image,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(postModel.toJson())
        .then((value) => {
              emit(SocialSuccessCreatePostState()),
              getPosts(),
            });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  Map<int, bool> postsIds = {};
  List<String> IDs = [];
  List<int> Likes = [];
  List<int> comments = [];
  List<PostModel> posts = [];

  void getPosts() {
    posts.clear();
    int inc = 0;
    FirebaseFirestore.instance
        .collection('Posts')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                element.reference.collection('Likes').get().then((value) => {
                      postsIds.addAll({inc: false}),
                      inc++,
                      IDs.add(element.id),
                      Likes.add(value.docs.length),
                    });
                element.reference.collection('Comments').get().then((value) => {
                      comments.add(value.docs.length),
                    });
                posts.add(PostModel.fromJson(element.data()));
              }),
              emit(SocialSuccessGetAllPostsState()),
            })
        .catchError((onError) {
      emit(SocialErrorGetAllPostsState());
    });
  }

  bool isPressed = false;

  void changeLikeColor(int i) {
    postsIds[i] = !postsIds[i];
    emit(SocialChangeLikesColorState());
  }

  void setLikes(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(model.uid)
        .set({
          'Like': true,
        })
        .then((value) => {
              emit(SocialLikePostState()),
            })
        .catchError((onError) {});
  }

  void removeLike(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(model.uid)
        .delete()
        .then((value) => {
              emit(SoicalDeleteLikeState()),
            })
        .catchError((onError) {});
  }

  void refreshLikes(String postID) {
    Likes = [];
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .collection('Likes')
        .get()
        .then((value) => {
              Likes.add(value.docs.length),
              emit(SocialRefereshCommentsState()),
            });
  }

  void refreshComments(String postID) {
    comments = [];
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .collection('Comments')
        .get()
        .then((value) => {
              comments.add(value.docs.length),
              emit(SocialRefereshCommentsState()),
            });
  }

  CommentModel commentModel;
  void createComment(String commentText, String postId) {
    commentModel = CommentModel(
      name: model.name,
      uid: model.uid,
      profileImage: model.image,
      commentText: commentText,
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .add(commentModel.toJson())
        .then((value) => {
              emit(SocialSuccessCreateCommentState()),
            })
        .catchError((onError) {
      emit(SocialErrorCreateCommentState());
    });
  }

  List<CommentModel> usersComments = [];
  void getComments(String postId) {
    usersComments = [];
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                usersComments.add(CommentModel.fromJson(element.data()));
              }),
              print(usersComments.length),
              emit(SocialSuccessGetAllCommentsState()),
            });
  }

  List<SocialUserCreate> users = [];
  void getAllUsersToChat() {
    users = [];
    FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                if (element.data()['uid'] != model.uid)
                  users.add(SocialUserCreate.fromJson(element.data()));
              }),
              emit(SoicalSuccessGetAllUsersToChatsState()),
            })
        .catchError((onError) {
      emit(SoicalErrorGetAllUsersToChatsState());
    });
  }

  ChatModel chatModel;
  void sendMessages(
      {String receiveId, String sendId, String dateTime, String message}) {
    chatModel = ChatModel(
      receiveId: receiveId,
      sendId: sendId,
      dateTime: dateTime,
      message: message,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .collection('Chats')
        .doc(receiveId)
        .collection('Messages')
        .add(chatModel.toJson())
        .then((value) => {
              emit(SoicalSuccessSendMessageState()),
            })
        .catchError((onError) {
      emit(SoicalErrorSendMessageState());
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiveId)
        .collection('Chats')
        .doc(model.uid)
        .collection('Messages')
        .add(chatModel.toJson())
        .then((value) => {
              emit(SoicalSuccessSendMessageState()),
            })
        .catchError((onError) {
      emit(SoicalErrorSendMessageState());
    });
  }

  List<ChatModel> messages = [];

  void getMessages(String receiveID) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .collection('Chats')
        .doc(receiveID)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
      emit(SoicalGetMessagesState());
    });
  }
}
