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
import 'screens/passenger/journey_planner_screen.dart';

/// Chatbot
import 'screens/chatbot_screen.dart';

/// Help AI
import 'screens/help_screen.dart';

/// Stats
import 'screens/stats_screen.dart';

/// Theme notifier (app-wide dark/light toggle)
final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // ── Light theme ──────────────────────────────────────────────────────────
  static final _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F51B5),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
    cardTheme: const CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      elevation: 3,
    ),
  );

  // ── Dark technical theme ──────────────────────────────────────────────────
  static final _darkTheme = () {
    const borderColor = Color(0xFF1E2E50);
    final borderSide = BorderSide(color: borderColor.withOpacity(0.8));
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00B4D8),
        brightness: Brightness.dark,
      ).copyWith(
        surface: const Color(0xFF0D1421),
        onSurface: Colors.white,
        surfaceContainerHighest: const Color(0xFF1A2440),
      ),
      scaffoldBackgroundColor: const Color(0xFF0A0E1A),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF0D1421),
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF131929),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          side: borderSide,
        ),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF131929),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: borderSide,
        ),
      ),
      dividerColor: borderColor,
      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xFF00B4D8),
      ),
    );
  }();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) => MaterialApp(

        debugShowCheckedModeBanner: false,
        title: "Smart Transport System",

        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: mode,

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
          '/journey': (context) => const JourneyPlannerScreen(),

          /// Help + Chatbot
          '/chatbot': (context) => const ChatbotScreen(),
          '/help': (context) => const HelpScreen(),

          /// Live Stats
          '/stats': (context) => const StatsScreen(),

        },

      ),
    );
  }

}