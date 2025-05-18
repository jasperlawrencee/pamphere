part of 'list_salons_bloc.dart';

sealed class ListSalonsState extends Equatable {
  const ListSalonsState();

  @override
  List<Object> get props => [];
}

final class ListSalonsInitial extends ListSalonsState {}

final class ListSalonsLoading extends ListSalonsState {}

final class ListSalonsSuccess extends ListSalonsState {
  final List<Salon> salons;
  final List<Salon> filteredSalons;
  final List<Salon> searchedSalons;

  const ListSalonsSuccess({
    required this.salons,
    required this.filteredSalons,
    required this.searchedSalons,
  });
}

final class ListSalonsFailure extends ListSalonsState {
  final String message;
  const ListSalonsFailure({required this.message});
}
