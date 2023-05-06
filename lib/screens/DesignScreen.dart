// Dependencias de Flutter
import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
// Dependencias de la app

// Los link de de las depedencias de la comunidad se pueden encdontrar en ( Más opciones > Dependencias )
import 'package:cached_network_image/cached_network_image.dart';
//-----------------//
// flutter_animate // Una biblioteca de alto rendimiento que simplifica la adición de casi cualquier tipo de efecto animado en Flutter
//-----------------//
import 'package:flutter_animate/flutter_animate.dart';


// ignore: must_be_immutable
class PageLoginGuideAr extends StatefulWidget {
  const PageLoginGuideAr({
    super.key,
  });


  @override
  State<PageLoginGuideAr> createState() => _PageLoginGuideArState();

}

class _PageLoginGuideArState extends State<PageLoginGuideAr> {

  // values
  late Timer timer;
  late bool isDarkMode;
  late Size sizeScreen;
  final TextStyle textStyle_1 = TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 24);
  final TextStyle textStyle_2 = TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30);
  int indexImage = 0 ;
  final List<String> imageList = [

    'https://i.pinimg.com/originals/e9/24/55/e92455655b5037565a14f6c1f2e4c985.jpg',
    'https://i.pinimg.com/564x/e2/f4/79/e2f479f3509f1895f9c04d4ceccd873e.jpg',

    'https://i.pinimg.com/originals/1a/c4/17/1ac417373f52df2655c8b25c3142840a.jpg',
    'https://i.pinimg.com/originals/9e/89/a8/9e89a862c93139dd7e83dc897c92fcf6.jpg',
    'https://i.pinimg.com/originals/9b/99/1e/9b991e0965103317133ddd740d0a0bb5.png',


    'https://i.pinimg.com/736x/a5/e6/95/a5e695cc85169331e3cdd271df0fc137.jpg',
  ];

  @override
  void initState() {
    super.initState();

    // Inicializar un temporizador periódico
    timer = Timer.periodic(
      Duration(milliseconds: indexImage==0?7000:4000),
          (_) {
        // la devolución de llamada se ejecutará cada sierto tiempo, incrementado un valor de conteo en cada devolución de llamada
        setState(() {
          if(indexImage == imageList.length-1){indexImage=0;}
          else{indexImage++;}
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    // get values
    isDarkMode = Theme.of(context).brightness==Brightness.dark;
    sizeScreen =  MediaQuery.of(context).size;

    // SystemUiOverlayStyle : Especifica una preferencia para el estilo de las superposiciones del sistema.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // barra de estado transparente
        statusBarIconBrightness: Theme.of(context).brightness==Brightness.dark?Brightness.light:Brightness.dark, // color de los iconos de la barra de estado
      ),
      child: Material(
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              // background : imagen de la ciudad
              AnimatedContainer(
                key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                duration: const Duration(milliseconds: 1000),
                child: _backgroundimage(urlImage: imageList[indexImage])
                    .animate()
                    .fade(duration: 4000.ms)
                    .scale(delay: 1.ms, duration: indexImage == 0 ? 4000.ms : 8000.ms, begin: Offset(1, indexImage == 0 ? 3 : 1), alignment: indexImage == 0 ? Alignment.topCenter : Alignment.centerRight)
                    .move(duration: 5000.ms),
              ),

              // background : Le da un efecto a la imagen de un degradado
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(begin: FractionalOffset.topCenter,end: FractionalOffset.bottomCenter,colors: [Colors.transparent,Theme.of(context).scaffoldBackgroundColor],stops: [0.0, 0.8])),
              ),
              // Text : texto de Bienvenida
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 200),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hola, bienvenido!',style:textStyle_1)
                          .animate()
                          .fade(delay: 1000.ms,duration: 500.ms),
                      const SizedBox(height: 12),
                      Text('      Esto es ARGENTINA',style:textStyle_2)
                          .animate().fade(delay: 2000.ms,duration: 500.ms),
                    ],
                  ),
                ),
              ),
              // Button : boton para iniciar sesión
              Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buttonLogIn(text: 'Iniciar guía',textColor:Colors.white,color: Colors.grey.shade900)
                              .animate().fade(delay: 4300.ms,duration: 500.ms)
                              .animate(onPlay: (controller) => controller.repeat()) // + repetición permanente
                              .shimmer(delay: 5500.ms, duration: 1800.ms)     // + brillar
                              .shake(hz: 4, curve: Curves.easeInOutCubic)     // + sacudir
                              .scale(begin: const Offset(1,0), end: const Offset(1,1), duration: 600.ms)  // + aumentar proporcionalmente
                              .then(delay: 600.ms) // esperar +
                              .scale(begin: const Offset(0,1), end:const Offset(0, 1 / 1.1)), // disminuir proporcionalmente +
                          const SizedBox(height: 12),
                          // Text : sugerencia para el usuario
                          TextButton(onPressed: (){},child: Text('¿Tienes alguna duda? Contacta con alguien',style: TextStyle(color: Colors.grey)))
                              .animate()
                              .fade(delay: 6300.ms,duration: 500.ms),
                        ],
                      )
                  )),
              // Button : cambia el brillo de la app
              Align(alignment: Alignment.topRight,child: SafeArea(child: Material(color: Colors.transparent,child: WidgetsUtilsApp().buttonThemeBrightness(context: context, buttonColor: Colors.white)))),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGETS MAIN
  Widget _backgroundimage({required String urlImage}){
    // esta imagen ocupará todo el espacio disponible del widget padre
    return SizedBox(
      height: double.infinity,width: double.infinity,
      child: CachedNetworkImage(
        fit: BoxFit.cover,fadeInDuration: Duration(milliseconds: 600),
        imageUrl: urlImage,
        placeholder: (context, urlImage) => Container(),
        errorWidget: (context, urlImage, error) => Container(),
      ),
    );
  }

  // WIDGETS COMPONETS
  Widget buttonLogIn({required String text,Color textColor = Colors.white,Color color = Colors.blue}){
    return ElevatedButton(
      onPressed: (){},
      child: Text(text),
      style: ElevatedButton.styleFrom(backgroundColor: color,shadowColor:color,elevation: 12,padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),textStyle: TextStyle(fontSize: 20),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
    );
  }
}




class WidgetsUtilsApp {
  Widget buttonThemeBrightness({
    required BuildContext context,
    required Color buttonColor,
  }) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isDarkMode ? Colors.black: Colors.white, backgroundColor: buttonColor,
      ),
      onPressed: () {
        //TODO: Add your onPressed function here
      },
      child: Text('Button'),
    );
  }
}
