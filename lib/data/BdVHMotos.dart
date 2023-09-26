import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbVHMotos {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dbmotos.db');
    //join is from path package

    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table

      await db.execute(''' 
                  CREATE TABLE IF NOT EXISTS motos (  
                        id primary key, 
                        marca varchar(255) not null, 
                        modelo varchar(255) not null, 
                        cilindrada int not null, 
                        valor numeric(10,8) not null, 
                        roll_no int not null
                    ); 

                    //create more table here 

                ''');

      print("Tabela Criada com Sucesso!");
    });
  }

  //método de consulta de dados

  Future<Map<dynamic, dynamic>?> getMotos(int rollno) async {
    List<Map> maps =
        await db.query('motos', where: 'roll_no = ?', whereArgs: [rollno]);
    //getting student data with roll no.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}
