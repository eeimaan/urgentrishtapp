import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class CityDialogWidget extends StatefulWidget {
  final Function(String) onCitySelected;
  const CityDialogWidget({required this.onCitySelected, super.key});

  @override
  CityDialogWidgetState createState() => CityDialogWidgetState();
}

class CityDialogWidgetState extends State<CityDialogWidget> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredCities = List.from(TextConstants.pakistanCitiesList);

  void _filterCities(String query) {
    setState(() {
      filteredCities = TextConstants.pakistanCitiesList
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      _filterCities(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 350,
        width: 350,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              TextFieldWidget(
                hintText: TextConstants.search,
                obscureText: false,
                controller: searchController,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 0.3),
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredCities[index]),
                      onTap: () {
                        widget.onCitySelected(filteredCities[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CastDialogWidget extends StatefulWidget {
  final Function(String) onSelected;
  const CastDialogWidget({required this.onSelected, super.key});

  @override
  CastDialogWidgetState createState() => CastDialogWidgetState();
}

class CastDialogWidgetState extends State<CastDialogWidget> {
  TextEditingController searchController = TextEditingController();
  List<String> filtered = List.from(TextConstants.casteList);

  void _filterCities(String query) {
    setState(() {
      filtered = TextConstants.casteList
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      _filterCities(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 350,
        width: 350,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              TextFieldWidget(
                hintText: TextConstants.search,
                obscureText: false,
                controller: searchController,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 0.3),
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filtered[index]),
                      onTap: () {
                        widget.onSelected(filtered[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InternetConnectivityDialog extends StatelessWidget {
  InternetConnectivityDialog({super.key});

  final Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return PopScope(
      canPop: false,
      child: Container(
        height: 200,
        width: mediaQuery.size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Failed to connect to internet',
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:ButtonWidget(
               text: 'Try again',
                onPressed: () {
                  connectivity.checkConnectivity().then((result) {
                    if (result == ConnectivityResult.none) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No internet connection.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  });
                }, width:140, btnColor: ColorConstants.orange, textColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
