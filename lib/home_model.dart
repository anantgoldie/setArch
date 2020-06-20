import 'dart:async';
import 'dart:math';
import 'home_state.dart';
import 'home_event.dart';

class HomeModel {
  final StreamController<HomeState> _streamController =
      StreamController<HomeState>();

  List<String> _listItems;

  Stream<HomeState> get homeState => _streamController.stream;

  void dispatch(HomeEvent event){
    print("Event dispatched : $event" );
    if(event is FetchData){
      _getListData(hasData: event.hasData, hasError: event.hasError);
    }
  }

  Future _getListData({bool hasData = true, bool hasError = false}) async {
    _streamController.add(BusyHomeState());
    await Future.delayed(Duration(seconds: 2));

    if (hasError) {
      return _streamController
          .addError("An error has occurred. Please try again.");
    }

    if (!hasData) {
      return _streamController.add(DataFetchedHomeState(data: List<String>()));
    }
    var rng = new Random();
    _listItems =
        List<String>.generate(rng.nextInt(10), (index) => '$index title');
    _streamController.add(DataFetchedHomeState(data : _listItems));
  }
}
