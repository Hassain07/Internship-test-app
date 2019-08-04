import 'package:flutter/material.dart';
import 'package:intern_app/database/task_model.dart';
class TodaysTaskListPage extends StatefulWidget {
final List<Task>tasks;
TodaysTaskListPage({this.tasks});

  @override
  _TodaysTaskListPageState createState() => _TodaysTaskListPageState();
}

class _TodaysTaskListPageState extends State<TodaysTaskListPage> {
List<Task>pendingTasks=List<Task>();
List<Task>completedTasks=List<Task>();
DateTime curDate=DateTime.parse("2016-11-12 00:00:00.000");

void initState(){
  super.initState();
  clasify();
}

void clasify(){
if(widget.tasks.length >0){
    widget.tasks.forEach((task){
      if(task.status=="COMPLETED")
          completedTasks.add(task);
      else
        pendingTasks.add(task);  
    });
  }
}


void changeStatus(Task task,int i){
  var t=task;
  t.status="COMPLETED";
completedTasks.add(t);
pendingTasks.removeAt(i);
setState(() {
 
});
}

  @override
  Widget build(BuildContext context) {
    print("build method is called");
    return ListView(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text("Up Todo Tasks",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)
        ],),
        pendingSection(context),
         Row(mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
          Text("Comleted Tasks",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)
        ],),
       completedSection(context),
      ],
    );

  }



Widget pendingSection(context)=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:pendingTasks.length >3?400:300,
            child: ListView.separated(
            itemCount: pendingTasks.length,
            itemBuilder: (contex,i){
             return ListTile(
               leading: Checkbox(value:false ,onChanged: (bool value) {
              changeStatus(pendingTasks[i], i);},),
               title: Text(pendingTasks[i].description),
               subtitle: Text("Scheduled After ${pendingTasks[i].scheduledDate.difference(curDate).inHours} hrs"),
             );
            }, separatorBuilder: (BuildContext context, int index)=>Divider(),
          ),
          ),
        );


Widget completedSection(context)=> Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:completedTasks.length>3?400:300,
            child: ListView.separated(
            itemCount: completedTasks.length,
            itemBuilder: (contex,i){
             return ListTile(
               leading: Checkbox(value:true ,onChanged: null,),
               title: Text(completedTasks[i].description),
               subtitle: Text("Completed ${completedTasks[i].scheduledDate.difference(curDate).inHours}hrs Ago"),
             );
            }, separatorBuilder: (BuildContext context, int index)=>Divider(),
          ),
          ),
        );


}
