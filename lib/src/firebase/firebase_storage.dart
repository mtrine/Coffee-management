import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<XFile?> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  Future<String> uploadFile(File file, String folderName) async {
    try {
      var imageName = DateTime.now().millisecondsSinceEpoch.toString();
      var storageRef = _storage.ref().child('$folderName/$imageName.jpg');

      // Tải hình lên Firebase
      var uploadTask = storageRef.putFile(file);

      // Chờ cho đến khi tệp được tải lên sau đó lưu trữ url tải xuống
      var snapshot = await uploadTask;
      var downloadUrl = await snapshot.ref.getDownloadURL();

      // Trả về url tải xuống
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      throw e; // Rethrow để cho phép các phần khác của ứng dụng xử lý lỗi này nếu cần
    }
  }
}
