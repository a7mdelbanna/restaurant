import 'package:flutter/material.dart';

import '../view/screens/cart_screen.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/menu_screen.dart';
import '../view/screens/select_restaurant_city.dart';

// class AppRouter {
//   static Route generateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         );
//       case '/menu':
//         return MaterialPageRoute(
//           builder: (context) => MenuScreen(),
//         );
//       case '/select_city':
//         return MaterialPageRoute(
//           builder: (context) => SelectCity(),
//         );
//       case '/cart':
//         return MaterialPageRoute(
//           builder: (context) => CartScreen(),
//         );
//       // case '/cart':
//       //   return MaterialPageRoute(
//       //     builder: (context) => FoodDetailsScreen(meal: args),
//       //   );
//       // case '/order':
//       //   return MaterialPageRoute(
//       //     builder: (context) => OrderScreen(),
//       //   );
//       case '/location':
//         return MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         );
//       case '/profile':
//         return MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         );
//       default:
//         return _errorRoute();
//     }
//   }
//
//   static Route _errorRoute() {
//     return MaterialPageRoute(
//         builder: (context) => Scaffold(
//               appBar: AppBar(
//                 centerTitle: true,
//                 backgroundColor: Colors.white,
//                 title: const Text('ERROR'),
//               ),
//               body: const Center(
//                 child: Text('PAGE NOT FOUND!'),
//               ),
//             ));
//   }
// }
