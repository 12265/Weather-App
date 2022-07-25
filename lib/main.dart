import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Models/TextShape.dart';
import 'package:weatherapp/Provider/ProviderData.dart';
import 'package:weatherapp/scrollingListOfCities.dart';

import 'Models/WeatherInformations.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ProviderData(), child: MaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  Widget next5HoursAfterInfo(
      WeatherInformations e, MediaQueryData mediaQuery, double textSize) {
    return Column(
      children: [
        TextShape(DateFormat("HH:mm").format(e.date), textSize,
            textColor: Colors.black38),
        Image.asset(
          "Images/${e.icon}.png",
          width: mediaQuery.size.width * 0.07,
          height: mediaQuery.size.width * 0.07,
        ),
        TextShape(
          "${((e.temperature! - 32) * 5 / 9).toString().substring(0, 2)}°",
          textSize,
          fontWeight: FontWeight.w400,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.005),
          child: Row(
            children: [
              Icon(
                Icons.water_drop_outlined,
                size: mediaQuery.size.width * textSize - 0.001,
              ),
              TextShape(
                "${e.humidity.toString().substring(0, 2)}%",
                textSize - 0.01,
                textColor: Colors.black38,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget thisWeekWeatherInformations(WeatherInformations weatherOfaDayInThisWeek, double textSize, MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.all(mediaQuery.size.width * 0.03),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
        Container(width: mediaQuery.size.width * 0.3,height: mediaQuery.size.height * 0.021,
          child:DateFormat("yyyy/MM/dd").format(weatherOfaDayInThisWeek.date) != DateFormat("yyyy/MM/dd").format(DateTime.now()) ? TextShape(DateFormat("EEEE").format(weatherOfaDayInThisWeek.date),
              textSize,
              fontWeight: FontWeight.w400):TextShape("Today", textSize, fontWeight: FontWeight.w400),
        ),
 Spacer(flex: 2),
          Icon(Icons.water_drop_outlined,size: mediaQuery.size.height * 0.02),
        Container(height: mediaQuery.size.height * 0.015,width: mediaQuery.size.width * 0.1,
          child: TextShape(
            "${weatherOfaDayInThisWeek.humidity.toString().substring(0, 2)}%",
            textSize - 0.01,
            textColor: Colors.black38,
          ),
        ),
        Spacer(flex:  1),
        Container(height: mediaQuery.size.height * 0.04,width: mediaQuery.size.width * 0.1,child: Image.asset("Images/${weatherOfaDayInThisWeek.icon}.png",width: mediaQuery.size.width *0.07)),
        Container(height: mediaQuery.size.height * 0.04,width: mediaQuery.size.width * 0.1,child: Image.asset("Images/${weatherOfaDayInThisWeek.iconNight}.png",width: mediaQuery.size.width *0.07)),
        Spacer(flex: 1,),
        Container(height: mediaQuery.size.height * 0.018,width: mediaQuery.size.width *0.2,
          child: TextShape("${((weatherOfaDayInThisWeek.tempMax- 32) * 5 / 9).toString().substring(0,2)}°/${((weatherOfaDayInThisWeek.tempMin - 32) * 5 / 9).toString().substring(0,2)}", textSize,
              fontWeight: FontWeight.w400),
        ),
      ]),
    );
  }

  Widget build(BuildContext context) {
    // object 1 taking 0.24 of screen object 2 taking 0.34  object 3 taking 0.02 object 4 taking 0.4
    final mediaQuery = MediaQuery.of(context);
    final textSize = 0.04;
    context.read<ProviderData>().weatherInformations("Agadir","morocco");
    return Scaffold(
        body: context.watch<ProviderData>().weaderInfosHasBeenLoaded == false
            ? Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextShape("LOADING", 0.1),Icon(Icons.downloading,size: mediaQuery.size.height * 0.1,color: Colors.blue)
              ],
            ))
            : Column(
                children: [Container(height: mediaQuery.padding.top),
                  Container(height: mediaQuery.size.height * 0.222,decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("Images/TheWeather.jpg"))),),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.02),
                    child: Card(color: Colors.white70,
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(mediaQuery.size.height * 0.005),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    mediaQuery.size.height * 0.007),
                                child: TextButton(onPressed:() {Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  ListOfCities()));},
                                  child: Row(children: [
                                    Icon(Icons.location_on),
                                    TextShape(
                                      context
                                          .watch<ProviderData>()
                                          .weathersInformations
                                          .elementAt(5)
                                          .address
                                          .toString()
                                          .substring(
                                              0,
                                              context
                                                  .watch<ProviderData>()
                                                  .weathersInformations
                                                  .elementAt(5)
                                                  .address
                                                  ?.indexOf(",")),
                                      0.05,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ]),
                                ),
                              ),
                              TextShape(
                                "${DateFormat("EEE, dd,MMM").format(context.watch<ProviderData>().weathersInformations.elementAt(5).date)} ${DateFormat("HH:mm").format(DateTime.now())}",
                                textSize,
                                textColor: Colors.black38,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: mediaQuery.size.height * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(height: mediaQuery.size.height * 0.08,width: mediaQuery.size.width * 0.15,
                                      child: Image.asset(
                                          "Images/${context.watch<ProviderData>().weathersInformations.elementAt(5).icon}.png"),
                                    ),
                                    TextShape(
                                        "${((context.watch<ProviderData>().weathersInformations.elementAt(5).temperature! - 32) * 5 / 9).toString().substring(0, 2)}°",
                                        textSize * 3),
                                    Spacer(),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          //hadi
                                          TextShape(
                                            context
                                                .watch<ProviderData>()
                                                .weathersInformations
                                                .elementAt(5)
                                                .condition
                                                .toString(),
                                            textSize,
                                            textColor: Colors.black38,
                                          ),
                                          TextShape(
                                              "${((context.watch<ProviderData>().weathersInformations.elementAt(5).tempMax - 32) * 5 / 9).toString().substring(0, 2)}°/${((context.watch<ProviderData>().weathersInformations.elementAt(5).tempMin - 32) * 5 / 9).toString().substring(0, 2)}°",
                                              textSize,
                                              textColor: Colors.black38),
                                          TextShape(
                                              "Feels Like ${((context.watch<ProviderData>().weathersInformations.elementAt(5).feelsLike! - 32) * 5 / 9).toString().substring(0, 2)}°",
                                              textSize,
                                              textColor: Colors.black38),
                                        ]),
                                  ],
                                ),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ...context
                                        .watch<ProviderData>()
                                        .weathersInformations
                                        .expand((e) => [
                                              if (e.itsAnElementOfTheNext3h ==
                                                  true)
                                                next5HoursAfterInfo(
                                                    e, mediaQuery, textSize)
                                            ])
                                        .toList()
                                  ])
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.02,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width * 0.02),
                      child: Container(color: Colors.white70,
                          height: mediaQuery.size.height * 0.40,
                          width: double.infinity,
                          child: Card(elevation: 10,color: Colors.white70,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...context
                                      .watch<ProviderData>()
                                      .weathersInformations
                                      .expand((element) => [
                                            if (element.itsAnElementOfTheNext3h ==
                                                    false &&
                                                element.icon != "Agadir")
                                              thisWeekWeatherInformations(
                                                  element,
                                                  textSize,
                                                  mediaQuery)
                                          ])
                                      .toList()
                                ],
                              ),
                            ),
                          )))
                ],
              ));
  }
}
