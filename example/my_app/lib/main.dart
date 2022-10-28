import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game_tiled_map_spine.dart';
import 'package:bonfire_spine/spine/skeleton_animation.dart';
import 'package:bonfire_spine/player/spine_player.dart';
import 'package:bonfire/bonfire.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
    skeleton = await loadSkeleton(); ///加载骨骼动画

    return true;
  }

  Future<Set<String>> loadAnimations() async {
    final String skeletonFile = '$name.json'; ///加载json
    final String s = await rootBundle.loadString('$pathPrefix$name/$skeletonFile'); ///加载和解析为json格式
    final Map<String, dynamic> data = json.decode(s);

    return ((data['animations'] ?? <String, dynamic>{}) as Map<String, dynamic>)
        .keys
        .toSet(); ///加载角色的所有动画，当前只有一个spine。
  }

  Future<SkeletonAnimation> loadSkeleton() async =>
      SkeletonAnimation.createWithFiles(name, pathBase: pathPrefix);  ///加载纹理
}
