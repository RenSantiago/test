import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  late final tickerProvider = createTicker((elapsed) => setState(() {}));

  @override
  void initState() {
    tickerProvider.start();
    super.initState();
  }

  @override
  void dispose() {
    tickerProvider.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    final month = DateFormat('MMMM').format(time);
    final day = DateFormat('dd').format(time);
    final minSec = DateFormat('hh:mm:ss a').format(time);

    TextStyle dateStyle(double size) {
      return TextStyle(fontSize: size, fontWeight: FontWeight.bold);
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text(
               '${month} ${day} ',
               style: dateStyle(10),
             ),
             Text(minSec , style : dateStyle(25))
           ],
         ),

        ],
      ),
    );
  }
}
