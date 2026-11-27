import 'package:flutter/material.dart';

import '../repositories/information_repository.dart';
import '../../statistics/providers/information_stats_provider.dart';
import '../models/information.dart';

class InformationProvider with ChangeNotifier {
  late final List<Information> _information;
  final InformationStatsProvider _statsProvider;
  bool _initialized = false;

  InformationProvider(this._statsProvider) {
    _initialize();
  }

  List<Information> get informationList =>
      !_initialized ? [] : List.unmodifiable(_information);
  List<Information> get recentlyAddedList {
    if (!_initialized) return [];

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

  bool get isInitialized => _initialized;

  Future<void> _initialize() async {
    _information = await InformationRepository.getAll();
    _statsProvider.initialize(_information);
    _initialized = true;
    notifyListeners();
  }

  Information? getInfo(String id) {
    final idx = _information.indexWhere((info) => info.id == id);
    return idx == -1 ? null : _information[idx];
  }

  Future<bool> addInformation(Information info) async {
    if (_information.any((item) => item.id == info.id)) return false;

    _information.add(info);
    _statsProvider.onInformationAdded(info);
    await InformationRepository.saveInformation(info);
    notifyListeners();

    return true;
  }

  Future<bool> updateInformation(Information updatedInfo) async {
    final idx = _information.indexWhere(
      (info) => info.id == updatedInfo.id,
    );
    if (idx == -1) return false;

    final oldInfo = _information[idx];
    _information[idx] = updatedInfo;
    _statsProvider.onInformationUpdated(oldInfo, updatedInfo);
    await InformationRepository.updateInformation(updatedInfo);
    notifyListeners();

    return true;
  }

  Future<bool> deleteInformation(String id) async {
    final idx = _information.indexWhere((info) => info.id == id);
    if (idx == -1) return false;

    final info = _information.removeAt(idx);
    _statsProvider.onInformationDeleted(info);
    await InformationRepository.deleteInformation(id);
    notifyListeners();

    return true;
  }
}
