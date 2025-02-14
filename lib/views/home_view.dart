import 'package:chat_application/constant/size_constant.dart';
import 'package:chat_application/controller/login_controller.dart';
import 'package:chat_application/views/chatting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                loginController.logOut(context);
              },
              icon: Icon(
                Icons.logout,
                size: 25,
              ),
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
        title: Text(
          "U S E R S",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: SizeConstant.deviceWidth / SizeConstant.baseWidth * 17,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                // Exclude the current user
                var users = snapshot.data!.docs
                    .where((user) =>
                        user.id != FirebaseAuth.instance.currentUser!.uid)
                    .toList();

                if (users.isEmpty) {
                  return Center(child: Text("No users available"));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ChattingPage(
                              email: user['email'],
                              receiverId: user['userId']));
                        },
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                user["userName"]
                                    [0], // First letter of user name
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(user["userName"] ?? "Unknown"),
                            subtitle: Text(user["email"] ?? "No email"),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
