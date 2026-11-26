import 'package:flutter/material.dart';

import '../../information/models/information.dart';

class InformationCounts {
  int facts;
  int tips;
  int notes;
  int claims;

  int get total => facts + tips + notes + claims;

  InformationCounts({
    this.facts = 0,
    this.claims = 0,
    this.tips = 0,
    this.notes = 0,
  });

  InformationCounts copy() {
    return InformationCounts(
      facts: facts,
      claims: claims,
      tips: tips,
      notes: notes,
    );
  }
}

class ClaimCounts {
  int unreviewed;
  int verified;
  int disputed;
  int incorrect;

  int get reviewed => verified + disputed + incorrect;
  int get total => reviewed + unreviewed;

  ClaimCounts({
    this.unreviewed = 0,
    this.verified = 0,
    this.disputed = 0,
    this.incorrect = 0,
  });

  ClaimCounts copy() {
    return ClaimCounts(
      unreviewed: unreviewed,
      verified: verified,
      disputed: disputed,
      incorrect: incorrect,
    );
  }
}

class InformationStatsProvider with ChangeNotifier {
  final _counts = InformationCounts();
  final _claimCnts = ClaimCounts();

  int get totalSaved => _counts.total;
  int get notesCnt => _counts.notes;
  int get tipsCnt => _counts.tips;
  int get claimsCnt => _counts.claims;
  int get factsCnt => _counts.facts;

  InformationCounts get counts => _counts.copy();

  int get reviewedClaimsCnt => _claimCnts.reviewed;
  int get unreviewedClaimsCnt => _claimCnts.unreviewed;
  int get verifiedClaimsCnt => _claimCnts.verified;
  int get disputedClaimsCnt => _claimCnts.disputed;
  int get incorrectClaimsCnt => _claimCnts.incorrect;

  ClaimCounts get claimCnts => _claimCnts.copy();

  int _getCnt(InformationType type) {
    return switch (type) {
      InformationType.claim => _counts.claims,
      InformationType.fact => _counts.facts,
      InformationType.note => _counts.notes,
      InformationType.tip => _counts.tips,
    };
  }

  void _setCnt(InformationType type, int newCount) {
    switch (type) {
      case InformationType.claim:
        _counts.claims = newCount;
        break;
      case InformationType.fact:
        _counts.facts = newCount;
        break;
      case InformationType.note:
        _counts.notes = newCount;
        break;
      case InformationType.tip:
        _counts.tips = newCount;
        break;
    }
  }

  int _getClaimCnt(ClaimStatus status) {
    return switch (status) {
      ClaimStatus.verified => _claimCnts.verified,
      ClaimStatus.unreviewed => _claimCnts.unreviewed,
      ClaimStatus.disputed => _claimCnts.disputed,
      ClaimStatus.incorrect => _claimCnts.incorrect,
    };
  }

  void _setClaimCnt(ClaimStatus status, int newCnt) {
    switch (status) {
      case ClaimStatus.verified:
        _claimCnts.verified = newCnt;
        break;
      case ClaimStatus.unreviewed:
        _claimCnts.unreviewed = newCnt;
        break;
      case ClaimStatus.incorrect:
        _claimCnts.incorrect = newCnt;
        break;
      case ClaimStatus.disputed:
        _claimCnts.disputed = newCnt;
        break;
    }
  }

  void initialize(List<Information> information) {
    for (final info in information) {
      _setCnt(info.type, _getCnt(info.type) + 1);

      if (info.isClaim) {
        _setClaimCnt(
          info.claimStatus!,
          _getClaimCnt(info.claimStatus!) + 1,
        );
      }
    }
  }

  void onInformationAdded(Information info) {
    _setCnt(info.type, _getCnt(info.type) + 1);
    if (info.isClaim) {
      _setClaimCnt(info.claimStatus!, _getClaimCnt(info.claimStatus!) + 1);
    }
    notifyListeners();
  }

  void onInformationDeleted(Information info) {
    _setCnt(info.type, _getCnt(info.type) - 1);
    if (info.isClaim) {
      _setClaimCnt(info.claimStatus!, _getClaimCnt(info.claimStatus!) - 1);
    }
    notifyListeners();
  }

  void onInformationUpdated(Information oldInfo, Information newInfo) {
    if (oldInfo.type != newInfo.type) {
      _setCnt(oldInfo.type, _getCnt(oldInfo.type) - 1);
      _setCnt(newInfo.type, _getCnt(newInfo.type) + 1);
    }

    if (oldInfo.claimStatus != newInfo.claimStatus) {
      if (oldInfo.isClaim) {
        _setClaimCnt(
          oldInfo.claimStatus!,
          _getClaimCnt(oldInfo.claimStatus!) - 1,
        );
      }

      if (newInfo.isClaim) {
        _setClaimCnt(
          newInfo.claimStatus!,
          _getClaimCnt(newInfo.claimStatus!) + 1,
        );
      }
    }

    notifyListeners();
  }
}
