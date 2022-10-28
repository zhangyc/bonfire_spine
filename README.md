<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

spine runtime on bonfire

## Features

spine runtime on bonfire

https://user-images.githubusercontent.com/10071342/198290315-27426d20-43cf-4445-9bb5-ef727e0d89b6.mp4
## Getting started

start using the package.

## Usage

Include short and useful examples for package users. Add longer examples
to `/example` folder.
```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

@override
State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
@override
Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () async{
              bool loaded=await load();
              if(!loaded){
                return;
              }
              SpinePlayer player=SpinePlayer(position: Vector2.all(32)*8, size: Vector2.all(32)*3, skeleton: skeleton);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameTiledMapWithSpine(player: player,)),
              );
            }, child: const Text('spine'))
          ],
        ),
      ),
    );
}
static const String pathPrefix = 'assets/skeletons/';

String name = 'spineboy';

late Set<String> animations;
late SkeletonAnimation skeleton;
Future<bool> load() async {
animations = await loadAnimations();
skeleton = await loadSkeleton(); 

    return true;
}

Future<Set<String>> loadAnimations() async {
final String skeletonFile = '$name.json'; 
final String s = await rootBundle.loadString('$pathPrefix$name/$skeletonFile'); 
final Map<String, dynamic> data = json.decode(s);

    return ((data['animations'] ?? <String, dynamic>{}) as Map<String, dynamic>)
        .keys
        .toSet(); 
}

Future<SkeletonAnimation> loadSkeleton() async =>
SkeletonAnimation.createWithFiles(name, pathBase: pathPrefix); 
}

```
const like = 'sample';
```

## Additional information

https://github.com/jtakakura/spine_core<br>
https://github.com/jtakakura/spine_flutter