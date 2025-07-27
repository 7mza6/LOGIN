import 'package:flutter/material.dart';
import '../services/biometric_servic.dart';

class UsersSheet {
  final Map<String, String> userPasswords;
  UsersSheet(this.userPasswords);
  String? selectedUser;

  Future<String> showUserSelectionSheet(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.4,
            maxChildSize: 0.6,
            minChildSize: 0.3,
            controller: DraggableScrollableController(),
            builder: (BuildContext context,ScrollController scrollController) {
              return Padding(
                padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Your Account',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0),
                      Row(
                        children: [
                          Text(
                            'Use biometric authentication to login',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9.0),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: scrollController,
                          child: Column(
                            children: UsersButtons(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                
              );
            },
          );
        });
    return selectedUser ?? '';
  }

  List<Widget> UsersButtons(BuildContext context) {
    List<String> usernames = userPasswords.keys.toList();
    List<Widget> buttons = [];
    for (String username in usernames) {
      buttons.add(
        UserButton(
          userName: username,
          avatarUrl:
              'https://api.nekosapi.com/v4/images/random/file',
          onPressed: () {
            selectedUser = username;
            Navigator.pop(context);
          },
        ),
      );
    }
    return buttons;
  }
}

class UserButton extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final VoidCallback onPressed;

  const UserButton({
    Key? key,
    required this.userName,
    required this.avatarUrl,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              offset: Offset(0.5, 0.5),
              blurRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              offset: Offset(-0.5, -0.5),
              blurRadius: 1,
            ),
          ],
          border: Border.all(
            color: Colors.black,
            width: 0.0000000001,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          minVerticalPadding: 10.0, // Sets a minimum height of 100 logical pixels

          leading: CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
          ),
          title: Text(userName),
          onTap: onPressed,
        ),
      ),
    );
  }
}
