import 'package:flutter/material.dart';
import 'package:setarch/home_model.dart';
import 'package:setarch/home_state.dart';
import 'package:setarch/home_event.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final model = HomeModel();

  @override
  void initState() {
    model.dispatch(FetchData(hasData: true, hasError: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          model.dispatch(FetchData());
        }),
        backgroundColor: Colors.grey[800],
        body: StreamBuilder(
          stream: model.homeState,
          builder: (buildContext, snapshot) {
            if (snapshot.hasError) {
              return _getCenterMessage(snapshot.error);
            }

            var homeState = snapshot.data;

            if (!snapshot.hasData || homeState is BusyHomeState) {
              return Center(child: CircularProgressIndicator());
            }

            if (homeState is DataFetchedHomeState) {
              if (!homeState.hasData) {
                return _getCenterMessage(
                    "No data found on your account. Add something and check back.");
              }
            }

            return ListView.builder(
              itemCount: homeState.data.length,
              itemBuilder: (context, index) =>
                  _getListItemUi(index, homeState.data),
            );
          },
        ));
  }

  Widget _getListItemUi(int index, List<String> listItems) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[500],
      ),
      child: Center(
        child: Text(
          listItems[index],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _getCenterMessage(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[500]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
