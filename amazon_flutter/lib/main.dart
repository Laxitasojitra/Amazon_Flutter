// import 'dart:html';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/admin/screens/admin_screen.dart';
import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
// import 'package:amazon_flutter/features/home/screens/home_screen.dart';
// import 'package:amazon_flutter/features/home/screens/home_screen.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
// import 'features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:amazon_flutter/features/auth/services/auth_service.dart';
import 'common/widgets/bottom_bar.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ],
  child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

    @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon Clone',
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
            appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                )
                )
                ),
        onGenerateRoute: (settings) => generateRoute(settings),
         home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
         
    );      
  }
}





// import 'package:amazon_flutter/constants/global_variables.dart';
// import 'package:amazon_flutter/features/admin/screens/admin_screen.dart';
// import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
// import 'package:amazon_flutter/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:amazon_flutter/router.dart';
// import 'package:flutter/material.dart';
// import 'package:amazon_flutter/features/auth/services/auth_service.dart';
// import 'common/widgets/bottom_bar.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => UserProvider(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Amazon Clone',
//       theme: ThemeData(
//         scaffoldBackgroundColor: GlobalVariables.backgroundColor,
//         colorScheme: const ColorScheme.light(
//           primary: GlobalVariables.secondaryColor,
//         ),
//         appBarTheme: const AppBarTheme(
//           elevation: 0,
//           iconTheme: IconThemeData(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       onGenerateRoute: (settings) => generateRoute(settings),
//       home: Consumer<UserProvider>(
//         builder: (context, userProvider, child) {
//           final authService = AuthService();

//           // Check if the user is logged in and their type
//           if (userProvider.user.token.isNotEmpty) {
//             return userProvider.user.type == 'user'
//                 ? const BottomBar()
//                 : const AdminScreen();
//           } else {
//             // If not logged in, show the authentication screen
//             return const AuthScreen();
//           }
//         },
//       ),
//     );
//   }
// }
