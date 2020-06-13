import "package:sqflite/sqflite.dart" as sql;
import "package:path/path.dart"as path;

class DBhelper{
  static Future<sql.Database> database() async{
 final db_path= await sql.getDatabasesPath();
    return sql.openDatabase(path.join(db_path,"contacts.db"),onCreate: (db,version)
    {
      return db.execute('CREATE TABLE contacts(name TEXT,number TEXT PRIMARY KEY)'); 
    },version: 1
    ); 
  }

  static Future<void> insert(String table,Map<String,Object> data)async {
    final db=await DBhelper.database();
   db.insert(table, data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getdata(String table) async{
    final db=await DBhelper.database();
    return db.query(table);
  } 
  static Future<void> delete(String table,String number)async{
     final db=await DBhelper.database();
      await db.rawDelete("DELETE FROM $table WHERE number=?",[number]);
      print("item_deleted");
  }
  static Future<void> table_delete(String table)async 
  {
     final db_path= await sql.getDatabasesPath();
     String dbname=table+".db";
     await sql.deleteDatabase(path.join(db_path,dbname));

  }

  }
