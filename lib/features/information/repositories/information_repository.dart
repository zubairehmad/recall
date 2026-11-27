import '../models/information.dart';
import '../services/database_service.dart';

class InformationRepository {
  InformationRepository._();

  static Map<String, Object?> _toDbMap(Information info) {
    final cols = DatabaseService.colNames;
    return {
      cols.id: info.id,
      cols.title: info.title,
      cols.content: info.content,
      cols.type: info.type.index,
      cols.claimStatus: info.claimStatus?.name,
      cols.createdAt: info.createdAt.millisecondsSinceEpoch,
      cols.updatedAt: info.updatedAt.millisecondsSinceEpoch,
    };
  }

  static Information _fromDbMap(Map<String, Object?> mp) {
    final cols = DatabaseService.colNames;

    final statusName = mp[cols.claimStatus] as String?;
    final claimStatus = statusName == null
        ? null
        : ClaimStatus.values.byName(statusName);

    return Information(
      id: mp[cols.id] as String,
      title: mp[cols.title] as String,
      content: mp[cols.content] as String,
      type: InformationType.values[mp[cols.type] as int],
      claimStatus: claimStatus,
      createdAt: DateTime.fromMillisecondsSinceEpoch(mp[cols.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(mp[cols.updatedAt] as int),
    );
  }

  static Future<void> saveInformation(Information info) async {
    final db = DatabaseService.db;
    await db.insert(DatabaseService.tableName, _toDbMap(info));
  }

  static Future<void> updateInformation(Information updatedInfo) async {
    final db = DatabaseService.db;
    final colId = DatabaseService.colNames.id;

    await db.update(
      DatabaseService.tableName,
      _toDbMap(updatedInfo),
      where: '$colId = ?',
      whereArgs: [updatedInfo.id],
    );
  }

  static Future<List<Information>> getAll() async {
    final db = DatabaseService.db;
    final rows = await db.query(DatabaseService.tableName);
    return rows.map((row) => _fromDbMap(row)).toList();
  }

  static Future<void> deleteInformation(String id) async {
    final db = DatabaseService.db;
    final colId = DatabaseService.colNames.id;

    await db.delete(
      DatabaseService.tableName,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }
}
