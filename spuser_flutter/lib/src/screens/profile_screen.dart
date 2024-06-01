import 'package:flutter/material.dart';
import 'package:spuser_client/spuser_client.dart';
import 'package:spuser_flutter/main.dart';
import 'package:spuser_flutter/src/screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    load();

    super.initState();
  }

  Future<void> load() async {
    final data = await client.user.me();

    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));

              load();
            },
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          if (user == null || user!.userInfo == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final userInfo = user!.userInfo!;
          final imageUrl = userInfo.imageUrl ?? '';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    if (imageUrl.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            imageUrl,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (userInfo.userName != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userInfo.userName!,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    if (userInfo.fullName != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userInfo.fullName!,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    if (user!.bio.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user!.bio,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
