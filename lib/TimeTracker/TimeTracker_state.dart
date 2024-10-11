import 'package:testsampleproject/TimeTracker/TimeEntry_model.dart';

abstract class TimeTrackerState {}


class TimeEntriesState extends TimeTrackerState {}

class TimeEntriesLoadingState extends TimeTrackerState{}
class TimeEntriesLoadedState extends TimeTrackerState{
  List<TimeEntryModel> timeEntries;
  TimeEntriesLoadedState(this.timeEntries);
}
class TimeTrackerInitialState extends TimeTrackerState{}

class TimeTrackerLoadingState extends TimeTrackerState{}

class TimeTrackerLoadedState extends TimeTrackerState{
  final String? id;
  TimeTrackerLoadedState(this.id);
}

class AddTimeEntrySuccessState extends TimeTrackerState {
  final TimeEntryModel timeEntry;
  AddTimeEntrySuccessState(this.timeEntry);
}


class AuthLoadedState extends TimeTrackerState{
  final String uid;
  AuthLoadedState(this.uid);
}
class AuthLoadingState extends TimeTrackerState {}
class AuthStateSignOut extends TimeTrackerState {}