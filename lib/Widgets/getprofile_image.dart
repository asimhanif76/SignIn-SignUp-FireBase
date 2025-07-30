import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider getProfileImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else if (imagePath.startsWith('/')) {
      return FileImage(File(imagePath));
    } else {
      return AssetImage(imagePath);
    }
  }