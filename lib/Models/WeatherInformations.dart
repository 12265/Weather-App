class WeatherInformations
{
   String? condition;
   String icon;
   String iconNight;
   DateTime date;
   double tempMax;
   double tempMin;
   double humidity;
   double? temperature;
   double? feelsLike;
   String? address;
   bool itsAnElementOfTheNext3h;
  WeatherInformations(
      this.icon, this.date, this.tempMax, this.tempMin, this.humidity,this.itsAnElementOfTheNext3h,this.iconNight,{this.temperature,this.feelsLike,this.condition,this.address});
}