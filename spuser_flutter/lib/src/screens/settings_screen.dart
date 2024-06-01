import 'package:flutter/material.dart';
import 'package:spuser_client/spuser_client.dart';
import 'package:spuser_flutter/main.dart';
import 'package:spuser_flutter/src/utils/dialogs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        title: const Text("Settings"),
      ),
      body: Builder(builder: (context) {
        if (user == null) {
          return const SizedBox();
        }

        return ListView(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  user!.bio,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: const Text("Bio"),
                trailing: TextButton(
                  onPressed: () async {
                    final bio = await textPrompt(context, title: "Change Bio", initialValue: user!.bio);
                    if (bio != null) {
                      final updatedUser = await client.user.updateBio(bio);
                      if (updatedUser != null) {
                        setState(() {
                          user = updatedUser;
                        });
                      }
                    }
                  },
                  child: const Text("Edit"),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
