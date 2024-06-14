import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/firebase_options.dart';
import 'package:urgentrishtapp/providers/chat_providers/add_participants_provider.dart';
import 'package:urgentrishtapp/providers/chat_providers/chat_file_provider.dart';
import 'package:urgentrishtapp/providers/providers.dart';
import 'package:urgentrishtapp/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationProvider>(
          create: (context) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider<PasswordIconToggleProvider>(
          create: (context) => PasswordIconToggleProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider<MaritalStatusProvider>(
          create: (context) => MaritalStatusProvider(),
        ),
        ChangeNotifierProvider<ChatFileProvider>(
          create: (context) => ChatFileProvider(),
        ),
        ChangeNotifierProvider<AddParticipantsProvider>(
          create: (context) => AddParticipantsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.white,
            elevation: 0.0,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            background: Colors.white,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
