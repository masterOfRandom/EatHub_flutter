import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageMethods {
  final _storage = FirebaseStorage.instance;

  getFoodImageUrl(String name) async {
    final ref = _storage.ref().child('default_food_images/갈비찜.jpg');
    final url = await ref.getDownloadURL();
    print(url);
  }
}
