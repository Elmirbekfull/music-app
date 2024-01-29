import 'package:flutter/material.dart';
import 'package:music_player/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo
          DrawerHeader(
              child: Center(
            child: Icon(
              Icons.music_note,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 40,
            ),
          )),
          // home tile
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 25.0),
            child: ListTile(
              title: const Text(
                "Главная",
                style: TextStyle(fontSize: 18),
              ),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),
          // settings tile
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 25.0),
            child: ListTile(
              title: const Text(
                "Настройки",
                style: TextStyle(fontSize: 18),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                // pop drawer
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
            ),
          )
        ],
      ),
    );
  }
}
