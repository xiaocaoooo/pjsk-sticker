import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class PjskGenerator {
  static final List<String> groups = [
    "バーチャル・シンガー",
    "Leo/need",
    "MORE MORE JUMP!",
    "Vivid BAD SQUAD",
    "ワンダーランズ×ショウタイム",
    "25時、ナイトコードで。",
  ];

  static final Map<String, Color> groupColor = {
    "バーチャル・シンガー": Color.fromARGB(255, 0, 176, 240), // #00B0F0 虚拟歌手
    "Leo/need": Color.fromARGB(255, 0, 112, 192), // #0070C0 深蓝
    "MORE MORE JUMP!": Color.fromARGB(255, 255, 153, 204), // #FF99CC 粉红
    "Vivid BAD SQUAD": Color.fromARGB(255, 179, 153, 212), // #B399D4 紫色
    "ワンダーランズ×ショウタイム": Color.fromARGB(255, 255, 102, 0), // #FF6600 橙色
    "25時、ナイトコードで。": Color.fromARGB(255, 112, 48, 160), // #7030A0 深紫
  };

  static final Map<String, List<String>> groupMembers = {
    "バーチャル・シンガー": ["初音ミク", "鏡音リン", "鏡音レン", "巡音ルカ", "MEIKO", "KAITO"],
    "Leo/need": ["星乃一歌", "天馬咲希", "望月穂波", "日野森志歩"],
    "MORE MORE JUMP!": ["花里みのり", "桐谷遥", "桃井愛莉", "日野森雫"],
    "Vivid BAD SQUAD": ["小豆こはね", "白石杏", "東雲彰人", "青柳冬弥"],
    "ワンダーランズ×ショウタイム": ["天馬司", "鳳えむ", "草薙寧々", "神代類"],
    "25時、ナイトコードで。": ["宵崎奏", "朝比奈まふゆ", "東雲絵名", "暁山瑞希"],
  };

  static final Map<String, String> characterMap = {
    // バーチャル・シンガー
    "初音ミク": "miku",
    "鏡音リン": "rin",
    "鏡音レン": "len",
    "巡音ルカ": "luka",
    "MEIKO": "meiko",
    "KAITO": "kaito",
    // Leo/need
    "星乃一歌": "ichika",
    "天馬咲希": "saki",
    "望月穂波": "honami",
    "日野森志歩": "shiho",
    // MORE MORE JUMP!
    "花里みのり": "minori",
    "桐谷遥": "haruka",
    "桃井愛莉": "airi",
    "日野森雫": "shizuku",
    // Vivid BAD SQUAD
    "小豆こはね": "kohane",
    "白石杏": "an",
    "東雲彰人": "akito",
    "青柳冬弥": "touya",
    // ワンダーランズ×ショウタイム
    "天馬司": "tsukasa",
    "鳳えむ": "emu",
    "草薙寧々": "nene",
    "神代類": "rui",
    // 25時、ナイトコードで。
    "宵崎奏": "kanade",
    "朝比奈まふゆ": "mafuyu",
    "東雲絵名": "ena",
    "暁山瑞希": "mizuki",
  };

  static final Map<String, List<String>> characterStickers = {
    'airi': [
      'airi_01.png',
      'airi_02.png',
      'airi_03.png',
      'airi_04.png',
      'airi_06.png',
      'airi_07.png',
      'airi_08.png',
      'airi_09.png',
      'airi_11.png',
      'airi_12.png',
      'airi_13.png',
      'airi_14.png',
      'airi_16.png',
      'airi_17.png',
      'airi_18.png',
    ],
    'akito': [
      'akito_01.png',
      'akito_02.png',
      'akito_03.png',
      'akito_04.png',
      'akito_06.png',
      'akito_07.png',
      'akito_08.png',
      'akito_09.png',
      'akito_11.png',
      'akito_12.png',
      'akito_13.png',
      'akito_14.png',
      'akito_16.png',
    ],
    'an': [
      'an_01.png',
      'an_02.png',
      'an_03.png',
      'an_04.png',
      'an_06.png',
      'an_07.png',
      'an_08.png',
      'an_09.png',
      'an_11.png',
      'an_12.png',
      'an_13.png',
      'an_14.png',
      'an_16.png',
    ],
    'emu': [
      'emu_01.png',
      'emu_02.png',
      'emu_03.png',
      'emu_04.png',
      'emu_06.png',
      'emu_07.png',
      'emu_08.png',
      'emu_09.png',
      'emu_11.png',
      'emu_12.png',
      'emu_13.png',
      'emu_14.png',
      'emu_16.png',
    ],
    'ena': [
      'ena_01.png',
      'ena_02.png',
      'ena_03.png',
      'ena_04.png',
      'ena_06.png',
      'ena_07.png',
      'ena_08.png',
      'ena_09.png',
      'ena_11.png',
      'ena_12.png',
      'ena_13.png',
      'ena_14.png',
      'ena_16.png',
      'ena_17.png',
      'ena_18.png',
      'ena_19.png',
    ],
    'haruka': [
      'haruka_01.png',
      'haruka_02.png',
      'haruka_03.png',
      'haruka_04.png',
      'haruka_06.png',
      'haruka_07.png',
      'haruka_08.png',
      'haruka_09.png',
      'haruka_11.png',
      'haruka_12.png',
      'haruka_13.png',
      'haruka_14.png',
      'haruka_16.png',
    ],
    'honami': [
      'honami_01.png',
      'honami_02.png',
      'honami_03.png',
      'honami_04.png',
      'honami_06.png',
      'honami_07.png',
      'honami_08.png',
      'honami_09.png',
      'honami_11.png',
      'honami_12.png',
      'honami_13.png',
      'honami_14.png',
      'honami_16.png',
      'honami_17.png',
      'honami_18.png',
    ],
    'ichika': [
      'ichika_01.png',
      'ichika_02.png',
      'ichika_03.png',
      'ichika_04.png',
      'ichika_06.png',
      'ichika_07.png',
      'ichika_08.png',
      'ichika_09.png',
      'ichika_11.png',
      'ichika_12.png',
      'ichika_13.png',
      'ichika_14.png',
      'ichika_16.png',
      'ichika_17.png',
      'ichika_18.png',
    ],
    'kaito': [
      'kaito_01.png',
      'kaito_02.png',
      'kaito_03.png',
      'kaito_04.png',
      'kaito_06.png',
      'kaito_07.png',
      'kaito_08.png',
      'kaito_09.png',
      'kaito_11.png',
      'kaito_12.png',
      'kaito_13.png',
      'kaito_14.png',
      'kaito_16.png',
    ],
    'kanade': [
      'kanade_01.png',
      'kanade_02.png',
      'kanade_03.png',
      'kanade_04.png',
      'kanade_06.png',
      'kanade_07.png',
      'kanade_08.png',
      'kanade_09.png',
      'kanade_11.png',
      'kanade_12.png',
      'kanade_13.png',
      'kanade_14.png',
      'kanade_16.png',
      'kanade_17.png',
    ],
    'kohane': [
      'kohane_01.png',
      'kohane_02.png',
      'kohane_03.png',
      'kohane_04.png',
      'kohane_06.png',
      'kohane_07.png',
      'kohane_08.png',
      'kohane_09.png',
      'kohane_11.png',
      'kohane_12.png',
      'kohane_13.png',
      'kohane_14.png',
      'kohane_16.png',
      'kohane_17.png',
    ],
    'len': [
      'len_01.png',
      'len_02.png',
      'len_03.png',
      'len_04.png',
      'len_06.png',
      'len_07.png',
      'len_08.png',
      'len_09.png',
      'len_11.png',
      'len_12.png',
      'len_13.png',
      'len_14.png',
      'len_16.png',
      'len_17.png',
    ],
    'luka': [
      'luka_01.png',
      'luka_02.png',
      'luka_03.png',
      'luka_04.png',
      'luka_06.png',
      'luka_07.png',
      'luka_08.png',
      'luka_09.png',
      'luka_11.png',
      'luka_12.png',
      'luka_13.png',
      'luka_14.png',
      'luka_16.png',
    ],
    'mafuyu': [
      'mafuyu_01.png',
      'mafuyu_02.png',
      'mafuyu_03.png',
      'mafuyu_04.png',
      'mafuyu_06.png',
      'mafuyu_07.png',
      'mafuyu_08.png',
      'mafuyu_09.png',
      'mafuyu_11.png',
      'mafuyu_12.png',
      'mafuyu_13.png',
      'mafuyu_14.png',
      'mafuyu_16.png',
      'mafuyu_17.png',
    ],
    'meiko': [
      'meiko_01.png',
      'meiko_02.png',
      'meiko_03.png',
      'meiko_04.png',
      'meiko_06.png',
      'meiko_07.png',
      'meiko_08.png',
      'meiko_09.png',
      'meiko_11.png',
      'meiko_12.png',
      'meiko_13.png',
      'meiko_14.png',
      'meiko_16.png',
    ],
    'miku': [
      'miku_01.png',
      'miku_02.png',
      'miku_03.png',
      'miku_04.png',
      'miku_06.png',
      'miku_07.png',
      'miku_08.png',
      'miku_09.png',
      'miku_11.png',
      'miku_12.png',
      'miku_13.png',
      'miku_14.png',
      'miku_16.png',
    ],
    'minori': [
      'minori_01.png',
      'minori_02.png',
      'minori_03.png',
      'minori_04.png',
      'minori_06.png',
      'minori_07.png',
      'minori_08.png',
      'minori_09.png',
      'minori_11.png',
      'minori_12.png',
      'minori_13.png',
      'minori_14.png',
      'minori_16.png',
      'minori_17.png',
    ],
    'mizuki': [
      'mizuki_01.png',
      'mizuki_02.png',
      'mizuki_03.png',
      'mizuki_04.png',
      'mizuki_06.png',
      'mizuki_07.png',
      'mizuki_08.png',
      'mizuki_09.png',
      'mizuki_11.png',
      'mizuki_12.png',
      'mizuki_13.png',
      'mizuki_14.png',
      'mizuki_16.png',
      'mizuki_17.png',
    ],
    'nene': [
      'nene_01.png',
      'nene_02.png',
      'nene_03.png',
      'nene_04.png',
      'nene_06.png',
      'nene_07.png',
      'nene_08.png',
      'nene_09.png',
      'nene_11.png',
      'nene_12.png',
      'nene_13.png',
      'nene_14.png',
      'nene_16.png',
    ],
    'rin': [
      'rin_01.png',
      'rin_02.png',
      'rin_03.png',
      'rin_04.png',
      'rin_06.png',
      'rin_07.png',
      'rin_08.png',
      'rin_09.png',
      'rin_11.png',
      'rin_12.png',
      'rin_13.png',
      'rin_14.png',
      'rin_16.png',
    ],
    'rui': [
      'rui_01.png',
      'rui_02.png',
      'rui_03.png',
      'rui_04.png',
      'rui_06.png',
      'rui_07.png',
      'rui_08.png',
      'rui_09.png',
      'rui_11.png',
      'rui_12.png',
      'rui_13.png',
      'rui_14.png',
      'rui_16.png',
      'rui_17.png',
      'rui_18.png',
      'rui_19.png',
    ],
    'saki': [
      'saki_01.png',
      'saki_02.png',
      'saki_03.png',
      'saki_04.png',
      'saki_06.png',
      'saki_07.png',
      'saki_08.png',
      'saki_09.png',
      'saki_11.png',
      'saki_12.png',
      'saki_13.png',
      'saki_14.png',
      'saki_16.png',
      'saki_17.png',
      'saki_18.png',
    ],
    'shiho': [
      'shiho_01.png',
      'shiho_02.png',
      'shiho_03.png',
      'shiho_04.png',
      'shiho_06.png',
      'shiho_07.png',
      'shiho_08.png',
      'shiho_09.png',
      'shiho_11.png',
      'shiho_12.png',
      'shiho_13.png',
      'shiho_14.png',
      'shiho_16.png',
      'shiho_17.png',
      'shiho_18.png',
    ],
    'shizuku': [
      'shizuku_01.png',
      'shizuku_02.png',
      'shizuku_03.png',
      'shizuku_04.png',
      'shizuku_06.png',
      'shizuku_07.png',
      'shizuku_08.png',
      'shizuku_09.png',
      'shizuku_11.png',
      'shizuku_12.png',
      'shizuku_13.png',
      'shizuku_14.png',
      'shizuku_16.png',
    ],
    'touya': [
      'touya_01.png',
      'touya_02.png',
      'touya_03.png',
      'touya_04.png',
      'touya_06.png',
      'touya_07.png',
      'touya_08.png',
      'touya_09.png',
      'touya_11.png',
      'touya_12.png',
      'touya_13.png',
      'touya_14.png',
      'touya_16.png',
      'touya_17.png',
      'touya_18.png',
    ],
    'tsukasa': [
      'tsukasa_01.png',
      'tsukasa_02.png',
      'tsukasa_03.png',
      'tsukasa_04.png',
      'tsukasa_06.png',
      'tsukasa_07.png',
      'tsukasa_08.png',
      'tsukasa_09.png',
      'tsukasa_11.png',
      'tsukasa_12.png',
      'tsukasa_13.png',
      'tsukasa_14.png',
      'tsukasa_16.png',
      'tsukasa_17.png',
      'tsukasa_18.png',
    ],
  };

  static final Map<String, Color> characterColor = {
    "airi": Color.fromARGB(255, 216, 95, 116),
    "akito": Color.fromARGB(255, 224, 94, 62),
    "an": Color.fromARGB(255, 91, 91, 106),
    "emu": Color.fromARGB(255, 212, 129, 169),
    "ena": Color.fromARGB(255, 109, 91, 101),
    "haruka": Color.fromARGB(255, 49, 94, 168),
    "honami": Color.fromARGB(255, 172, 125, 130),
    "ichika": Color.fromARGB(255, 77, 93, 127),
    "kaito": Color.fromARGB(255, 46, 63, 181),
    "kanade": Color.fromARGB(255, 176, 185, 214),
    "kohane": Color.fromARGB(255, 182, 172, 145),
    "len": Color.fromARGB(255, 244, 224, 135),
    "luka": Color.fromARGB(255, 240, 198, 223),
    "mafuyu": Color.fromARGB(255, 97, 72, 146),
    "meiko": Color.fromARGB(255, 168, 136, 93),
    "miku": Color.fromARGB(255, 128, 194, 197),
    "minori": Color.fromARGB(255, 201, 142, 124),
    "mizuki": Color.fromARGB(255, 217, 179, 176),
    "nene": Color.fromARGB(255, 183, 186, 174),
    "rin": Color.fromARGB(255, 246, 231, 141),
    "rui": Color.fromARGB(255, 206, 160, 240),
    "saki": Color.fromARGB(255, 246, 201, 217),
    "shiho": Color.fromARGB(255, 179, 173, 179),
    "shizuku": Color.fromARGB(255, 141, 170, 197),
    "touya": Color.fromARGB(255, 167, 180, 222),
    "tsukasa": Color.fromARGB(255, 235, 190, 155),
  };

  static final Map<String, int> characterLen = {
    "airi": 18,
    "akito": 16,
    "an": 16,
    "emu": 16,
    "ena": 19,
    "haruka": 16,
    "honami": 18,
    "ichika": 18,
    "kaito": 16,
    "kanade": 17,
    "kohane": 17,
    "len": 17,
    "luka": 16,
    "mafuyu": 17,
    "meiko": 16,
    "miku": 16,
    "minori": 17,
    "mizuki": 17,
    "nene": 16,
    "rin": 16,
    "rui": 19,
    "saki": 18,
    "shiho": 18,
    "shizuku": 16,
    "touya": 18,
    "tsukasa": 18,
  };

  static final characterList = [
    "airi",
    "akito",
    "an",
    "emu",
    "ena",
    "haruka",
    "honami",
    "ichika",
    "kaito",
    "kanade",
    "kohane",
    "len",
    "luka",
    "mafuyu",
    "meiko",
    "miku",
    "minori",
    "mizuki",
    "nene",
    "rin",
    "rui",
    "saki",
    "shiho",
    "shizuku",
    "touya",
    "tsukasa",
  ];

  static final List<Offset> offsets = [
    // (0,0)为中心 8个方向
    Offset(0, 1),
    Offset(1, 1),
    Offset(1, 0),
    Offset(1, -1),
    Offset(0, -1),
    Offset(-1, -1),
    Offset(-1, 0),
    Offset(-1, 1),
  ];

  static Future<Uint8List> pjsk({
    required String content,
    String character = "",
    Offset pos = const Offset(20, 10),
    double lean = 15,
    double fontSize = 50,
    int edgeSize = 4,
    int font = 1,
    Color? color,
    // String? fileName,
  }) async {
    // fileName ??= "pjsk_${DateTime.now().millisecondsSinceEpoch}.png";
    // fileName ??= "pjsk.png";
    // 处理文本内容
    // content = content.replaceAll("&br", "\n").replaceAll("&sp", " ");

    // 确定角色和图片路径
    String characterName = character.toLowerCase().replaceAll(
      RegExp(r'[^a-z]'),
      '',
    );
    characterName =
        characterList.contains(characterName)
            ? characterName
            : characterList[DateTime.now().millisecond % characterList.length];

    // 处理角色编号
    String charNumber = character.replaceAll(RegExp(r'[^0-9]'), '');
    int? charNum = int.tryParse(charNumber);
    if (charNum == null ||
        charNum <= 0 ||
        charNum > characterLen[characterName]! ||
        charNum % 5 == 0) {
      final validNumbers =
          List.generate(
            characterLen[characterName]!,
            (i) => i + 1,
          ).where((n) => n % 5 != 0).toList();
      charNum = validNumbers[DateTime.now().millisecond % validNumbers.length];
    }

    final charPath =
        'assets/characters/$characterName/${characterName}_${charNum.toString().padLeft(2, '0')}.png';

    // 创建临时目录
    // final tempDir = await getTemporaryDirectory();
    // final outputFile = File('${tempDir.path}/$fileName');

    // 加载背景图片
    final bgImage = await _loadImage(charPath);

    Color fontColor = color ?? characterColor[characterName]!;
    // if (characterName == "miku" && charNum == 16) {
    //   fontColor = groupColor["25時,ナイトコードで."]!;
    // }

    // 生成文本图片
    final textPainter = await _createTextPainter(
      content: content,
      fontSize: fontSize,
      edgeSize: edgeSize,
      font: font,
      color: fontColor,
      lean: lean,
    );

    // 合成最终图片
    final image = await _compositeImages(bgImage, textPainter, pos);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // await outputFile.writeAsBytes(byteData!.buffer.asUint8List());
    // print(outputFile.path);

    // return outputFile;
    return byteData!.buffer.asUint8List();
  }

  static Future<ui.Image> _loadImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return decodeImageFromList(Uint8List.view(data.buffer));
  }

  static Future<TextPainter> _createTextPainter({
    required String content,
    required double fontSize,
    required int edgeSize,
    required int font,
    required Color color,
    required double lean,
  }) async {
    // 加载字体
    final fontLoader =
        font == 1 ? 'Fonts/ShangShouFangTangTi.ttf' : 'Fonts/YurukaStd.ttf';

    final fontData = await rootBundle.load(fontLoader);
    final fontProvider = FontLoader('customFont')
      ..addFont(Future.value(fontData));
    await fontProvider.load();

    final textStyle = TextStyle(
      fontFamily: 'customFont',
      fontSize: fontSize,
      color: color,
      shadows:
          offsets
              .map(
                (offset) => Shadow(
                  color: Colors.white, // 阴影颜色
                  offset: offset * edgeSize.toDouble(),
                  blurRadius: 0, // 阴影模糊半径
                ),
              )
              .toList(), // 添加阴影到文本样式
    );

    // 计算文本尺寸
    final lines = content.split('\n');
    double maxWidth = 0;
    // double totalHeight = 0;

    for (final line in lines) {
      final textSpan = TextSpan(text: line, style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth = maxWidth > textPainter.width ? maxWidth : textPainter.width;
      // totalHeight += fontSize * 0.97;
    }

    // 创建文本绘制器
    final painter = TextPainter(
      text: TextSpan(text: content, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return painter;
  }

  static Future<ui.Image> _compositeImages(
    ui.Image bgImage,
    TextPainter textPainter,
    Offset position,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 绘制背景
    canvas.drawImage(bgImage, Offset.zero, Paint());

    // 绘制文本
    final textOffset = position;
    textPainter.paint(canvas, textOffset);

    final picture = recorder.endRecording();
    return await picture.toImage(bgImage.width, bgImage.height);
  }

  static void printAvailableAssets() async {
    // final manifest = await rootBundle.loadString('AssetManifest.json');
    // final json = jsonDecode(manifest) as Map<String, dynamic>;
    // final paths = json.keys.where((k) => k.contains('characters/')).toList();
    // print('Available character assets:');
    // paths.forEach(print);
  }
}
