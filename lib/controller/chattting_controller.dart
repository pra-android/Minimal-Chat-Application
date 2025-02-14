import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatttingController extends GetxController {
  TextEditingController messageController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  final selectedImage = Rxn<File>();
  var isLoading = false.obs;
  var uploadedImageUrl = ''.obs;

  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      uploadMessageImage("chatting/images");
    } else {
      Get.snackbar('Cancelled', 'No image selected.',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  //uploading the message
  Future<void> uploadMessageImage(String folderName) async {
    const cloudName = "dvqlshrm4"; // Replace with your Cloudinary cloud name
    const uploadPreset = "chattingapp";
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    try {
      isLoading.value = true;
      var request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = uploadPreset;
      request.fields['public_id'] =
          '$folderName/${selectedImage.value!.path.split('/').last}';

      request.files.add(
          await http.MultipartFile.fromPath('file', selectedImage.value!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);

        uploadedImageUrl.value = jsonResponse['secure_url'];

        log('Uploaded Image URL: ${uploadedImageUrl.value}');
        Get.snackbar('Success', 'Click on Send button to send the images',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        log('Upload failed with status code: ${response.statusCode}');
        Get.snackbar('Error', 'Image upload failed!');
      }
    } catch (e) {
      log('Error uploading image: $e');
      Get.snackbar('Error', 'Failed to upload the image.',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  String getChatId(String user1, String user2) {
    List<String> ids = [user1, user2];
    ids.sort(); // Sort to ensure same ID for both users
    return ids.join("_");
  }

  void sendMessage(String? message, String receiverId, String? imageUrl) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(getChatId(FirebaseAuth.instance.currentUser!.uid, receiverId))
        .collection('messages')
        .add({
      'senderId': FirebaseAuth.instance.currentUser!.uid,
      'receiverId': receiverId,
      'message': message ?? '',
      'timeStamp': FieldValue.serverTimestamp(),
      'imageUrl': imageUrl ?? ''
    });

    messageController.clear();
  }
}
