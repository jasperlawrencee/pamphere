import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salon_repository/salon_repository.dart';

part 'list_salons_event.dart';
part 'list_salons_state.dart';

class ListSalonsBloc extends Bloc<ListSalonsEvent, ListSalonsState> {
  //TDOO: fix list salon
  final SalonRepository _salonRepository;
  final int _renderSalonLimit = 10;

  ListSalonsBloc({required SalonRepository salonRepository})
      : _salonRepository = salonRepository,
        super(ListSalonsInitial()) {
    on<LoadSalons>(_onLoadSalons);
    on<LoadMoreSalons>(_onLoadMoreSalons);
    on<FilteredSalons>(_onFilteredSalons);
    on<SearchSalons>(_onSearchSalons);
  }

  Future<void> _onLoadSalons(
    LoadSalons event,
    Emitter<ListSalonsState> emit,
  ) async {
    emit(ListSalonsLoading());
    try {
      final salons = await _salonRepository.getSalons(limit: _renderSalonLimit);
      emit(ListSalonsSuccess(
        salons: salons,
        hasReachedMax: salons.length < _renderSalonLimit,
      ));
    } catch (e) {
      emit(ListSalonsFailure(message: 'Failed to load salon [$e]'));
    }
  }

  Future<void> _onLoadMoreSalons(
    LoadMoreSalons event,
    Emitter<ListSalonsState> emit,
  ) async {
    if (state is ListSalonsSuccess) {
      final currentState = state as ListSalonsSuccess;

      if (currentState.hasReachedMax) return;

      try {
        final lastSalon = currentState.salons.last;
        final moreSalons = await _salonRepository.getSalons(
          limit: _renderSalonLimit,
          lastSalonId: lastSalon.id,
          isFreelancer: currentState.isFiltered
              ? (currentState.salons.isNotEmpty
                  ? currentState.salons.first.isFreelancer
                  : null)
              : null,
        );

        if (moreSalons.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(ListSalonsSuccess(
            salons: [...currentState.salons, ...moreSalons],
            hasReachedMax: moreSalons.length < _renderSalonLimit,
            isFiltered: currentState.isFiltered,
          ));
        }
      } catch (e) {
        emit(ListSalonsFailure(message: 'Failed to load more salons [$e]'));
      }
    }
  }

  Future<void> _onFilteredSalons(
    FilteredSalons event,
    Emitter<ListSalonsState> emit,
  ) async {
    emit(ListSalonsLoading());
    try {
      final filteredSalons = await _salonRepository.getSalons(
        limit: _renderSalonLimit,
        isFreelancer: event.isFreelancer,
        services: event.services,
        minRating: event.minRating,
      );
      emit(ListSalonsSuccess(
        salons: filteredSalons,
        hasReachedMax: filteredSalons.length < _renderSalonLimit,
        isFiltered: true,
      ));
    } catch (e) {
      emit(ListSalonsFailure(message: 'Failed to filter salons [$e]'));
    }
  }

  Future<void> _onSearchSalons(
    SearchSalons event,
    Emitter<ListSalonsState> emit,
  ) async {
    emit(ListSalonsLoading());
    try {
      final searchResults = await _salonRepository.searchSalons(event.query);
      emit(ListSalonsSuccess(
        salons: searchResults,
        hasReachedMax: searchResults.length < _renderSalonLimit,
        // search results don't need to be filtered
        isFiltered: true,
      ));
    } catch (e) {
      ListSalonsFailure(message: 'Failed to search salons [$e]');
    }
  }
}
