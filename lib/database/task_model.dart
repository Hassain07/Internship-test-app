class Task {
  int _id;
  String _description;
  DateTime _scheduledDate;
  String _status;

  Task(
      {int id, String description, DateTime scheduledDate, String status}) {
    this._id = id;
    this._description = description;
    this._scheduledDate = scheduledDate;
    this._status = status;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get description => _description;
  set description(String description) => _description = description;
  DateTime get scheduledDate => _scheduledDate;
  set scheduledDate(DateTime scheduledDate) => _scheduledDate = scheduledDate;
  String get status => _status;
  set status(String status) => _status = status;

  Task.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _description = json['description'];
    _scheduledDate = getDate(json['scheduledDate']);
    _status = json['status'];
  }

DateTime getDate(String str){
  
      String dateWithT = str.substring(0, 8) + 'T' + str.substring(8);
      DateTime dateTime = DateTime.parse(dateWithT);
      return dateTime;
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['description'] = this._description;    
    data['scheduledDate'] = this._scheduledDate;
    data['status'] = this._status;
    return data;
  }
}
