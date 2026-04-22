import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ===============================
  // 🔍 FETCH AVAILABLE VENUES
  // ===============================
  Future<List<Map<String, dynamic>>> getAvailableVenues({
    required String location,
    required int guests,
  }) async {
    try {
      final response = await supabase
          .from('venues')
          .select()
          .ilike('location', '%$location%') // 🔥 FIX HERE
          .gte('capacity', guests)
          .eq('available', true);

      print("✅ Venues fetched: $response");

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("❌ Error fetching venues: $e");
      return [];
    }
  }

  // ===============================
  // 📝 INSERT BOOKING (later use)
  // ===============================
  Future<void> insertBooking({
    required String location,
    required String date,
    required int guests,
  }) async {
    try {
      await supabase.from('bookings').insert({
        'location': location,
        'event_date': date,
        'guests': guests,
      });

      print("✅ Booking inserted");
    } catch (e) {
      print("❌ Error inserting booking: $e");
    }
  }
}