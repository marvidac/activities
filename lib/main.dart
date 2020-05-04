import 'dart:math';

import 'package:activities/dao/activity_dao.dart';
import 'package:activities/model/activity.dart';
import 'package:activities/pages/activity_form.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Atividades'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ActivityDao activityDao = new ActivityDao();
  List<Activity> listaActivities;
  int qtdeRegistros = 0;

  void initState() {
    super.initState();
    _buscaListaActivities();
  }

  void _buscaListaActivities() {
    activityDao.findAllByDone(false).then((acts) {
      setState(() {
        listaActivities = acts;
        qtdeRegistros = acts.length;
      });
    });
  }

  Key _gerarKey() {
    //Atualizando a lista de movientações
    _buscaListaActivities();

    //GErando nova key para o flutter atualiza o widget (gambiarra)
    return new Key(Random(10000000).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: 
                      ActivityForm(),
                  ));
        },
        tooltip: 'Adicionar Atividade',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                key: _gerarKey(),
                itemCount: qtdeRegistros,
                itemBuilder: (context, index) {
                  Activity act = listaActivities[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(act.description),
                      trailing: Checkbox(
                        value: act.done,
                        onChanged: (bool value) {
                          setState(() {
                            act.done = value;
                            _updateActivity(act);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateActivity(Activity act) {
    ActivityDao activityDao = new ActivityDao();

    activityDao.save(act);
    _buscaListaActivities();
  }
}
