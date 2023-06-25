import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF243B4A),
      key: _con.key,
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : searchButton(),
        actions: _buildActions(),
      ),
      body: SafeArea(
        child: _con.isCityLoaded ? loadCityInfo() : showEmpty(),
      ),
    );
  }

  Widget loadCityInfo() {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      enablePullUp: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _cityText(),
            _temperatureText(),
            _imageWeather(),
            _descriptionText(),
            SizedBox(height: 20),
            _tempMaxMin(),
            SizedBox(height: 20),
            _sensacionTermica(),
            SizedBox(height: 40),
            _forecastInfo(),
            SizedBox(height: 40),
            _buttonGetCityCoordinates(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget showEmpty() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [_imageEmpty(), _emptyText(),
            SizedBox(height: 40,),
            _buttonGetCityCoordinates()],
        ),
      ),
    );
  }

  Widget _imageWeather() {
    return Image.asset(_con.getImageWeather(_con.mainDescription));
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _cityText() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.location_on,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            _con.cityName,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
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
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }


  Widget _imageEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      child: Image.asset('assets/images/empty.png'),
    );
  }

  Widget _emptyText() {
    return Text(
      "No has seleccionado una ciudad por defecto",
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }

  Widget _buttonGetCityCoordinates() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      onPressed: (){
        _con.getLocationData(false);
        },
      child: Text(
        'Obtener por Coordenadas',
        style: TextStyle(color: Colors.black87),
      ),
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
      onSubmitted: (query) => _searchAndClearQuery(query),
    );
  }

  _searchAndClearQuery(String query) {
    _con.goToSignUpPage(query);
    _clearSearchQuery();
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
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: (){_con.getLocationData(true);},
      ),
    ];
  }

  void _clearSearchQuery() {
    _isSearching = false;
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void updateSearchQuery(String newQuery) {
    searchQuery = newQuery;
    refresh();
  }

  void _stopSearching() {
    _clearSearchQuery();
    _isSearching = false;
    refresh();
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  Widget _sensacionTermica() {
    return Column(
      children: [
        Text(
          _con.termicSensation + '°',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        Text(
          "Sensación térmica",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _tempMaxMin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_tempMin(), _tempMax()],
    );
  }

  Widget _tempMin() {
    return Column(
      children: [
        Text(
          _con.minTemp + '°',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        Text(
          "Temperatura minima",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _tempMax() {
    return Column(
      children: [
        Text(
          _con.maxTemp + '°',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        Text(
          "Temperatura maxima",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _forecastInfo() {
    return Row(
      children: [
        _cardForecast(_con.hour1, _con.descr1, _con.temp1),
        _cardForecast(_con.hour2, _con.descr2, _con.temp2),
        _cardForecast(_con.hour3, _con.descr3, _con.temp3),
      ],
    );
  }

  Widget _cardForecast(String date, String descr, String temperature) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(date),
            SizedBox(height: 20),
            _imageForecast(descr),
            SizedBox(height: 20),
            Text('$temperature°'),
          ],
        ),
      ),
    );
  }

  Widget _imageForecast(String description) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Image.asset(_con.getImageWeather(description)),
    );
  }

  void _onRefresh() async {
    await _con.getLocationData(true);
    refresh();
    _refreshController.refreshCompleted();
  }
}
