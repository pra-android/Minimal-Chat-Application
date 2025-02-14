import 'dart:developer';
import 'package:chat_application/constant/size_constant.dart';
import 'package:chat_application/controller/chattting_controller.dart';
import 'package:chat_application/views/image_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChattingPage extends StatefulWidget {
  final String? email;
  final String? receiverId;

  const ChattingPage(
      {super.key, required this.email, required this.receiverId});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  ChatttingController chatttingController = Get.put(ChatttingController());
  Set<int> tappedMessage = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              size: SizeConstant.deviceWidth / SizeConstant.baseWidth * 16,
            )),
        title: Text(
          widget.email!,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize:
                      SizeConstant.deviceWidth / SizeConstant.baseWidth * 16)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatttingController.getChatId(
                      FirebaseAuth.instance.currentUser!.uid,
                      widget.receiverId!))
                  .collection('messages')
                  .orderBy('timeStamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var messageDoc = messages[index];
                    var message = messageDoc.data();
                    String messageId = messageDoc.id;
                    bool isMe = message['senderId'] ==
                        FirebaseAuth.instance.currentUser!.uid;
                    Timestamp? timestamp = message['timeStamp'] as Timestamp?;
                    DateTime dateTime =
                        timestamp != null ? timestamp.toDate() : DateTime.now();
                    String formattedTime =
                        DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (tappedMessage.contains(index)) {
                                    tappedMessage.remove(index);
                                  } else {
                                    tappedMessage.add(index);
                                  }
                                });
                              },
                              onLongPress: () {
                                Get.bottomSheet(
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.edit,
                                              color: Colors.blue),
                                          title: Text("Edit Message"),
                                          onTap: () {
                                            Get.back();
                                            _showEditDialog(
                                                messageId, message['message']);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.delete,
                                              color: Colors.red),
                                          title: Text("Delete Message"),
                                          onTap: () {
                                            Get.back();
                                            _confirmDeleteMessage(messageId);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isMe ? Colors.green : Colors.black,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: message['imageUrl'] != ''
                                      ? InkWell(
                                          onTap: () {
                                            Get.to(() => ImageViewScreen(
                                                imageUrl: message['imageUrl']));
                                          },
                                          child: Image.network(
                                            message['imageUrl'],
                                            width: 150,
                                          ),
                                        )
                                      : Text(message['message'],
                                          style:
                                              TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            if (tappedMessage.contains(index))
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(
                                      fontSize: SizeConstant.deviceWidth /
                                          SizeConstant.baseWidth *
                                          12,
                                      color: Colors.black),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: chatttingController.messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                suffixIcon: IconButton(
                    onPressed: () async {
                      await chatttingController.pickImage();
                    },
                    icon: Icon(Icons.add_photo_alternate)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.green.shade700,
            child: IconButton(
              onPressed: () {
                chatttingController.sendMessage(
                    chatttingController.messageController.text,
                    widget.receiverId!,
                    chatttingController.uploadedImageUrl.value);
              },
              icon: Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteMessage(String messageId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatttingController.getChatId(
            FirebaseAuth.instance.currentUser!.uid, widget.receiverId!))
        .collection('messages')
        .doc(messageId)
        .delete();
    // FirebaseFirestore.instance.collection('messages').doc(messageId).delete();
  }

  void _showEditDialog(String messageId, String currentText) async {
    TextEditingController editController =
        TextEditingController(text: currentText);

    Get.defaultDialog(
      title: "Edit Message",
      content: TextField(
          controller: editController,
          decoration: InputDecoration(hintText: "Enter new message")),
      confirm: ElevatedButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats')
              .doc(chatttingController.getChatId(
                  FirebaseAuth.instance.currentUser!.uid, widget.receiverId!))
              .collection('messages')
              .doc(messageId)
              .update({'message': editController.text, 'edited': true}).then(
                  (_) {
            Get.back(); // Close the dialog
          }).catchError((error) {
            log("Error updating message: $error");
          });
        },
        child: Text("Update"),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        child: Text("Cancel"),
      ),
    );
  }
}
