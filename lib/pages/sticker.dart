import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pjsk_sticker/pages/about.dart';
import 'package:pjsk_sticker/sticker.dart';
import 'package:share_plus/share_plus.dart';

class StickerPage extends StatefulWidget {
  const StickerPage({super.key});
  @override
  State<StickerPage> createState() => _StickerPageState();
}

class _StickerPageState extends State<StickerPage> {
  final TextEditingController _contextController = TextEditingController(
    text: "わんだほーい",
  );
  String? _selectedGroup;
  String? _selectedCharacter = "emu";
  int _selectedSticker = 14;
  bool _selected = false;
  String _character = "emu";
  Uint8List? _byteData;
  int _font = 0;
  Offset _pos = Offset(20, 10);
  double _fontSize = 42;
  int _edgeSize = 4;
  // int _time = 0;

  @override
  void initState() {
    super.initState();
    _createSticker();
  }

  Future<void> _createSticker() async {
    String content = _contextController.text;
    String character = _character != "随机" ? _character : "";
    if (PjskGenerator.groups.contains(character)) {
      final String group = character;
      final List<String> members = PjskGenerator.groupMembers[group]!;
      character = members[DateTime.now().millisecond % members.length];
    }
    character = PjskGenerator.characterMap[character] ?? character;
    if (_selectedSticker != -1) {
      character = '$character$_selectedSticker';
    }
    // _file = await PjskGenerator.pjsk(content: content, character: character);
    _byteData = await PjskGenerator.pjsk(
      content: content,
      character: character,
      font: _font,
      pos: _pos,
      fontSize: _fontSize,
      edgeSize: _edgeSize,
    );

    // _time++;
    setState(() {});
  }

  Future<void> _selectCharacter1() async {
    _selected = false;
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: PjskGenerator.groups.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              final String group = "随机";
              final Color color = Theme.of(context).colorScheme.primary;
              final ThemeData theme = Theme.of(
                context,
              ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: color));
              return ListTile(
                // ✅ 核心属性绑定
                onTap: () {
                  setState(() {
                    _selectedGroup = group;
                    _character = group; // 直接赋值给最终显示的character
                  });
                  _createSticker();
                  Navigator.pop(context); // 选择后关闭弹窗
                },

                // ✅ 视觉优化
                title: Text(
                  group,
                  style: theme.textTheme.titleMedium!.copyWith(color: color),
                ),
                // activeColor: Theme.of(context).colorScheme.primary,
                // tileColor: Theme.of(context).colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ).copyWith(left: 32),

                // ✅ 主题继承
                // controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                visualDensity: VisualDensity.compact,
              );
            }
            index--;
            final String group = PjskGenerator.groups[index];
            final Color color = PjskGenerator.groupColor[group]!;
            final ThemeData theme = Theme.of(
              context,
            ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: color));
            // return Container();
            return Column(
              children: List.generate(
                PjskGenerator.groupMembers[group]!.length + 2,
                (index) {
                  if (index == 0) {
                    return Divider();
                  }
                  index--;
                  if (index == 0) {
                    final Color color = PjskGenerator.groupColor[group]!;
                    final ThemeData theme = Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSeed(seedColor: color),
                    );
                    return ListTile(
                      // ✅ 核心属性绑定
                      onTap: () {
                        setState(() {
                          _selectedGroup = group;
                          _character = _selectedGroup!; // 直接赋值给最终显示的character
                        });
                        _createSticker();
                        Navigator.pop(context); // 选择后关闭弹窗
                      },

                      // ✅ 视觉优化
                      title: Text(
                        group,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: color,
                        ),
                      ),
                      // activeColor: Theme.of(context).colorScheme.primary,
                      // tileColor: Theme.of(context).colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ).copyWith(left: 32),

                      // ✅ 主题继承
                      // controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    );
                  }
                  index--;
                  final String character =
                      PjskGenerator.groupMembers[group]![index];
                  final String name = PjskGenerator.characterMap[character]!;
                  final Color color = PjskGenerator.characterColor[name]!;
                  return ListTile(
                    // ✅ 核心属性绑定
                    onTap: () async {
                      setState(() {
                        _selectedCharacter = character;
                        // _character = character; // 直接赋值给最终显示的character
                      });
                      await _selectCharacter3();
                      if (_selected && mounted) {
                        setState(() {});
                        Navigator.pop(context); // 选择后关闭弹窗
                      }
                    },

                    // ✅ 视觉优化
                    title: Text(
                      character,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: color,
                      ),
                    ),
                    // activeColor: Theme.of(context).colorScheme.primary,
                    // tileColor: Theme.of(context).colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ).copyWith(left: 64),

                    // ✅ 主题继承
                    // controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    visualDensity: VisualDensity.compact,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  // Future<void> _selectCharacter1() async {
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return ListView.builder(
  //         itemCount: PjskGenerator.groups.length + 1,
  //         itemBuilder: (context, index) {
  //           if (index == 0) {
  //             final String group = "随机";
  //             final Color color = Theme.of(context).colorScheme.primary;
  //             final ThemeData theme = Theme.of(
  //               context,
  //             ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: color));
  //             return RadioListTile<String>(
  //               // ✅ 核心属性绑定
  //               value: group,
  //               groupValue: _selectedGroup,
  //               onChanged: (val) {
  //                 setState(() {
  //                   _selectedGroup = val!;
  //                   _character = val; // 直接赋值给最终显示的character
  //                 });
  //                 _createSticker();
  //                 Navigator.pop(context); // 选择后关闭弹窗
  //               },

  //               // ✅ 视觉优化
  //               title: Text(
  //                 group,
  //                 style: theme.textTheme.titleMedium!.copyWith(color: color),
  //               ),
  //               activeColor: Theme.of(context).colorScheme.primary,
  //               // tileColor: Theme.of(context).colorScheme.surface,
  //               contentPadding: const EdgeInsets.symmetric(horizontal: 16),

  //               // ✅ 主题继承
  //               controlAffinity: ListTileControlAffinity.leading,
  //               dense: true,
  //               visualDensity: VisualDensity.compact,
  //             );
  //           }
  //           index--;
  //           final String group = PjskGenerator.groups[index];
  //           final Color color = PjskGenerator.groupColor[group]!;
  //           final ThemeData theme = Theme.of(
  //             context,
  //           ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: color));
  //           return ListTile(
  //             // ✅ 核心属性绑定
  //             onTap: () async {
  //               setState(() {
  //                 _selectedGroup = group;
  //               });
  //               await _selectCharacter2();
  //               if (_selected && mounted) {
  //                 setState(() {});
  //                 Navigator.pop(context); // 选择后关闭弹窗
  //               }
  //             },

  //             // ✅ 视觉优化
  //             title: Text(
  //               group,
  //               style: theme.textTheme.titleMedium!.copyWith(color: color),
  //             ),
  //             // activeColor: Theme.of(context).colorScheme.primary,
  //             // tileColor: Theme.of(context).colorScheme.surface,
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 16),

  //             // ✅ 主题继承
  //             // controlAffinity: ListTileControlAffinity.leading,
  //             dense: true,
  //             visualDensity: VisualDensity.compact,
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // Future<void> _selectCharacter2() async {
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return ListView.builder(
  //         itemCount: PjskGenerator.groupMembers[_selectedGroup!]!.length + 1,
  //         itemBuilder: (context, index) {
  //           if (index == 0) {
  //             final String character = "$_selectedGroup随机";
  //             final Color color = PjskGenerator.groupColor[_selectedGroup]!;
  //             final ThemeData theme = Theme.of(
  //               context,
  //             ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: color));
  //             return RadioListTile<String>(
  //               // ✅ 核心属性绑定
  //               value: character,
  //               groupValue: _selectedCharacter,
  //               onChanged: (val) {
  //                 setState(() {
  //                   _selectedCharacter = val!;
  //                   _character = val; // 直接赋值给最终显示的character
  //                 });
  //                 _selected = true;
  //                 _createSticker();
  //                 Navigator.pop(context); // 选择后关闭弹窗
  //               },

  //               // ✅ 视觉优化
  //               title: Text(
  //                 character,
  //                 style: theme.textTheme.titleMedium!.copyWith(color: color),
  //               ),
  //               activeColor: Theme.of(context).colorScheme.primary,
  //               // tileColor: Theme.of(context).colorScheme.surface,
  //               contentPadding: const EdgeInsets.symmetric(horizontal: 16),

  //               // ✅ 主题继承
  //               controlAffinity: ListTileControlAffinity.leading,
  //               dense: true,
  //               visualDensity: VisualDensity.compact,
  //             );
  //           }
  //           index--;
  //           final String group = _selectedGroup!;
  //           final String character = PjskGenerator.groupMembers[group]![index];
  //           final String name = PjskGenerator.characterMap[character]!;
  //           final Color color = PjskGenerator.characterColor[name]!;
  //           final ThemeData theme = Theme.of(
  //             context,
  //           ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: color));
  //           return ListTile(
  //             onTap: () async {
  //               setState(() {
  //                 _selectedCharacter = character;
  //               });
  //               // _selected = true;
  //               // _createSticker();
  //               // Navigator.pop(context); // 选择后关闭弹窗
  //               await _selectCharacter3();
  //               if (_selected && mounted) {
  //                 setState(() {});
  //                 Navigator.pop(context); // 选择后关闭弹窗
  //               }
  //             },

  //             // ✅ 视觉优化
  //             title: Text(
  //               character,
  //               style: theme.textTheme.titleMedium!.copyWith(color: color),
  //             ),
  //             // tileColor: Theme.of(context).colorScheme.surface,
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 16),

  //             // ✅ 主题继承
  //             dense: true,
  //             visualDensity: VisualDensity.compact,
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  Future<void> _selectCharacter3() async {
    _selectedSticker = -1;
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        final String name = PjskGenerator.characterMap[_selectedCharacter]!;
        final Color color = PjskGenerator.characterColor[name]!;
        final ThemeData theme = Theme.of(
          context,
        ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: color));
        return ListView(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  _character = _selectedCharacter!;
                  _selectedSticker = -1;
                });
                _createSticker();
                _selected = true;
                Navigator.pop(context); // 选择后关闭弹窗
              },
              title: Text(
                _selectedCharacter!,
                style: theme.textTheme.titleMedium!.copyWith(color: color),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(left: 32),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
            SingleChildScrollView(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, // 关键修复
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 每行 3 列
                  mainAxisSpacing: 8, // 垂直间距
                  crossAxisSpacing: 8, // 水平间距
                  childAspectRatio: 1.0, // 宽高比 1:1（适合正方形贴纸）
                ),
                itemCount: PjskGenerator.characterStickers[name]!.length,
                itemBuilder: (context, index) {
                  final String stickerPath =
                      'assets/characters/$name/${PjskGenerator.characterStickers[name]![index]}'; // 贴纸资源路径
                  final int stickerIndex =
                      int.tryParse(
                        PjskGenerator.characterStickers[name]![index]
                            .split('_')[1]
                            .split('.')[0],
                      )!; // 贴纸索引
                  // 判断文件是否存在
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _character = _selectedCharacter!;
                        _selectedSticker = stickerIndex; // 记录选中的贴纸索引
                      });
                      _createSticker();
                      _selected = true;
                      Navigator.pop(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        stickerPath, // 加载贴纸图片
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Sekai Sticker'),
        actions: [
          IconButton(
            icon: Icon(Ionicons.information_circle),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AboutPage(),
                ),
              );
              await _createSticker();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _contextController,
              decoration: const InputDecoration(labelText: '内容'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onChanged: (context) {
                _createSticker();
              },
            ),
          ),
          ListTile(
            title: InkWell(
              onTap: () {
                _selectCharacter1();
              },
              child: Text('角色: $_character'),
            ),
          ),
          ListTile(
            title: DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: '字体'),
              value: _font,
              icon: Icon(
                Ionicons.chevron_down, // 使用Ionicons图标（需导入ionicons包）
              ),
              items: [
                for (int i = 0; i < PjskGenerator.fonts.length; i++)
                  DropdownMenuItem<int>(
                    value: i,
                    child: Text(PjskGenerator.fonts[i]),
                  ),
              ],
              onChanged: (value) {
                setState(() {
                  _font = value!;
                });
                _createSticker();
              },
            ),
          ),
          ListTile(
            leading: InkWell(
              child: Text('X轴位置'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final posController = TextEditingController();
                    posController.text = _pos.dx.round().toString();
                    return AlertDialog(
                      title: Text('X轴位置'),
                      content: TextField(
                        controller: posController,
                        decoration: const InputDecoration(labelText: 'X轴位置'),
                      ),
                      actions: [
                        TextButton(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('确定'),
                          onPressed: () {
                            setState(() {
                              _pos = Offset(
                                double.parse(posController.text),
                                _pos.dy,
                              );
                            });
                            _createSticker();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            title: Slider(
              value: _pos.dx.clamp(-100, 300),
              min: -100,
              max: 300,
              divisions: 400,
              label: 'X轴位置: ${_pos.dx.round()}',
              onChanged: (value) {
                setState(() {
                  _pos = Offset(value, _pos.dy);
                });
                _createSticker();
              },
            ),
          ),
          ListTile(
            leading: InkWell(
              child: Text('Y轴位置'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final posController = TextEditingController();
                    posController.text = _pos.dy.round().toString();
                    return AlertDialog(
                      title: Text('Y轴位置'),
                      content: TextField(
                        controller: posController,
                        decoration: const InputDecoration(labelText: 'Y轴位置'),
                      ),
                      actions: [
                        TextButton(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('确定'),
                          onPressed: () {
                            setState(() {
                              _pos = Offset(
                                _pos.dx,
                                double.parse(posController.text),
                              );
                            });
                            _createSticker();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            title: Slider(
              value: _pos.dy.clamp(-100, 300),
              min: -100,
              max: 300,
              divisions: 400,
              label: 'Y轴位置: ${_pos.dy.round()}',
              onChanged: (value) {
                setState(() {
                  _pos = Offset(_pos.dx, value);
                });
                _createSticker();
              },
            ),
          ),
          ListTile(
            leading: InkWell(
              child: Text('字体大小'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final fontSizeController = TextEditingController();
                    fontSizeController.text = _fontSize.round().toString();
                    return AlertDialog(
                      title: Text('字体大小'),
                      content: TextField(
                        controller: fontSizeController,
                        decoration: const InputDecoration(labelText: '字体大小'),
                      ),
                      actions: [
                        TextButton(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('确定'),
                          onPressed: () {
                            setState(() {
                              _fontSize = double.parse(fontSizeController.text);
                            });
                            _createSticker();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            title: Slider(
              value: _fontSize.clamp(00, 100),
              min: 0,
              max: 100,
              divisions: 100,
              label: '字体大小: ${_fontSize.round()}',
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
                _createSticker();
              },
            ),
          ),
          if (_byteData != null)
            ListTile(
              title: Image.memory(
                key: ValueKey(_byteData.hashCode),
                _byteData!,
                width: 300,
                height: 300,
              ),
              onTap: () async {
                try {
                  // await Pasteboard.writeFiles([_byteData!]);
                  // await Pasteboard.writeImage(_byteData!);
                  // await Future.delayed(Duration(seconds: 1));
                  final File file = File(
                    '/storage/emulated/0/Pictures/pjsk_sticker/pjsk_${DateTime.now().millisecondsSinceEpoch}.png',
                  );
                  await file.create(recursive: true);
                  // await _file!.copy(file.path);
                  await file.writeAsBytes(_byteData!);
                  // await Pasteboard.writeFiles([file.path]);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('已复制图片到粘贴板并保存相册')));
                  if (Platform.isAndroid) {
                    await SharePlus.instance.share(
                      // ShareParams(files: [XFile(file.path)]),
                      ShareParams(
                        files: [XFile.fromData(_byteData!, path: file.path)],
                      ),
                    );
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
            ),
        ],
      ),
    );
  }
}
