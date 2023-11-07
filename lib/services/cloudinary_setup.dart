import 'dart:io';

import 'package:cloudinary/cloudinary.dart';

class CloudinaryService {
  final cloudinary = Cloudinary.signedConfig(
    apiKey: '992636531583146',
    apiSecret: 'iKb3qilFlfAjJvnSV0-RdB3uuBA',
    cloudName: 'dbt5g25tx',
  );

  Future<String> uploadFIle(File file) async {
    try {
      final response = await cloudinary.upload(
          file: file.path,
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.auto,
          folder: "gig-meister",
          fileName: DateTime.now().millisecondsSinceEpoch.toString(),
          progressCallback: (count, total) {
            print('Uploading image from file with progress: $count/$total');
          });

      if (response.isSuccessful) {
        print('Get your image from with ${response.secureUrl}');
        return response.secureUrl!;
      }
      return "";
    } catch (e) {
      print("Cloudinary upload failed: $e");
      return "";
    }
  }
}
