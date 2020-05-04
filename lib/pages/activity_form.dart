import 'package:activities/dao/activity_dao.dart';
import 'package:activities/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActivityForm extends StatefulWidget {
  final Activity activity;
  const ActivityForm({this.activity});

  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();

  Activity get activity => widget.activity;

  //Controlers
  final _tDescription = TextEditingController();
  final _tConcluido = TextEditingController();
  final _tTarefaDiaria = TextEditingController();

  //States
  bool _done = false;
  bool _daily = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.of(context).size.height / 4.5,
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Digite a atividade"),
              controller: this._tDescription,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Atividade diária?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Checkbox(
                  value: this._daily,
                  onChanged: (bool value) => {
                    setState(
                      () {
                        this._daily = value;
                      },
                    )
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                          width: 50, height: 50, child: Icon(Icons.save)),
                      onTap: () {},
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                          width: 50, height: 50, child: Icon(Icons.cancel)),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Form _form(BuildContext context) {
  _flutterToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  /*_empty() {
    this._daily = false;
    this._done = false;
    this._formKey.currentState.reset();
  }*/
}
