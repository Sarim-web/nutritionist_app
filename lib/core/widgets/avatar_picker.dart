import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final String? initialPath; // local file path or asset string
  final ValueChanged<String?> onChanged;

  const AvatarPicker({
    super.key,
    this.initialPath,
    required this.onChanged,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  String? _currentPath;

  @override
  void initState() {
    super.initState();
    _currentPath = widget.initialPath;
  }

  Future<void> _pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null && mounted) {
      setState(() {
        _currentPath = file.path;
      });
      widget.onChanged(file.path);
    }
  }

  void _pickPredefined(String assetPath) {
    setState(() {
      _currentPath = assetPath;
    });
    widget.onChanged(assetPath);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = _currentPath != null;

    return Column(
      children: [
        GestureDetector(
          onTap: _pickFromGallery,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage: hasImage
                ? (_currentPath!.startsWith('assets/')
                    ? AssetImage(_currentPath!)
                    : FileImage(File(_currentPath!)))
                : null,
            child: !hasImage
                ? const Icon(Icons.person, size: 60, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
              onPressed: _pickFromGallery,
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.face),
              label: const Text('Choose Icon'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Select Avatar'),
                    content: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                        ),
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: List.generate(16, (i) {
                            final asset = 'assets/avatars/av$i.png';
                            return GestureDetector(
                              onTap: () {
                                _pickPredefined(asset);
                                Navigator.pop(ctx);
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(asset),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
