import 'Results.dart';
import 'actions.dart';

List<Result> resultsReducers(List<Result> results, dynamic action) {
  if (action is AddResultAction) {
    return addItem(results, action);
  }

  return results;
}

List<Result> addItem(List<Result> results, AddResultAction action) {
  return List.from(results)..add(action.result);
}
