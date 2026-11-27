import 'package:sqflite/sqflite.dart';

typedef ColumnNames = ({
  String id,
  String title,
  String content,
  String type,
  String claimStatus,
  String createdAt,
  String updatedAt,
});

class DatabaseService {
  DatabaseService._();

  static late final Database _db;
  static const _dbName = 'recall_data.db';
  static const _dbVersion = 1;

  static const tableName = 'information';
  static const ColumnNames colNames = (
    id: 'id',
    title: 'title',
    content: 'content',
    type: 'type',
    claimStatus: 'claim_status',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
  );

  static Database get db => _db;

  static Future<void> init() async {
    _db = await openDatabase(
      _dbName,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE information (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            type INTEGER NOT NULL,
            claim_status TEXT,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }
}
