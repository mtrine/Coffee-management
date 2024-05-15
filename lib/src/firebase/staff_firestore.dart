import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/models/staff.dart';

class StaffFireStore {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collection = 'Staff'; // Tên của collection trong Firestore

  
  Future<void> delete(String id) async {
    try {
      await firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print("Error: $e");
      rethrow; // Ném ngoại lệ để báo lỗi nếu có
    }
  }


  
  Future<Staff> getById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore.collection(
          _collection).doc(id).get();
      return Staff(id,doc['fName'],doc['mlName'],doc['password'],doc['phone'],doc['address'],doc['bDate']);
    } catch (e) {
      print("Error: $e");
      rethrow; // Ném ngoại lệ để báo lỗi nếu có
    }
  }


  Future<void> insert(Staff data) async {
    try {
      await firestore.collection(_collection).add(data.toJson());
    } catch (e) {
      print("Error: $e");
      rethrow; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  
  Future<void> update(Staff data) async {
    try {
      await firestore.collection(_collection).doc(data.id).update({
        'fName':data.fname,
        'mlName':data.mlname,
        'address':data.address,
        'phone':data.phone,
        'bDate':data.dob
      });
    } catch (e) {
      print("Error: $e");
      rethrow; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  Future<Staff?> getByPhone(String phone) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection(_collection).where('phone', isEqualTo: phone).get();
      if (querySnapshot.docs.isNotEmpty) {
        return Staff.fromFirestore(querySnapshot.docs.first);
      }
    }
    catch (e) {
      print("Error: $e");
      rethrow;
    }
    return null;
  }

  Future<String?> getLastDocumentId() async {
    try {
      // Lấy tất cả các document trong collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(_collection)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Lấy document cuối cùng trong danh sách các document
        DocumentSnapshot lastDocument = querySnapshot.docs.last;
        String lastDocumentId = lastDocument.id;
        return lastDocumentId;
      } else {
        print('Collection is empty.');
      }
    } catch (e) {
      print('Error fetching last document: $e');
    }
    return null;
  }
}