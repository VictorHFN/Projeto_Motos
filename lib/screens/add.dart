import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/BdVHMotos.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  TextEditingController marca = TextEditingController();

  TextEditingController modelo = TextEditingController();

  TextEditingController cilindrada = TextEditingController();

  TextEditingController valor = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  //test editing controllers for form

  DbVHMotos mydb = DbVHMotos(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inserir Moto"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: marca,
                decoration: const InputDecoration(
                  hintText: "Marca",
                ),
              ),
              TextField(
                controller: modelo,
                decoration: const InputDecoration(
                  hintText: "Modelo.",
                ),
              ),
              TextField(
                controller: cilindrada,
                decoration: const InputDecoration(
                  hintText: "Cilindrada",
                ),
              ),
              TextField(
                controller: valor,
                decoration: const InputDecoration(
                  hintText: "Valor",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: const InputDecoration(
                  hintText: "rollno",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO motos(marca, modelo, cilindrada, valor, roll_no) VALUES (?, ?, ?, ?, ?);",
                        [
                          marca.text,
                          modelo.text,
                          cilindrada.text,
                          valor.text,
                          roll_no.text
                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Moto Adicionado")));

                    marca.text = "";

                    modelo.text = "";

                    cilindrada.text = "";

                    valor.text = " ";

                    roll_no.text = " ";
                  },
                  child: Text("Salvar Moto")),
            ],
          ),
        ));
  }
}
