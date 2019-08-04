import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intern_app/database/task_model.dart';



//this class is used to perform the service oprations
class TaskService {
 
  //this getTask() method is used to retrive the data through http get request
  Future<List<Task>> getTasks() async {
    final response =
        await http.get('http://www.mocky.io/v2/582695f5100000560464ca40');

//if the http response returns the status code of ok that is 200 then parse the json from its body
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      //below line will converts the json data into object model
      var sorted = data.map((json) => Task.fromJson(json)).toList();
      Task temp;

//below block of code is used to sort the objects by it scheduled date
      for (int i = 0; i < sorted.length; i++) {
        for (int j = 1; j < sorted.length - i; j++) {
          if (sorted[j - 1].scheduledDate.compareTo(sorted[j].scheduledDate) ==
              1) {
            //swap the objects in array
            temp = sorted[j - 1];
            sorted[j - 1] = sorted[j];
            sorted[j] = temp;
          }
        }
      }

      return sorted;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
