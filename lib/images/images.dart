import 'package:image_picker/image_picker.dart';

class Pickimage {
  final ImagePicker _imagepiker = ImagePicker();
  // ignore: unused_field
  XFile? _iamge;

  Future getimage(ImageSource source) async {
    try {
      final XFile? image = await _imagepiker.pickImage(source: source);
      return image;
    } catch (e) {
      return null;
    }
  }
}
