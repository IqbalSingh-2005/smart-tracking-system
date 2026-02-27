import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Splash
import 'screens/splash_screen.dart';

/// Roles
import 'screens/role_selection_screen.dart';

/// Main Screens
import 'screens/passenger_screen.dart';
import 'screens/driver_screen.dart';
import 'screens/conductor_screen.dart';

/// Passenger Features
import 'screens/passenger/track_bus_screen.dart';
import 'screens/passenger/routes_screen.dart';
import 'screens/passenger/schedule_screen.dart';
import 'screens/passenger/ticket_screen.dart';
import 'screens/passenger/mytickets_screen.dart';
import 'screens/passenger/history_screen.dart';
import 'screens/passenger/profile_screen.dart';
import 'screens/passenger/alerts_screen.dart';

/// Chatbot
import 'screens/chatbot_screen.dart';

/// Help AI
import 'screens/help_screen.dart';


void main() async {

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

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Smart Transport System",

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3F51B5),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          elevation: 3,
        ),
      ),

      home: const SplashScreen(),

      routes: {

        /// Roles
        '/roles': (context) => const RoleSelectionScreen(),

        '/passenger': (context) => const PassengerScreen(),
        '/driver': (context) => const DriverScreen(),
        '/conductor': (context) => const ConductorScreen(),

        /// Passenger
        '/trackbus': (context) => const TrackBusScreen(),
        '/routes': (context) => const RoutesScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        '/tickets': (context) => const TicketScreen(),
        '/mytickets': (context) => const MyTicketsScreen(),
        '/history': (context) => const HistoryScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/alerts': (context) => const AlertsScreen(),

        /// Help + Chatbot
        '/chatbot': (context) => const ChatbotScreen(),
        '/help': (context) => const HelpScreen(),

      },

    );

  }

}