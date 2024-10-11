import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testsampleproject/TimeTracker/Clock.dart';
import 'package:testsampleproject/TimeTracker/TimeEntry.dart';
import 'package:testsampleproject/TimeTracker/TimeEntry_model.dart';
import 'package:testsampleproject/TimeTracker/TimeTracker_bloc.dart';
import 'package:testsampleproject/TimeTracker/TimeTracker_event.dart';
import 'package:testsampleproject/TimeTracker/TimeTracker_state.dart';

class TimeTrackerPage extends StatefulWidget {
  @override
  State<TimeTrackerPage> createState() => _TimeTrackerPageState();
}

class _TimeTrackerPageState extends State<TimeTrackerPage> {
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String uid = '';
  List<TimeEntryModel> _mock = [];
  String? activeMonth = DateFormat('MMMM').format(DateTime.now());
  String? activeEntry;
  TimeTrackerBloc? _timeTrackerBlocProvider;
  bool _timeTrackerLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeTrackerBlocProvider = BlocProvider.of<TimeTrackerBloc>(context) ;
    _timeTrackerBlocProvider!.add(GetAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void handleTimeIn() {
      final time = DateTime.now();
      final month = DateFormat('MMMM').format(time).toString();
      final abbr = DateFormat('MMM').format(time).toString();
      final day = DateFormat('dd').format(time).toString();
      final year = DateFormat('yyyy').format(time).toString();
      final start = time;
      final timeEntry = TimeEntryModel(
          year: year, month: month, day: day, start: start, abbr: abbr , uid : uid);
      // setState(() {
      //   activeEntry = timeentry;
      // });
      _timeTrackerBlocProvider!.add(AddTimeTrackerEvent(timeEntry));
    }

    void handleTimeOut() {
      // setState(() {
      //   if (activeEntry != null) {
      //     activeEntry!.end = DateTime.now();
      //     _mock.add(activeEntry!);
      //     activeEntry = null;
      //   }
      // });
      TimeEntryModel activeTimeEntry = _mock.where((timeEntry) => timeEntry.id == activeEntry).single;
      activeTimeEntry.end = DateTime.now();
      _timeTrackerBlocProvider!.add(AddTimeOutEvent(activeTimeEntry));
    }

    return BlocConsumer<TimeTrackerBloc , TimeTrackerState>(builder: (context , state) {
      if(state is AuthLoadingState) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {

        return Scaffold(
          body: Column(
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DropdownButton<String>(
                                              value: activeMonth,
                                              icon: Icon(Icons.calendar_month),
                                              items: _months
                                                  .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(fontSize: 24),
                                                    ));
                                              }).toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  activeMonth = value;
                                                });
                                                _timeTrackerBlocProvider!.add(GetTimeEntriesEvent(uid: uid, month: activeMonth.toString()));
                                              }),
                                          IconButton(onPressed: (){
                                            _timeTrackerBlocProvider!.add(SignoutEvent());
                                          }, icon: Icon(Icons.logout))
                                        ],
                                      )
                                  ),
                                  ListView.builder(
                                      itemCount: _mock.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return TimeEntry(timeEntry: _mock[index]);
                                      })
                                ],
                              ))),
                      Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 1, color: Colors.black12)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 20,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ]
                        ),

                        child: !_timeTrackerLoading ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClockWidget(),
                              if (activeEntry == null)
                                ElevatedButton(
                                    onPressed: handleTimeIn, child: Text('Time in')),
                              if (activeEntry != null)
                                ElevatedButton(
                                    onPressed: handleTimeOut, child: Text('Time out'))
                            ]) : Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        );


      }
    }, listener: (context , state) {
      if(state is AuthStateSignOut) {
        Navigator.pushNamed(context, '/login');
      } else if(state is AuthLoadedState) {
        _timeTrackerBlocProvider!.add(GetTimeEntriesEvent(
            uid: state.uid ,
        month: activeMonth.toString()));
        setState(() {
          uid = state.uid;
        });
      } else if(state is TimeTrackerLoadingState) {
        setState(() {
          _timeTrackerLoading = true;
        });
      } else if(state is TimeTrackerLoadedState) {
        setState(() {
          _timeTrackerLoading = false;
          print(state.id);
          activeEntry = state.id;
        });
      } else if(state is TimeEntriesLoadedState) {
        setState(() {
          _mock = state.timeEntries;
        });
      } else if(state is AddTimeEntrySuccessState) {
       if( state.timeEntry.month == activeMonth) {
         setState(() {
           _mock = [state.timeEntry, ..._mock];
         });
       }

      }
    });
  }
}
