import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController { // Renamed the class
  final ImagePicker picker = ImagePicker();

  Future<String> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      return image.path;
    } else {
      print('Image not found');
      return " ";
    }

  }


}
