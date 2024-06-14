import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/data_service.dart';
import 'package:urgentrishtapp/models/user_model.dart';
import 'package:urgentrishtapp/providers/providers.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DbDataService dbDataService = DbDataService();
  final TextEditingController _searchController = TextEditingController();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    /// internet connectivity check.................
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
                surfaceTintColor: Colors.white,
                child: InternetConnectivityDialog());
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    Provider.of<SearchProvider>(context, listen: false).searchText =
        _searchController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          TextConstants.homeHeading,
          style: TextStyle(
            fontSize: FontConstants.xxlarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.chatMainScreen);
              // Navigator.of(context).pushNamed(AppRoutes.messages);
            },
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              TextConstants.discover,
              style: TextStyle(
                fontSize: FontConstants.xxlarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  TextConstants.matchDeatil,
                  style: TextStyle(
                    fontSize: FontConstants.medium,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const BottomSheetWidget(),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConstants.pink,
                      border: Border.all(color: Colors.black, width: 0.3),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(
                        TextConstants.filter,
                        style: TextStyle(
                          fontSize: FontConstants.medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              controller: _searchController,
              hintText: TextConstants.search,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 0.3),
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              obscureText: false,
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  _searchController.clear();

                  Provider.of<FilterProvider>(context, listen: false)
                      .resetFilters();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstants.pink,
                    border: Border.all(color: Colors.black, width: 0.3),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontSize: FontConstants.exsmall,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: StreamBuilder<List<UserData>>(
                stream: dbDataService.streamAllUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No user data found'));
                  } else {
                    final searchText = Provider.of<SearchProvider>(context)
                        .searchText
                        .toLowerCase();
                    List<UserData> userDataList = snapshot.data!;
                    List<UserData> filteredData = searchText.isEmpty
                        ? userDataList
                        : userDataList
                            .where((userData) => userData.name
                                .toLowerCase()
                                .contains(searchText))
                            .toList();

                    // Apply filter
                    final filterProvider = Provider.of<FilterProvider>(context);
                    if (filterProvider.gender != null) {
                      filteredData = filteredData
                          .where((userData) =>
                              userData.gender == filterProvider.gender)
                          .toList();
                    }
                    if (filterProvider.age != null) {
                      filteredData = filteredData
                          .where(
                              (userData) => userData.age == filterProvider.age)
                          .toList();
                    }
                    if (filterProvider.cast != null) {
                      filteredData = filteredData
                          .where((userData) =>
                              userData.cast == filterProvider.cast)
                          .toList();
                    }
                    if (filterProvider.sect != null) {
                      filteredData = filteredData
                          .where((userData) =>
                              userData.sect == filterProvider.sect)
                          .toList();
                    }
                    if (filterProvider.city != null) {
                      filteredData = filteredData
                          .where((userData) =>
                              userData.city == filterProvider.city)
                          .toList();
                    }
                    if (filterProvider.qualification != null) {
                      filteredData = filteredData
                          .where((userData) =>
                              userData.qualification ==
                              filterProvider.qualification)
                          .toList();
                    }

                    if (filteredData.isEmpty) {
                      return const Center(child: Text('No results found'));
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          UserData userData = filteredData[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.profileDetails,
                                arguments: userData,
                              );
                            },
                            child: GridItem(
                              imagePath: userData.imageUrl,
                              name: userData.name,
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;
  final String name;

  const GridItem({Key? key, required this.imagePath, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
