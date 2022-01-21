import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/social_user_create.dart';
import 'package:social_app/shared/compontents.dart';
import '../social_states/social_states.dart';

class LoginCubit extends Cubit<SocialStates> {
  LoginCubit() : super(SocialInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordObsecure() {
    isPassword = !isPassword;
    emit(ChangePasswordObecure());
  }

  // ShopLoginModel loginModel;

  void userLogin({String email, String password}) {
    emit(SocialLoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              print(value.user.email),
              print(value.user.uid),
              emit(SocialSuccessLoginState(value.user.uid)),
              uid = value.user.uid,
            })
        .catchError((onError) {
      emit(SocialErrorLoginState(onError));
    });
  }

  // ShopRegisterModel registerModel;
  SocialUserCreate model;

  void userRegister(
      {String name, String email, String password, String phone}) {
    emit(SocialLoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              emit(SocialSuccessRegisterState()),
              userCreate(
                name: name,
                email: email,
                phone: phone,
                uid: value.user.uid,
              ),
              uid = value.user.uid, 
            })
        .catchError((onError) {
      emit(SocialErrorRegisterState(onError));
    });
  }

  void userCreate({String name, String email, String phone, String uid}) {
     model = new SocialUserCreate(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      isEmailVerified: false,
      image: 'https://png.pngtree.com/png-vector/20190120/ourmid/pngtree-man-vector-icon-png-image_470295.jpg',
      cover: 'https://img.freepik.com/free-vector/drawn-beautiful-spring-landscape-background_23-2148857332.jpg?size=626&ext=jpg',
      bio: 'Write what you want to tell people about ..',
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(model.toJson())
        .then((value) => {
              emit(SocialCreateUserSuccessState()),
            })
        .catchError((onError) {
      emit(SocialCreateUserSuccessState());
    });
  }
}
