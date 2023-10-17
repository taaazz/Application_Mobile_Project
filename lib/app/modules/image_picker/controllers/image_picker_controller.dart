import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<XFile>> pickImage({
    required ImageSource source,
    int imageQuality = 100,
    bool multiple = false,
  }) async {
    ImagePicker imagePicker = ImagePicker();

    if (multiple) {
      return await imagePicker.pickMultiImage(imageQuality: imageQuality);
    }

    final file = await imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );

    if (file != null) return [file];

    return [];
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    ImageCropper imageCropper = ImageCropper();

    return await imageCropper.cropImage(
      cropStyle: cropStyle,
      sourcePath: file.path,
      compressQuality: 100,
      uiSettings: [
        IOSUiSettings(),
        AndroidUiSettings(),
      ],
    );
  }
}
