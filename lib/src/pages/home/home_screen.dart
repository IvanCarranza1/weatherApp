import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> with TickerProviderStateMixin {
  final HomeController _con = HomeController();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    _con.getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: _con.colorBackground,
      key: _con.key,
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : searchButton(),
        actions: _buildActions(),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
              color: _con.colorBackground,
              child: _con.isCityLoaded
                  ? loadCityInfo()
                  : showEmpty()),
        ),
      ),
    );
  }

  Widget loadCityInfo() {
    return Column(
      children: [
        _cityText(),
        _temperatureText(),
        _imageWeather(),
        _descriptionText(),
        _dateText(),
      ],
    );
  }

  Widget showEmpty() {
    return Column(
      children: [
        _imageEmpty()
      ],
    );
  }

  Widget _imageWeather() {
    return Container(
      child: Image.asset(_con.getImageWeather()),
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _cityText() {
    return Text(
      _con.cityName,
      style: const TextStyle(
        fontSize: 25,
        color: Colors.white,
      ),
    );
  }

  Widget _temperatureText() {
    return Text(
      _con.temperature.toString() + "°",
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 45,
        color: Colors.white,
      ),
    );
  }

  Widget _descriptionText() {
    return Text(
      _con.description,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 25,
        color: Colors.white,
      ),
    );
  }

  Widget _dateText() {
    return Text(
      _con.getCurrentDate(),
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }

  Widget _imageEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Image.asset('assets/images/empty.png'),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Ingresa tu busqueda",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onSubmitted: (query) => _clearSearchQuery(query),
    );
  }

  Widget searchButton() {
    return Text(
     "",
      textAlign: TextAlign.center,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery("");
          },
        ),
      ];
    }
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _clearSearchQuery(String query) {
    _con.goToSignUpPage(query);
    _isSearching=false;
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery("");
    setState(() {
      _isSearching = false;
    });
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

}
