import 'package:flutter/material.dart';
import 'package:intern_app/pages/later.dart';
import 'package:intern_app/database/services.dart';
import 'package:intern_app/database/task_model.dart';
import 'package:intern_app/pages/today.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskService taskService=new TaskService();
   DateTime curDate=DateTime.parse("2016-11-12 00:00:00.000");
  List<Task> today=new List<Task>();
  List<Task> later=new List<Task>();
  List<Task> allTask=new List<Task>();
  bool isLoading=false;
@override
void initState(){
  super.initState();
  
getdata();

}
//this function is called to get thhe data from the services class
void getdata()async{
  setState(() {
   isLoading=true;
  });
 await taskService.getTasks().then((value){
   allTask=value;
   
  
   }).whenComplete((){
     classify();
      setState(() {
    isLoading=false; 
   });
     }).catchError((e)=>print(e));
}

//this function is used to classify the tasks
void classify(){
  if(allTask.length >0){
    allTask.forEach((task){
      if(task.scheduledDate.difference(curDate).inHours < 23){
          today.add(task);
          print("todays tasks");
          print(task.description);
      }else{
        later.add(task);
        print("later tasks");
          print(task.description);
      }
    });
  }
}
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
       child: Scaffold(
          appBar: AppBar(
        bottom: TabBar(indicatorColor: Colors.white,
          tabs: [
            Tab(text: "Today",),
            Tab(text: "Later",),
            
          ],
        ),
        title: Text('Task Reminder'),
        centerTitle: true,
          ),
          body: TabBarView(
        children: [
          isLoading? Center(child:CircularProgressIndicator()):TodaysTaskListPage(tasks: today,),
          isLoading? Center(child:CircularProgressIndicator()):MyLaterTaskPage(laterTasks: later,),
          
        ],
          ),
        ), 
        );
  }
}
