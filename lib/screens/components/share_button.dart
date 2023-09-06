import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final ScreenshotController screenshotController;

  const ShareButton({super.key, required this.screenshotController});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final image = await screenshotController.capture();
          if (image == null) return;
          await saveAndShare(image);
        },
        child: const Text("share"));
  }

  saveImage(Uint8List bytes) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareXFiles(image.path as List<XFile>);
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }
}
