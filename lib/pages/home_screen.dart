import 'package:chatapp_with_firebase/conponents/my_drawer.dart';
import 'package:chatapp_with_firebase/conponents/my_usertile.dart';
import 'package:chatapp_with_firebase/pages/chat_screen.dart';
import 'package:chatapp_with_firebase/services/auth/auth_service.dart';
import 'package:chatapp_with_firebase/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // chat and auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: const Text("Home"),
      ),
      body: SafeArea(
        child: _buildUserList(),
      ),
    );
  }

  // build a list of user except for the existing logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // log()

        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            "Loading...",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        if (snapshot.data?.isEmpty ?? [].isEmpty) {
          return const Text(
            "No Users",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all user except current user
    if (userData["email"] != _authService.getCurrentUser()?.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
