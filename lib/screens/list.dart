import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/BdVHMotos.dart';

import 'package:appcrudsqlite/screens/edit.dart';

class ListBooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListBooks();
  }
}

class _ListBooks extends State<ListBooks> {
  List<Map> slist = [];

  DbVHMotos mydb = DbVHMotos();

  @override
  void initState() {
    mydb.open();

    getdata();

    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      //use delay min 500 ms, because database takes time to initilize.

      slist = await mydb.db.rawQuery('SELECT * FROM motos');

      setState(() {}); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Motos Cadastrados"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.length == 0
              ? Text("Carregando Motos")
              : //show message if there is no any student

              Column(
                  //or populate list to Column children if there is student data.

                  children: slist.map((stuone) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text(stuone["Modelo"]),
                        subtitle: Text("Codigo:" +
                            stuone["roll_no"].toString() +
                            ", Preço: " +
                            stuone["price"]),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                 // Navigator.push(context, MaterialPageRoute(
                                   //   builder: (BuildContext context) {
                                   // return EditBook(rollno: stuone["roll_no"]);
                                 // })); //navigate to edit page, pass student roll no to edit
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM motos WHERE roll_no = ?",
                                      [stuone["roll_no"]]);

                                  //delete student data with roll no.

                                  print("Data Deleted");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Motos Apagado!")));

                                  getdata();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
