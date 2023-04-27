import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe_music/generated/l10n.dart';
import 'package:vibe_music/widgets/TrackTile.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? const Color(0xffF4F8FF).withAlpha(200)
            : Color(0xff9496A8),

        elevation: 0,
        title: Text(
          S.of(context).My_Favorites,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: Theme.of(context).brightness == Brightness.light
              ? DecorationImage(
            image: AssetImage("assets/images/fondo_like.png"),
            fit: BoxFit.cover,
          )
              : DecorationImage(
            image: AssetImage("assets/images/fondo_dark.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('myfavourites').listenable(),
          builder: (BuildContext context, Box box, child) {
            List favourites = box.values.toList();
            favourites.sort((a, b) => a['timeStamp'].compareTo(b['timeStamp']));
            if (favourites.isEmpty) {
              return Center(
                child: Text(
                  S.of(context).Nothing_Here,
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                ),
              );
            }
            return ListView(
              children: favourites.map((track) {
                Map<String, dynamic> newMap = jsonDecode(jsonEncode(track));
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key("$newMap['videoId']"),
                  onDismissed: (direction) {
                    box.delete(newMap['videoId']);
                  },
                  background: Container(
                    child: Center(
                      child: Text(
                        S.of(context).Remove_from_favorites,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge
                            ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.5, sigmaY: 5.5),
                        child: Container(
                          color: Theme.of(context).brightness == Brightness.light
                              ? const Color(0XFFFfffff).withOpacity(0.55)
                              : Colors.black.withOpacity(0.44),
                          child: TrackTile(track: newMap),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );


          },
        ),
      ),
    );
  }
}
