import 'package:flutter/material.dart';
import 'package:spuser_flutter/main.dart';
import 'package:spuser_flutter/src/screens/login_screen.dart';
import 'package:spuser_flutter/src/screens/profile_screen.dart';
import 'package:spuser_flutter/src/utils/dialogs.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    sessionManager.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (sessionManager.signedInUser == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text("Login"),
          ),
        ),
      );
    }

    final user = sessionManager.signedInUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${user.userName}"),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              final success = await sessionManager.signOut();
              if (success) {
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              }
            },
            child: const Text("Logout"),
          ),
          ElevatedButton(
            onPressed: () async {
              final username = await textPrompt(
                context,
                title: "New Username",
                initialValue: user.userName,
              );

              if (username != null && username.isNotEmpty) {
                final success = await client.modules.auth.user.changeUserName(username);
                if (success) {
                  sessionManager.refreshSession();
                }
              }
            },
            child: const Text("Change Username"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            child: const Text("My Profile"),
          )
        ],
      )),
    );
  }
}
