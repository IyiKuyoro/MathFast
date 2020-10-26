import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp/store/Results.dart';

class ResultsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<List<Result>, List<Result>>(
      builder: (context, list) {
        return new ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, position) =>
                new ResultListItem(list[position]));
      },
      converter: (store) {
        print(store.state);
        return store.state;
      },
    );
  }
}

class ResultListItem extends StatelessWidget {
  final Result result;

  ResultListItem(this.result);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Text(result.time.timeZoneName),
      leading: new Text(result.percentage.toString()),
    );
  }
}
