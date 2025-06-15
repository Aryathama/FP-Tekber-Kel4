// services/local/image_picker_service.dart
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage({required ImageSource source}) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      return image;
    } catch (e) {
      // Nanti bisa diganti dengan logging service atau dialog
      print("Error picking image: $e");
      return null;
    }
  }
}
