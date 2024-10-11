import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimationHomePage(),
    );
  }
}

class AnimationHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animations'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('1. Basic Animation'),
            subtitle: Text('Simple rotation animation.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BasicAnimationExample()),
              );
            },
          ),
          ListTile(
            title: Text('2. Tween Animation'),
            subtitle: Text('Animates a container’s width and height.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TweenAnimationExample()),
              );
            },
          ),
          ListTile(
            title: Text('3. Scale Animation'),
            subtitle: Text('Scales a widget up and down.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScaleAnimationExample()),
              );
            },
          ),
          ListTile(
            title: Text('4. Fade Animation'),
            subtitle: Text('Fades a widget in and out.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FadeAnimationExample()),
              );
            },
          ),
          ListTile(
            title: Text('5. Rotation Animation'),
            subtitle: Text('Rotates a widget continuously.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RotationAnimationExample()),
              );
            },
          ),
          ListTile(
            title: Text('6. Custom Animation'),
            subtitle: Text('Combines multiple animations.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomAnimationExample()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 1. Basic Animation Example
class BasicAnimationExample extends StatefulWidget {
  @override
  _BasicAnimationExampleState createState() => _BasicAnimationExampleState();
}

class _BasicAnimationExampleState extends State<BasicAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Animation'),
      ),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

// 2. Tween Animation Example
class TweenAnimationExample extends StatefulWidget {
  @override
  _TweenAnimationExampleState createState() => _TweenAnimationExampleState();
}

class _TweenAnimationExampleState extends State<TweenAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 50, end: 200).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tween Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _sizeAnimation,
          builder: (context, child) {
            return Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              color: Colors.green,
            );
          },
        ),
      ),
    );
  }
}

// 3. Scale Animation Example
class ScaleAnimationExample extends StatefulWidget {
  @override
  _ScaleAnimationExampleState createState() => _ScaleAnimationExampleState();
}

class _ScaleAnimationExampleState extends State<ScaleAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scale Animation'),
      ),
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

// 4. Fade Animation Example
class FadeAnimationExample extends StatefulWidget {
  @override
  _FadeAnimationExampleState createState() => _FadeAnimationExampleState();
}

class _FadeAnimationExampleState extends State<FadeAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fade Animation'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}

// 5. Rotation Animation Example
class RotationAnimationExample extends StatefulWidget {
  @override
  _RotationAnimationExampleState createState() =>
      _RotationAnimationExampleState();
}

class _RotationAnimationExampleState extends State<RotationAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotation Animation'),
      ),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Icon(
            Icons.sync,
            size: 100,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}

// 6. Custom Animation Example
class CustomAnimationExample extends StatefulWidget {
  @override
  _CustomAnimationExampleState createState() => _CustomAnimationExampleState();
}

class _CustomAnimationExampleState extends State<CustomAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // _fadeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(_controller);
    _moveAnimation = Tween<double>(begin: 0, end: -200).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
                opacity: 1,
                child: Transform.translate(
                  offset: Offset(0.0, _moveAnimation.value),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.pink,
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
