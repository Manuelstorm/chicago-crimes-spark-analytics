import 'package:flutter/material.dart';

import '../model/Area.dart';
import '../model/Model.dart';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class ImageWithPoint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageWithPointState();
}

class _ImageWithPointState extends State<ImageWithPoint> {
  List<Point> lista = [
    Point(465, 20),
    Point(424, 20),
    Point(484, 131),
    Point(428, 107),
    Point(450, 157),
    Point(487, 192),
    Point(488, 229),
    Point(518, 280),
    Point(224, 19),
    Point(215, 95),
    Point(281, 113),
    Point(296, 47),
    Point(389, 70),
    Point(408, 131),
    Point(290, 148),
    Point(413, 164),
    Point(264, 183),
    Point(256, 233),
    Point(326, 224),
    Point(365, 252),
    Point(387, 198),
    Point(397, 236),
    Point(370, 277),
    Point(440, 284),
    Point(324, 342),
    Point(373, 335),
    Point(414, 330),
    Point(514, 336),
    Point(420, 380),
    Point(376, 446),
    Point(462, 421),
    Point(548, 335),
    Point(570, 405),
    Point(544, 411),
    Point(565, 443),
    Point(600, 467),
    Point(546, 495),
    Point(579, 503),
    Point(615, 504),
    Point(565, 553),
    Point(605, 541),
    Point(593, 579),
    Point(630, 617),
    Point(555, 661),
    Point(621, 649),
    Point(704, 677),
    Point(611, 698),
    Point(668, 698),
    Point(548, 778),
    Point(601, 766),
    Point(634, 817),
    Point(719, 718),
    Point(514, 820),
    Point(610, 878),
    Point(667, 879),
    Point(266, 548),
    Point(371, 512),
    Point(424, 498),
    Point(476, 458),
    Point(507, 430),
    Point(471, 494),
    Point(372, 548),
    Point(416, 538),
    Point(272, 576),
    Point(366, 618),
    Point(432, 608),
    Point(487, 607),
    Point(527, 607),
    Point(555, 628),
    Point(375, 660),
    Point(518, 672),
    Point(455, 750),
    Point(501, 707),
    Point(400, 792),
    Point(508, 784),
    Point(58, 135),
    Point(490, 85),
  ];
  List<Area> dati;
  int area = 1;
  double scale = 0.7;
  bool datiOttenuti = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return datiOttenuti
        ? Container(
            width: 740 * scale,
            height: 900 * scale,
            child: Stack(
              children: [
                // Carico l'immagine dalla rete
                Image(
                    image: AssetImage('images/Chicago_Community_Areas.svg.png'),
                    fit: BoxFit.fill),

                // Aggiungo il punto sull'immagine

                for (int i = 0; i < lista.length; i++)
                  Positioned(
                    left: lista[i].x * scale,
                    top: lista[i].y * scale,
                    child: Tooltip(
                      message: "Community Area: "+i.toString()+"\nCrimini: "+getCountByArea(i).toString(),
                      child: Container(
                        width: 17.0, //lista[dati[i-1].title.toInt()],
                        height: 17.0,
                        decoration: BoxDecoration(
                          color: (getCountByArea(i) / 421937) + 0.3 > 1
                              ? Colors.red.withOpacity(1)
                              : Colors.red.withOpacity(
                                  (getCountByArea(i) / 421937) + 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        : Container(
            child: Stack(children: [
            // Carico l'immagine dalla rete
            Image(
                image: AssetImage('images/empty_map.png'),
                fit: BoxFit.fill),
          ]));
  }

  double getCountByArea(int index) {
    for (Area a in dati) {
      if (a.title == index) {
        return a.value;
      }
    }
  }

  Future<void> _getData() async {
    setState(() {
      datiOttenuti = false;
      dati = null;
    });
    (Model.sharedInstance.getAreasMap().then((result) {
      setState(() {
        datiOttenuti = true;
        dati = result;
      });
    }));
  }
}
