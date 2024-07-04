import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikedHostelsProvider with ChangeNotifier {
  final List<DocumentSnapshot> _likedHostels = [];

  List<DocumentSnapshot> get likedHostels => _likedHostels;

  void addHostel(DocumentSnapshot hostel) {
    _likedHostels.add(hostel);
    notifyListeners();
  }

  void removeHostel(String hostelId) {
    _likedHostels.removeWhere((hostel) => hostel.id == hostelId);
    notifyListeners();
  }

  bool isLiked(String hostelId) {
    return _likedHostels.any((hostel) => hostel.id == hostelId);
  }
}
