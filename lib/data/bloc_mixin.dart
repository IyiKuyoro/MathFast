import 'package:bloc/bloc.dart';

/// BlockMixin provides four methods; [onEvent] [onChange] [onTransition]
/// [onError] that aid working with blocs in this app
mixin BlocMixin<S, T> on Bloc<S, T> {
  /// Log change event
  @override
  void onEvent(S event) {
    super.onEvent(event);
  }

  /// Hookup change
  @override
  void onChange(Change<T> change) {
    super.onChange(change);
  }

  /// similar to [onChange], however, it contains the event which triggered
  /// the state change in addition to the currentState and nextState
  @override
  void onTransition(Transition<S, T> transition) {
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
