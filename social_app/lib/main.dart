import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/cubit/social_cubit/bloc_observer.dart';
import 'package:social_app/business_logic/cubit/social_cubit/home_cubit.dart';
import 'package:social_app/screens/Home/home.dart';
import 'package:social_app/screens/Register/register_screen.dart';
import 'package:social_app/shared/compontents.dart';
import 'package:social_app/shared/local/cacheHelper.dart';
import 'business_logic/cubit/social_cubit/login_cubit.dart';
import 'screens/Login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uid = CacheHelper.getData('uid');
  Bloc.observer = MyBlocObserver();
  Widget widget;
  if (uid != null) {
    widget = Home();
  } else {
    widget = Login();
  }

  runApp(SocialApp(
    widget,
  ));
}

class SocialApp extends StatelessWidget {
  Widget widget;
  SocialApp(this.widget) : super();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(
            create: (context) => HomeCubit()..getUser()..getPosts(),
            child: Home(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: widget,
          theme: ThemeData(
            fontFamily: 'Fav',
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                  fontFamily: 'Fav',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black),
              iconTheme: IconThemeData(color: Colors.black),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              ),
              backwardsCompatibility: false,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.blue,
                selectedLabelStyle:
                    TextStyle(fontFamily: 'Fav', color: Colors.black),
                showUnselectedLabels: true,
                showSelectedLabels: true,
                unselectedItemColor: Colors.grey[500],
                unselectedLabelStyle:
                    TextStyle(fontFamily: 'Fav', color: Colors.black)),
          ),
        ));
  }
}
