import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salon_repository/salon_repository.dart';

part 'list_salons_event.dart';
part 'list_salons_state.dart';

class ListSalonsBloc extends Bloc<ListSalonsEvent, ListSalonsState> {
  ListSalonsBloc() : super(ListSalonsInitial()) {
    on<ListSalonsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
