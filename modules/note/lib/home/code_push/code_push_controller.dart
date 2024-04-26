import 'package:shorebird_code_push/shorebird_code_push.dart';

class CodePushAppController {
  final shorebirdCodePush = ShorebirdCodePush();
  bool isDownload = false;

  void init() {
    // Get the current patch number and print it to the console. It will be
    // null if no patches are installed.
    print('CodePushAppController init');
    try {
      shorebirdCodePush.currentPatchNumber().then((value) => print('current patch code push number is $value'));
      checkForUpdateAndDownload();
    } catch (e) {
      // TODO
      print('CodePushAppController $e');
    }
  }

  Future<void> checkForUpdateAndDownload() async {
    if (isDownload) {
      return;
    }
    // Check whether a patch is available to install.
    final isUpdateAvailable = await shorebirdCodePush.isNewPatchAvailableForDownload();

    if (isUpdateAvailable) {
      isDownload = true;
      // Download the new patch if it's available.
      await shorebirdCodePush.downloadUpdateIfAvailable();
    }
  }
}
