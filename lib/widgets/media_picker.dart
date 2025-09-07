import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../views/video_preview_screen.dart';

class MediaPicker {
  // --- Public Method ---
  static Future<Map<String, dynamic>?> show(BuildContext context) async {
    if (Platform.isIOS) {
      return _showIOSActionSheet(context);
    } else {
      return _showAndroidBottomSheet(context);
    }
  }

  // --- Private Platform-Specific Methods ---
  static Future<Map<String, dynamic>?> _showIOSActionSheet(
    BuildContext context,
  ) async {
    return showCupertinoModalPopup<Map<String, dynamic>>(
      context: context,
      builder: (sheetCtx) => CupertinoActionSheet(
        title: const Text('미디어 추가'),
        message: const Text('사진이나 동영상을 선택해주세요'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              // await 전에 NavigatorState 캡처
              final nav = Navigator.of(sheetCtx);
              final result = await _showPickerDialog(
                sheetCtx,
                source: ImageSource.camera,
                title: '카메라',
                content: '사진을 촬영하시겠어요, 동영상을 녹화하시겠어요?',
              );
              if (!nav.mounted) return;
              nav.pop(result);
            },
            child: const Text('카메라로 촬영'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final nav = Navigator.of(sheetCtx);
              final result = await _showPickerDialog(
                sheetCtx,
                source: ImageSource.gallery,
                title: '갤러리에서 선택',
                content: '사진 또는 동영상을 선택하세요',
              );
              if (!nav.mounted) return;
              nav.pop(result);
            },
            child: const Text('갤러리에서 선택'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(sheetCtx).pop(),
          child: const Text('취소'),
        ),
      ),
    );
  }

  static Future<Map<String, dynamic>?> _showAndroidBottomSheet(
    BuildContext context,
  ) async {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (sheetCtx) {
        return Container(); // TODO: 구현
      },
    );
  }

  // --- Private Helper Methods ---
  static Future<Map<String, dynamic>?> _showPickerDialog(
    BuildContext context, {
    required ImageSource source,
    required String title,
    required String content,
  }) async {
    return showCupertinoDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogCtx) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('취소'),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              final nav = Navigator.of(dialogCtx, rootNavigator: true);
              final result = (source == ImageSource.gallery)
                  ? await _pickMultiImage(nav)
                  : await _pickSingleMedia(nav, source: source, isVideo: false);
              if (!nav.mounted) return;
              nav.pop(result);
            },
            child: const Text('사진'),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              final nav = Navigator.of(dialogCtx);
              final result = await _pickSingleMedia(
                nav,
                source: source,
                isVideo: true,
              );
              if (!nav.mounted) return;
              nav.pop(result);
            },
            child: const Text('동영상'),
          ),
        ],
      ),
    );
  }

  static Future<Map<String, dynamic>?> _pickSingleMedia(
    NavigatorState nav, {
    required ImageSource source,
    required bool isVideo,
  }) async {
    try {
      final picker = ImagePicker();
      final XFile? media = isVideo
          ? await picker.pickVideo(
              source: source,
              maxDuration: const Duration(seconds: 60),
            )
          : await picker.pickImage(
              source: source,
              imageQuality: 20,
              maxWidth: 1080,
              maxHeight: 1080,
            );

      if (media == null || !nav.mounted) return null;

      return nav.push<Map<String, dynamic>>(
        MaterialPageRoute(
          builder: (_) => VideoPreviewScreen(
            media: media,
            isVideo: isVideo,
            isPicked: source == ImageSource.gallery,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Single Media Pick Error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> _pickMultiImage(
    NavigatorState nav,
  ) async {
    try {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage(
        imageQuality: 20,
        maxWidth: 1080,
        maxHeight: 1080,
      );
      if (images.isEmpty) return null;

      final limited = images.take(3).toList();
      if (images.length > 3 && nav.mounted) {
        ScaffoldMessenger.of(nav.context).showSnackBar(
          const SnackBar(
            content: Text('최대 3장까지만 선택할 수 있습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      return {
        'files': limited.map((x) => File(x.path)).toList(),
        'isVideo': false,
        'isMultiple': true,
      };
    } catch (e) {
      debugPrint('Multi Image Pick Error: $e');
      return null;
    }
  }
}
