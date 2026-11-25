import 'package:flutter/material.dart';

import '../models/information.dart';

class InformationProvider with ChangeNotifier {
  /// Mock data
  final _information = [
    Information(
      id: '1',
      title: 'Binary search on answer',
      content: 'You should binary search on answer!',
      type: InformationType.tip,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Information(
      id: '2',
      title: "Newton's third law",
      content: 'Every action has a reaction.',
      type: InformationType.fact,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Information(
      id: '3',
      title: 'Thought about discipline',
      content: 'I should be disciplined!',
      type: InformationType.note,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Information(
      id: '4',
      title: "Pakistan's independence date",
      content: '14th August, 1947',
      type: InformationType.fact,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Information(
      id: '5',
      title: "World War 2 was consipiracy!",
      content: 'I dont know!!',
      type: InformationType.claim,
      claimStatus: ClaimStatus.unreviewed,
      createdAt: DateTime.now().subtract(const Duration(days: 23)),
      updatedAt: DateTime.now().subtract(const Duration(days: 23)),
    ),
  ];

  List<Information> get informationList => List.unmodifiable(_information);
  List<Information> get recentlyAddedList {
    final now = DateTime.now();

    final copyList = _information.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return copyList
        .where(
          (info) => now.difference(info.createdAt) <= const Duration(hours: 24),
        )
        .take(5)
        .toList();
  }

  Information? getInfo(String id) {
    final idx = _information.indexWhere((info) => info.id == id);
    return idx == -1 ? null : _information[idx];
  }

  bool addInformation(Information info) {
    if (_information.any((item) => item.id == info.id)) return false;

    _information.add(info);
    notifyListeners();

    return true;
  }

  bool updateInformation(Information updatedInfo) {
    final idx = _information.indexWhere(
      (info) => info.id == updatedInfo.id,
    );
    if (idx == -1) return false;

    _information[idx] = updatedInfo;
    notifyListeners();

    return true;
  }

  bool deleteInformation(String id) {
    final prevLen = _information.length;
    _information.removeWhere((info) => info.id == id);

    if (_information.length != prevLen) {
      notifyListeners();
      return true;
    }

    return false;
  }
}
