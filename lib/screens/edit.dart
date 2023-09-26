import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/BdVHMotos.dart';

class EditMotos extends StatefulWidget {
  int rollno;

  EditMotos({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditMotos();
  }
}

class _EditMotos extends State<EditMotos> {
  TextEditingController marca = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  TextEditingController modelo = TextEditingController();

  TextEditingController cilindrada = TextEditingController();

  TextEditingController valor = TextEditingController();

  DbVHMotos mydb = new DbVHMotos();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getMotos(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        marca.text = data["marca"];

        roll_no.text = data["roll_no"].toString();

        modelo.text = data["modelo"];

        cilindrada.text = data["cilindrada"].toString();

        valor.text = data["valor"].toString();

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Motos"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: marca,
                decoration: InputDecoration(
                  hintText: "Marca",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: InputDecoration(
                  hintText: "rollno",
                ),
              ),
              TextField(
                controller: modelo,
                decoration: InputDecoration(
                  hintText: "Modelo.",
                ),
              ),
              TextField(
                controller: cilindrada,
                decoration: InputDecoration(
                  hintText: "Cilindrada",
                ),
              ),
              TextField(
                controller: valor,
                decoration: InputDecoration(
                  hintText: "Valor",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE motos SET marca = ?, modelo = ?, cilindrada = ?, valor=? WHERE roll_no = ?",
                        [
                          marca.text,
                          modelo.text,
                          cilindrada.text,
                          valor.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Moto Alterado!")));
                  },
                  child: Text("Alterar Moto")),
            ],
          ),
        ));
  }
}
