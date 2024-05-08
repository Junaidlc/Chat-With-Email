import 'package:chatapp_with_firebase/services/auth/auth_service.dart';
import 'package:chatapp_with_firebase/pages/settings_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

    void logout() {
    // get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // logo
          Column(
            children: [
              Center(
                child: DrawerHeader(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),

              // home tile
               Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(
                    Icons.home,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              // settings
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(
                    Icons.settings,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(
                Icons.logout_outlined,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
