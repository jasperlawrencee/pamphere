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
  final bool hasReachedMax;
  final bool isFiltered;

  const ListSalonsSuccess({
    required this.salons,
    this.hasReachedMax = false,
    this.isFiltered = false,
  });

  ListSalonsSuccess copyWith({
    List<Salon>? salons,
    bool? hasReachedMax,
    bool? isFiltered,
  }) {
    return ListSalonsSuccess(
      salons: salons ?? this.salons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }

  @override
  List<Object> get props => [salons, hasReachedMax, isFiltered];
}

final class ListSalonsFailure extends ListSalonsState {
  final String message;

  const ListSalonsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
