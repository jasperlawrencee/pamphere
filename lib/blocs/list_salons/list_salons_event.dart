part of 'list_salons_bloc.dart';

abstract class ListSalonsEvent extends Equatable {
  const ListSalonsEvent();

  @override
  List<Object> get props => [];
}

class LoadSalons extends ListSalonsEvent {}

class LoadMoreSalons extends ListSalonsEvent {}

class FilteredSalons extends ListSalonsEvent {
  // Created class properties for filtering all service providers by
  // isFreelancer, services and minRating
  final bool? isFreelancer;
  final List<String>? services;
  final double? minRating;

  const FilteredSalons({
    this.isFreelancer,
    this.services,
    this.minRating,
  });

  @override
  List<Object> get props => [
        isFreelancer ?? false,
        services ?? [],
        minRating ?? 0.0,
      ];
}

class SearchSalons extends ListSalonsEvent {
  final String query;

  const SearchSalons(this.query);

  @override
  List<Object> get props => [query];
}
