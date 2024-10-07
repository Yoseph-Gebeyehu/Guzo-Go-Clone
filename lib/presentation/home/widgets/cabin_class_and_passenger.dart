import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/cabin_class.dart';
import 'package:guzo_go_clone/data/model/passengers.dart';
import 'package:guzo_go_clone/presentation/home/provivder/home_provider.dart';

// ignore: must_be_immutable
class CabinClassAndPassenger extends StatefulWidget {
  CabinClassAndPassenger({
    super.key,
    required this.cabinClass,
    required this.homeProvider,
  });

  CabinClass cabinClass;

  final HomeProvider homeProvider;

  @override
  State<CabinClassAndPassenger> createState() => _CabinClassAndPassengerState();
}

class _CabinClassAndPassengerState extends State<CabinClassAndPassenger> {
  // Passenger counts
  int adultCount = 1;
  int childrenCount = 0;
  int infantCount = 0;

  // Increment/Decrement methods
  void incrementAdult() {
    setState(() {
      if (adultCount < 9) adultCount++;
    });
  }

  void decrementAdult() {
    setState(() {
      if (adultCount > 1) adultCount--;
    });
  }

  void incrementChildren() {
    setState(() {
      if (childrenCount < 5) childrenCount++;
    });
  }

  void decrementChildren() {
    setState(() {
      if (childrenCount > 0) childrenCount--;
    });
  }

  void incrementInfant() {
    setState(() {
      if (infantCount < 5) infantCount++;
    });
  }

  void decrementInfant() {
    setState(() {
      if (infantCount > 0) infantCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              InkWell(
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
                              trailing:
                                  widget.cabinClass.cabinClass == 'Economy'
                                      ? const Icon(Icons.check)
                                      : null,
                              onTap: () async {
                                widget.cabinClass =
                                    CabinClass(cabinClass: 'Economy');
                                await widget.homeProvider
                                    .addCabinClass(widget.cabinClass);
                                Navigator.pop(context,
                                    widget.homeProvider.fetchCabinClasses());
                              },
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text('Business'),
                              trailing:
                                  widget.cabinClass.cabinClass == 'Business'
                                      ? const Icon(Icons.check)
                                      : null,
                              onTap: () async {
                                widget.cabinClass =
                                    CabinClass(cabinClass: 'Business');
                                await widget.homeProvider
                                    .addCabinClass(widget.cabinClass);
                                Navigator.pop(context,
                                    widget.homeProvider.fetchCabinClasses());
                              },
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text('First'),
                              trailing: widget.cabinClass.cabinClass == 'First'
                                  ? const Icon(Icons.check)
                                  : null,
                              onTap: () async {
                                widget.cabinClass =
                                    CabinClass(cabinClass: 'First');
                                await widget.homeProvider
                                    .addCabinClass(widget.cabinClass);
                                Navigator.pop(context,
                                    widget.homeProvider.fetchCabinClasses());
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
                    Text(
                      widget.cabinClass.cabinClass,
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.05,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const VerticalDivider(
                thickness: 0.4,
                color: Colors.grey,
                width: 0,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setModalState) {
                          return Container(
                            padding: EdgeInsets.all(deviceSize.width * 0.05),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Passengers',
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: deviceSize.width * 0.04,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Passengers passenger = Passengers(
                                              adult: adultCount.toString(),
                                              children:
                                                  childrenCount.toString(),
                                              infant: infantCount.toString(),
                                            );
                                            await widget.homeProvider
                                                .addOrUpdatePassenger(
                                              passenger,
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Done',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: deviceSize.width * 0.04,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ListTile(
                                  title: const Text('Adult'),
                                  trailing: buildPassengerCountControl(
                                    deviceSize,
                                    adultCount,
                                    () {
                                      setState(() => decrementAdult());
                                      setModalState(() => setState(() {}));
                                    },
                                    () {
                                      setState(() => incrementAdult());
                                      setModalState(() => setState(() {}));
                                    },
                                    context,
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Children ',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '2-12 Years',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 53, 51, 51),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: buildPassengerCountControl(
                                    deviceSize,
                                    childrenCount,
                                    () {
                                      setState(() => decrementChildren());
                                      setModalState(() => setState(() {}));
                                    },
                                    () {
                                      setState(() => incrementChildren());
                                      setModalState(() => setState(() {}));
                                    },
                                    context,
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Infant ',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '< 2 Years',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 53, 51, 51),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: buildPassengerCountControl(
                                    deviceSize,
                                    infantCount,
                                    () {
                                      setState(() => decrementInfant());
                                      setModalState(() => setState(() {}));
                                    },
                                    () {
                                      setState(() => incrementInfant());
                                      setModalState(() => setState(() {}));
                                    },
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: deviceSize.width * 0.04),
                  width: deviceSize.width * 0.45,
                  child: cabinClassMethod(
                    deviceSize,
                    'Passengers',
                    context,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildPassengerIcon(deviceSize, adultCount),
                        buildPassengerIcon(deviceSize, childrenCount),
                        buildPassengerIcon(deviceSize, infantCount),
                      ],
                    ),
                  ),
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

  Widget buildPassengerCountControl(
    Size deviceSize,
    int count,
    Function decrement,
    Function increment,
    BuildContext context,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => decrement(),
          icon: Icon(
            Icons.remove_circle_outline,
            color: Theme.of(context).primaryColor,
            size: 21,
          ),
        ),
        Text(
          '$count',
          style: TextStyle(
            fontSize: deviceSize.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => increment(),
          icon: Icon(
            Icons.add_circle_outline,
            color: Theme.of(context).primaryColor,
            size: 21,
          ),
        ),
      ],
    );
  }

  Widget buildPassengerIcon(Size deviceSize, int count) {
    return Row(
      children: [
        const Icon(Icons.accessibility_new, size: 20),
        Text(
          '$count',
          style: TextStyle(
            fontSize: deviceSize.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Column cabinClassMethod(
    Size deviceSize,
    String label,
    BuildContext context,
    Widget subLabel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(label),
        subLabel,
      ],
    );
  }
}
