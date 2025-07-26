import 'dart:convert';
import 'dart:typed_data';
import 'package:web/web.dart' as web;

// Web 平台特有的下载逻辑
void downloadImageWeb(Uint8List byteData) {
  final String fileName = 'pjsk_sticker_${DateTime.now().millisecondsSinceEpoch}.png';
  final String base64Data = base64Encode(byteData);
  final String dataUrl = 'data:image/png;base64,$base64Data';

  final web.HTMLAnchorElement element = web.document.createElement('a') as web.HTMLAnchorElement
    ..href = dataUrl
    ..download = fileName
    ..style.display = 'none';

  web.document.body?.appendChild(element);
  element.click();
  element.remove();
}
