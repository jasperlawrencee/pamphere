import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphere/blocs/list_salons/list_salons_bloc.dart';
import 'package:pamphere/components/salon_card.dart';
import 'package:pamphere/pages/salon.dart';

class SalonList extends StatefulWidget {
  const SalonList({super.key});

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
          return ListView.builder(
            itemCount: state.hasReachedMax
                ? state.salons.length
                : state.salons.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.salons.length) {
                context.read<ListSalonsBloc>().add(LoadMoreSalons());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final salon = state.salons[index];
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
