class HomeEvent{}

class FetchData extends HomeEvent{
  final bool hasData;
  final bool hasError;

  FetchData({this.hasData = true, this.hasError = false});

  @override
  String toString() {
    return "FetchData {hasData: $hasData, hasError: $hasError}";
  }
}