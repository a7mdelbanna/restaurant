import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/data/localservices/cache_local_services.dart';
import 'package:restaurant/data/webservices/auth_web_services.dart';
import 'package:restaurant/view/screens/bonus_screen.dart';
import 'package:restaurant/view/screens/home_screen.dart';
import 'package:restaurant/view/screens/login_screen.dart';
import 'package:restaurant/view/screens/signup_screen.dart';

import 'config/theme.dart';
import 'controller/bloc/blocs/cart/cart_bloc.dart';
import 'controller/bloc/blocs/orders/orders_bloc.dart';
import 'controller/bloc/cubit/authintication/auth_cubit.dart';
import 'controller/bloc/cubit/meals/meals_cubit.dart';
import 'controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/cart_repository.dart';
import 'data/repositories/categories_repository.dart';
import 'data/repositories/meal_repository.dart';
import 'data/repositories/offers_repository.dart';
import 'data/repositories/order_repository.dart';
import 'data/webservices/categories_web_services.dart';
import 'data/webservices/meals_web_services.dart';
import 'data/webservices/offers_web_services.dart';
import 'data/webservices/order_web_services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Widget pushNext;
  await SharedCache.cacheInit();
  String uid = SharedCache.getLastLoggedIn('lastUser') ?? '';
  bool keepLogged = SharedCache.getKeepLogged('keepLogged') ?? false;

  if (!keepLogged) {
    if (uid == '') {
      pushNext = RegistrationPage();
    } else {
      pushNext = LoginPage();
    }
  } else if (keepLogged && uid != '') {
    pushNext = HomeScreen();
  } else {
    pushNext = LoginPage();
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(
    pushNext: pushNext,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.pushNext}) : super(key: key);
  Widget pushNext;
  Connectivity connectivity = Connectivity();
  final CartRepository cartRepository = CartRepository();
  final MealsCubit mealsCubit = MealsCubit(MealsRepository(MealsWebServices()),
      CategoriesRepository(CategoriesWebServices()));
  final OffersRepository offersRepository =
      OffersRepository(OffersWebServices());
  // final SettingsRepository settingsRepository =
  // SettingsRepository(SettingsWebServices());
  final OrderRepository orderRepository = OrderRepository(OrderWebServices());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NetworkConnectivityCubit>(
            create: (BuildContext context) =>
                NetworkConnectivityCubit(connectivity: connectivity)
                  ..checkConnection(),
          ),
          BlocProvider<AuthCubit>(
            create: (BuildContext context) =>
                AuthCubit(AuthRepository(AuthWebServices())),
          ),

          // BlocProvider<HomeCubit>(
          //     create: (BuildContext context) => HomeCubit()),
          //
          BlocProvider<MealsCubit>(
              create: (BuildContext context) => mealsCubit),
          BlocProvider<OrdersBloc>(
              create: (BuildContext context) =>
                  OrdersBloc(orderRepository, 'LoginCubit.get(context).uid!')),
          BlocProvider<CartBloc>(
              create: (BuildContext context) => CartBloc(cartRepository)),

          // BlocProvider<OffersCubit>(
          //   create: (BuildContext context) => OffersCubit(offersRepository),
          // ),
          // BlocProvider<UserSettingsCubit>(
          //     create: (context) => UserSettingsCubit()..getUserSettings())
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 712.0),
            minTextAdapt: false,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
                  builder: (context, child) {
                    return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: child!);
                  },
                  debugShowCheckedModeBanner: false,
                  title: 'Restaurant',
                  theme: CustomTheme.lightTheme,
                  home: BonusScreen(),
                )));
  }
}
