import 'package:cloud_firestore/cloud_firestore.dart';

class TimeEntryModel {
  final String month;
  final String day;
  final String abbr;
  final String year;
   String? id;
  DateTime? start;
  final String uid;
  DateTime? end;
  Timestamp? createdOn;

  TimeEntryModel(
      {required this.uid,
      required this.year,
      required this.month,
      required this.abbr,
      required this.day,
      required this.start,
      this.end ,
      this.id});

  TimeEntryModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        year = json['year'],
        month = json['month'],
        abbr = json['abbr'],
        day = json['day'],
        start = json['start'].toDate()  ?? null,
        end = json['end'] != null ? json['end'].toDate() : null,
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'year': this.year,
        'month': this.month,
        'abbr': this.abbr,
        'day': this.day,
        'start': this.start ,
        'end': this.end,
        'id' : this.id,
        'createdOn' : Timestamp.now()
      };
}
