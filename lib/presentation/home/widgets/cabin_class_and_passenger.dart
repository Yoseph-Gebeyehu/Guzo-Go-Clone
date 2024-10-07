import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/cabin_class.dart';
import 'package:guzo_go_clone/presentation/home/provivder/home_provider.dart';

// ignore: must_be_immutable
class CabinClassAndPassenger extends StatelessWidget {
  CabinClassAndPassenger({
    super.key,
    required this.cabinClass,
    required this.homeProvider,
  });

  CabinClass cabinClass;
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(deviceSize.width * 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cabin Class',
                                  style: TextStyle(
                                    fontSize: deviceSize.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: deviceSize.width * 0.04,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListTile(
                              title: const Text('Economy'),
                              trailing: cabinClass.cabinClass == 'Economy'
                                  ? const Icon(Icons.check)
                                  : null,
                              onTap: () async {
                                cabinClass = CabinClass(cabinClass: 'Economy');
                                await homeProvider.addCabinClass(cabinClass);
                                Navigator.pop(
                                  context,
                                  homeProvider.fetchCabinClasses(),
                                );
                              },
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text('Business'),
                              trailing: cabinClass.cabinClass == 'Business'
                                  ? const Icon(Icons.check)
                                  : null,
                              onTap: () async {
                                cabinClass = CabinClass(cabinClass: 'Business');
                                await homeProvider.addCabinClass(cabinClass);
                                Navigator.pop(
                                  context,
                                  homeProvider.fetchCabinClasses(),
                                );
                              },
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text('First'),
                              trailing: cabinClass.cabinClass == 'First'
                                  ? const Icon(Icons.check)
                                  : null,
                              onTap: () async {
                                cabinClass = CabinClass(cabinClass: 'First');
                                await homeProvider.addCabinClass(cabinClass);
                                Navigator.pop(
                                  context,
                                  homeProvider.fetchCabinClasses(),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: deviceSize.width * 0.04,
                    bottom: 5,
                  ),
                  width: deviceSize.width * 0.45,
                  child: cabinClassMethod(
                    deviceSize,
                    'Cabin Class',
                    context,
                    cabinClass.cabinClass,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const VerticalDivider(
                thickness: 0.4,
                color: Colors.grey,
                width: 0,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(left: deviceSize.width * 0.04),
                  width: deviceSize.width * 0.45,
                  child: cabinClassMethod(
                      deviceSize, 'Passengers', context, "sub"),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 0.4,
        ),
      ],
    );
  }

  Column cabinClassMethod(
    Size deviceSize,
    String label,
    BuildContext context,
    String subLabel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(label),
        Row(
          children: [
            Text(
              subLabel,
              style: TextStyle(
                fontSize: deviceSize.width * 0.05,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
