import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/Models/ContriesInformations.dart';
import 'package:weatherapp/Models/WeatherInformations.dart';
import 'package:http/http.dart';
class ProviderData extends ChangeNotifier
{
  bool weaderInfosHasBeenLoaded = false;
  bool listOfCitiesIsLoaded = false;
  List<String> TodayWeader5hoursAfter = [];
  String weatherKey = "806f1cd3227fa28310a9b6b6aa9ebe53";
  List<WeatherInformations> weathersInformations = [];
  List<ContriesInformations> contriesInformations = [];
  void citiesList() async
  {
    if(listOfCitiesIsLoaded == false) {
      final responde = await get(Uri.parse(
          "http://api.timezonedb.com/v2.1/list-time-zone?key=9ZGAE5QIMRVS&format=json"));
      final body = jsonDecode(responde.body);
      List<dynamic> listBody = body["zones"];
      contriesInformations = listBody.map((e) => ContriesInformations(e["countryCode"], e["zoneName"].toString().substring(e["zoneName"].toString().indexOf("/") +1,e["zoneName"].toString().length), e["countryName"])).toList();
      print(" ${contriesInformations.elementAt(0).alphaCode}         dsqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
      notifyListeners();
      listOfCitiesIsLoaded = true;
    }
  }
  void userChoosedANewLocation(String city,String country)
  {
    weaderInfosHasBeenLoaded = false;
    weathersInformations.clear();
    notifyListeners();
    weatherInformations(city,country);
  }
  void weatherInformations(String city,String country) async
  {
    if(weaderInfosHasBeenLoaded == false) {
      final respende = await get(Uri.parse("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${city},${country}/2022-7-${DateFormat("dd").format(DateTime.now())}/2022-7-${DateFormat("dd").format(
              DateTime.now().add(const Duration(days: 6)))}?unitGroup=us&key=F6JR3KEHTZFN6GQWJ87SNUV2B"));
      final body = jsonDecode(respende.body);
      List<dynamic> thisWeekWeather = body["days"].toList();
      for (int i = 0; i < thisWeekWeather.length; i++) {
        if(weathersInformations.length <= 11) {
          var weatherinformations = WeatherInformations(
              "Agadir",
              DateTime.now(),
              21.9,
              11.5,
              29,
              false,"non");
          checkWeather(weatherinformations, i, thisWeekWeather, body);
          weathersInformations.add(weatherinformations,);
        }
      }
      notifyListeners();
      weaderInfosHasBeenLoaded = true;
    }
  }
  void checkWeather(WeatherInformations weatherInformations,int i,List<dynamic> thisWeekWeather,dynamic body)
  {
      weatherInformations.icon = thisWeekWeather.elementAt(i)["icon"];
      weatherInformations.date = DateTime.parse(thisWeekWeather.elementAt(i)["datetime"]);
      weatherInformations.tempMax = thisWeekWeather.elementAt(i)["tempmax"];
      weatherInformations.tempMin = thisWeekWeather.elementAt(i)["tempmin"];
      weatherInformations.humidity = thisWeekWeather.elementAt(i)["humidity"];
      List <dynamic> dayEachHourWeatherInformations = thisWeekWeather.elementAt(i)["hours"];
      weatherInformations.iconNight = dayEachHourWeatherInformations.elementAt(4)["icon"];
      if (thisWeekWeather.elementAt(i)["datetime"] == DateFormat("yyyy-MM-dd").format(DateTime.now())) {
        weatherInformations.address = body["address"];
        weatherInformations.condition = thisWeekWeather.elementAt(i)["conditions"];
        weatherInformations.feelsLike = thisWeekWeather.elementAt(i)["feelslike"];
        weatherInformations.temperature = thisWeekWeather.elementAt(i)["temp"];
        final List<dynamic> todayWeather = thisWeekWeather.elementAt(i)["hours"];
        for (int e = 0; e < 5; e++) {
          WeatherInformations weatherTodayMoreInformations = WeatherInformations(weatherInformations.icon,weatherInformations.date,weatherInformations.tempMax,weatherInformations.tempMin,weatherInformations.humidity,true,weatherInformations.iconNight);
          weatherTodayMoreInformations.condition = thisWeekWeather.elementAt(i)["conditions"];
          weatherTodayMoreInformations.feelsLike = thisWeekWeather.elementAt(i)["feelslike"];
          weatherTodayMoreInformations.temperature = thisWeekWeather.elementAt(i)["temp"];
            TodayWeader5hoursAfter.add("${DateFormat("yyyy-MM-dd HH").format(DateTime.now().add(Duration(hours: e)))}");
            if(thisWeekWeather.elementAt(i)["datetime"] == TodayWeader5hoursAfter.elementAt(e).substring(0,10)) {
              weatherTodayMoreInformations.temperature = todayWeather.elementAt(int.parse(TodayWeader5hoursAfter.elementAt(e).substring(11, 13)))["temp"];
              weatherTodayMoreInformations.humidity =  todayWeather.elementAt(int.parse(TodayWeader5hoursAfter.elementAt(e).substring(11, 13)))["humidity"];
              weatherTodayMoreInformations.date =  DateTime.parse("${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${todayWeather.elementAt(int.parse(TodayWeader5hoursAfter.elementAt(e).substring(11, 13)))["datetime"]}");
              weatherTodayMoreInformations.itsAnElementOfTheNext3h = true;
            }
            else
              {
                final List<dynamic> todayWeather = thisWeekWeather.elementAt(i +1)["hours"];
                {
                  weatherTodayMoreInformations.temperature = todayWeather.elementAt(int.parse(TodayWeader5hoursAfter.elementAt(e).substring(11, 13)))["temp"];
                  weatherTodayMoreInformations.humidity =  todayWeather.elementAt(int.parse(TodayWeader5hoursAfter.elementAt(e).substring(11, 13)))["humidity"];
                  weatherTodayMoreInformations.itsAnElementOfTheNext3h = true;
                }
              }
            weathersInformations.add(weatherTodayMoreInformations);
        }
      }

  }
}