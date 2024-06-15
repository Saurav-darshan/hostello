import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hostello/colors/colors.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Admin_AddHostelDetail extends StatefulWidget {
  const Admin_AddHostelDetail({super.key});
  @override
  State<Admin_AddHostelDetail> createState() => _AdminAddHostelDetailState();
}

class _AdminAddHostelDetailState extends State<Admin_AddHostelDetail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _overviewController =
      TextEditingController(); // New controller for overview
  String _selectedType = 'Hostel';
  List<XFile>? _imageFiles;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Facility options
  final Map<String, bool> _facilities = {
    'Watchman': false,
    'WiFi': false,
    'Parking': false,
    'Laundry': false,
    'Mess': false,
    'CCTV': false,
    'Water Cooler': false,
  };

  Future<List<String>> _uploadImages() async {
    List<String> downloadUrls = [];
    for (var file in _imageFiles!) {
      try {
        print('Compressing image: ${file.path}');
        File compressedFile = await compressImage(File(file.path));
        String fileName = file.path.split('/').last;
        print('Uploading image: $fileName');
        var uploadTask = await _storage
            .ref('hostel_images/$fileName')
            .putFile(compressedFile);
        var downloadUrl = await uploadTask.ref.getDownloadURL();
        print('Uploaded image URL: $downloadUrl');
        downloadUrls.add(downloadUrl);
      } catch (e) {
        print('Error uploading image: $e');
        throw Exception('Error uploading image: $e');
      }
    }
    return downloadUrls;
  }

  Future<File> compressImage(File file) async {
    print('Reading image bytes...');
    final bytes = await file.readAsBytes();
    print('Decoding image...');
    img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception('Error decoding image');
    print('Resizing image...');
    img.Image resizedImage = img.copyResize(image, width: 800);
    print('Encoding image...');
    final compressedBytes = img.encodeJpg(resizedImage, quality: 85);
    print('Getting temporary directory...');
    final tempDir = await getTemporaryDirectory();
    print('Writing compressed image to file...');
    final compressedFile = File('${tempDir.path}/${file.path.split('/').last}');
    await compressedFile.writeAsBytes(compressedBytes);
    return compressedFile;
  }

  Future<void> _saveHostelDetails(List<String> imageUrls) async {
    try {
      await _firestore.collection('hostels').doc(_nameController.text).set({
        'name': _nameController.text.trim(),
        'address': _addressController.text.trim(),
        'rent': double.parse(_rentController.text), // Assuming rent is a number
        'type': _selectedType,
        'overview': _overviewController.text.trim(), // Save the overview
        'facilities':
            _facilities.keys.where((key) => _facilities[key]!).toList(),
        'imageUrls': imageUrls,
      });
    } catch (e, stackTrace) {
      // Log the error for debugging purposes
      print('Error saving hostel details: $e');
      print('Stack trace: $stackTrace');

      // Optionally, rethrow the error or handle it accordingly
      throw Exception('Error saving hostel details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Ccolor.p1,
        title: Text('Add Hostel Details'),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Card(
                color: Ccolor.p1,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 10, left: 16, right: 16),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height / 1.35,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/bed.png",
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Hostel Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter hostel name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _rentController,
                              decoration: InputDecoration(
                                labelText: 'Rent',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter rent';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _overviewController,
                              decoration: InputDecoration(
                                labelText: 'Overview',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an overview';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedType,
                              decoration: InputDecoration(
                                labelText: 'Type',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items: ['Hostel', 'PG']
                                  .map((type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value!;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Add Images',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  final List<XFile>? selectedImages =
                                      await _picker.pickMultiImage();
                                  setState(() {
                                    _imageFiles = selectedImages;
                                  });
                                } catch (e) {
                                  print("Error picking images: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error picking images: $e'),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                surfaceTintColor: Ccolor.p4,
                                shape: StadiumBorder(),
                                elevation: 20,
                                backgroundColor: Ccolor.p3,
                              ),
                              child: Text(
                                'Select Image',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            _imageFiles != null && _imageFiles!.isNotEmpty
                                ? Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: _imageFiles!.map((file) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(file.path),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Text('No images selected'),
                            SizedBox(height: 20),
                            Text(
                              'Facilities',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListView(
                              physics: ScrollPhysics(
                                  parent: NeverScrollableScrollPhysics()),
                              shrinkWrap: true,
                              children: _facilities.keys.map((String key) {
                                return CheckboxListTile(
                                  title: Text(key),
                                  value: _facilities[key],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _facilities[key] = value!;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (_imageFiles == null ||
                                        _imageFiles!.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Please select at least one image'),
                                      ));
                                    } else {
                                      try {
                                        List<String> imageUrls =
                                            await _uploadImages();
                                        await _saveHostelDetails(imageUrls);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Hostel details saved'),
                                        ));
                                      } catch (e) {
                                        print("Error saving details: $e");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Error saving details: $e'),
                                        ));
                                      }
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  surfaceTintColor: Ccolor.p3,
                                  shape: StadiumBorder(),
                                  elevation: 10,
                                  backgroundColor: Ccolor.p3,
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15,
                                  ),
                                  child: Text(
                                    'Upload Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
