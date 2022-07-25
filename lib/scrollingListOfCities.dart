import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Provider/ProviderData.dart';

import 'Models/TextShape.dart';

class ListOfCities extends StatelessWidget {
  Widget build(BuildContext context) {
    context.read<ProviderData>().citiesList();
    final appbar = AppBar(
      title: const Center(
        child: Text("Choose A city"),),
    );
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appbar,
      body: context
          .watch<ProviderData>()
          .contriesInformations.isEmpty ? Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextShape("LOADING", 0.1),Icon(Icons.downloading,size: mediaQuery.size.height * 0.1,color: Colors.blue)
        ],
      )) : ListView.builder(
        itemBuilder: (context, index) {
          return Card(elevation: 10, child: Container(
            width: double.infinity,
            height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
                0.05,
            child: Row(
              children: [ClipOval(
            child: Image.asset(
            'icons/flags/png/${context
                .watch<ProviderData>()
                .contriesInformations
                .elementAt(index).alphaCode.toLowerCase()}.png',
            package: 'country_icons',
            height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
                0.05,
            width: mediaQuery.size.width * 0.12,
          )),
                TextButton(onPressed: () {
                  context.read<ProviderData>().userChoosedANewLocation(Provider.of<ProviderData>(context, listen: false).contriesInformations.elementAt(index).City,Provider.of<ProviderData>(context, listen: false).contriesInformations.elementAt(index).Contry);
                  Navigator.pop(context);
                }, child: Text(context
                    .watch<ProviderData>()
                    .contriesInformations
                    .elementAt(index).City)),
              ],
            ),
          ));
        }, itemCount: context
          .watch<ProviderData>()
          .contriesInformations
          .length,),
    );
  }
}
