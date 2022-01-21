import 'package:social_app/model/social_user_create.dart';

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialLoadingLoginState extends SocialStates {}

class SocialSuccessLoginState extends SocialStates {
  String uid;
  SocialSuccessLoginState(this.uid);
}

class SocialErrorLoginState extends SocialStates {
  String error;
  SocialErrorLoginState(error);
}

class SocialChangeButtomNavState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {}

class SocialLoadingHomeState extends SocialStates {}

class SocialSuccessHomeState extends SocialStates {}

class SocialErrorHomeState extends SocialStates {
  String error;
  SocialErrorHomeState(error);
}

class SocialNewPostState extends SocialStates {}

class SocialCreateUserSuccessState extends SocialStates {}

class SocialCreateUserErrorState extends SocialStates {}

class SocialLoadingRegisterState extends SocialStates {}

class SocialSuccessRegisterState extends SocialStates {

}

class SocialErrorRegisterState extends SocialStates {
  String error;
  SocialErrorRegisterState(error);
}

class SocialImagePickerSuccessState extends SocialStates{}

class SocialImagePickerErrorState extends SocialStates{}

class SocialImagePickerCoverSuccessState extends SocialStates{}

class SocialImagePickerCoverErrorState extends SocialStates{}

class SocialSuccessUploadProfileImageState extends SocialStates{} 

class SocialSuccessUploadCoverImageState extends SocialStates{} 

class SocialSuccessUpdateUserInfoState extends SocialStates{}

class SocialSuccessPostImageState extends SocialStates{}

class SocialSuccessUploadPostImageState extends SocialStates{}

class SocialSuccessCreatePostState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

class SocialSuccessGetAllPostsState extends SocialStates{}

class SocialErrorGetAllPostsState extends SocialStates{}

class SocialLikePostState extends SocialStates{}

class SocialSuccessCreateCommentState extends SocialStates{}

class SocialErrorCreateCommentState extends SocialStates{}

class SocialRefereshLikesState extends SocialStates{}

class SocialChangeLikesColorState extends SocialStates{}

class SoicalDeleteLikeState extends SocialStates{}

class SocialRefereshCommentsState extends SocialStates{}

class SocialSuccessGetAllCommentsState extends SocialStates{}

class SoicalSuccessGetAllUsersToChatsState extends SocialStates{}

class SoicalErrorGetAllUsersToChatsState extends SocialStates{}

class SoicalSuccessSendMessageState extends SocialStates{}

class SoicalErrorSendMessageState extends SocialStates{}

class SoicalGetMessagesState extends SocialStates{}

class ChangePasswordObecure extends SocialStates {}


