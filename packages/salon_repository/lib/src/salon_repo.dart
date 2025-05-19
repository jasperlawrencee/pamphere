import 'package:salon_repository/salon_repository.dart';

abstract class SalonRepository {
  Future<List<Salon>> getSalons({
    int? limit,
    String? lastSalonId,
    bool? isFreelancer,
    List<String>? services,
    double? minRating,
  });

  Future<List<Salon>> getFreelancers();

  Future<Salon> getSalonById(String salonId);

  Future<void> setSalonData(Salon salon);

  Future<String> uploadSalonPicture(String file, String salonId);

  Future<List<Salon>> searchSalons(String query);

  Stream<List<Salon>> getSalonsStream();

  Stream<List<Salon>> getFreelancersStream();
}
