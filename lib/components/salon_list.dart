import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphere/blocs/list_salons/list_salons_bloc.dart';
import 'package:pamphere/components/salon_card.dart';
import 'package:pamphere/pages/salon.dart';

class SalonList extends StatefulWidget {
  final String filter;
  final String searchQuery;

  const SalonList({
    super.key,
    this.filter = 'All',
    this.searchQuery = '',
  });

  @override
  State<SalonList> createState() => _SalonListState();
}

class _SalonListState extends State<SalonList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListSalonsBloc, ListSalonsState>(
      builder: (context, state) {
        if (state is ListSalonsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ListSalonsSuccess) {
          // Filter salons based on the selected filter and search query
          final filteredSalons = state.salons.where((salon) {
            // First apply category filter
            bool passesFilter = true;
            if (widget.filter == 'Salons') {
              passesFilter = !salon.isFreelancer;
            } else if (widget.filter == 'Freelancers') {
              passesFilter = salon.isFreelancer;
            }

            // Then apply search query if it exists
            if (widget.searchQuery.isEmpty) {
              return passesFilter;
            }

            // Search in salon name
            final nameMatch = salon.name.toLowerCase().contains(
                  widget.searchQuery.toLowerCase(),
                );

            // Search in salon services
            final servicesMatch = salon.services.any((service) => service
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()));

            // Return true if salon passes filter AND matches search query
            return passesFilter && (nameMatch || servicesMatch);
          }).toList();

          // If no results found
          if (filteredSalons.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Try a different search term or filter',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: widget.searchQuery.isEmpty && filteredSalons.isNotEmpty
                ? (state.hasReachedMax
                    ? filteredSalons.length
                    : filteredSalons.length + 1)
                : filteredSalons.length,
            itemBuilder: (context, index) {
              if (index >= filteredSalons.length) {
                context.read<ListSalonsBloc>().add(LoadMoreSalons());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final salon = filteredSalons[index];
              return SalonCard(
                salon: salon,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalonDetailPage(salon: salon),
                      ));
                },
              );
            },
          );
        } else if (state is ListSalonsFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }
}
