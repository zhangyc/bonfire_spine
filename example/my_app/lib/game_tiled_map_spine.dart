import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bonfire_spine/player/spine_player.dart';

enum PlayerAttackType { AttackMelee, AttackRange }

class GameTiledMapWithSpine extends StatelessWidget {
  final int map;
  final SpinePlayer player;
  const GameTiledMapWithSpine({Key? key, this.map = 1,required this.player}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BonfireWidget(
          joystick: Joystick(
            keyboardConfig: KeyboardConfig(
              keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
              acceptedKeys: [
                LogicalKeyboardKey.space,
              ],
            ),
            directional: JoystickDirectional(
              spriteBackgroundDirectional: Sprite.load(
                'joystick_background.png',
              ),
              spriteKnobDirectional: Sprite.load('joystick_knob.png'),
              size: 100,
              isFixed: false,
            ),

            actions: [
              JoystickAction(
                actionId: PlayerAttackType.AttackMelee,
                sprite: Sprite.load('joystick_atack.png'),
                align: JoystickActionAlign.BOTTOM_RIGHT,
                size: 80,
                margin: EdgeInsets.only(bottom: 50, right: 50),
              ),
              JoystickAction(
                actionId: PlayerAttackType.AttackRange,
                sprite: Sprite.load('joystick_atack_range.png'),
                spriteBackgroundDirection: Sprite.load(
                  'joystick_background.png',
                ),
                enableDirection: true,
                size: 50,
                margin: EdgeInsets.only(bottom: 50, right: 160),
              )
            ],
          ),
          showCollisionArea: true,
          player: player,
          map: WorldMapByTiled(
            'tiled/mapa1.json',
          ),
          // lightingColorGame: Colors.black.withOpacity(0.7),
          cameraConfig: CameraConfig(
            smoothCameraEnabled: true,
            smoothCameraSpeed: 2,
          ),
        );
      },
    );
  }
}
