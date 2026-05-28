import 'package:flutter/material.dart';

void main() {
  runApp(const DoctorBookingApp());
}

class DoctorCategory {
  const DoctorCategory({
    required this.categoryName,
    required this.icon,
    required this.doctorName,
    required this.specialization,
    required this.schedule,
    required this.rating,
  });

  final String categoryName;
  final IconData icon;
  final String doctorName;
  final String specialization;
  final String schedule;
  final double rating;
}

const List<DoctorCategory> doctorCategories = [
  DoctorCategory(
    categoryName: 'Dokter Umum',
    icon: Icons.local_hospital,
    doctorName: 'dr. Amanda Putri',
    specialization: 'Dokter Umum',
    schedule: 'Senin - Jumat, 08.00 - 15.00',
    rating: 4.8,
  ),
  DoctorCategory(
    categoryName: 'Dokter Gigi',
    icon: Icons.medical_services,
    doctorName: 'drg. Bima Saputra',
    specialization: 'Dokter Gigi',
    schedule: 'Senin - Sabtu, 09.00 - 16.00',
    rating: 4.7,
  ),
  DoctorCategory(
    categoryName: 'Dokter Anak',
    icon: Icons.child_care,
    doctorName: 'dr. Ahmad Hidayat',
    specialization: 'Dokter Anak',
    schedule: 'Senin - Jumat, 09.00 - 17.00',
    rating: 4.6,
  ),
  DoctorCategory(
    categoryName: 'Dokter Kulit',
    icon: Icons.spa,
    doctorName: 'dr. Sinta Ramadhani',
    specialization: 'Dokter Kulit',
    schedule: 'Selasa - Sabtu, 10.00 - 18.00',
    rating: 4.8,
  ),
  DoctorCategory(
    categoryName: 'Dokter Jantung',
    icon: Icons.favorite,
    doctorName: 'dr. Raka Pranata',
    specialization: 'Dokter Jantung',
    schedule: 'Senin - Kamis, 08.00 - 14.00',
    rating: 4.9,
  ),
  DoctorCategory(
    categoryName: 'Dokter Hewan',
    icon: Icons.pets,
    doctorName: 'drh. Citra Maharani',
    specialization: 'Dokter Hewan',
    schedule: 'Senin - Minggu, 10.00 - 18.00',
    rating: 4.5,
  ),
];

class DoctorBookingApp extends StatelessWidget {
  const DoctorBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Dokter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF233252)),
        useMaterial3: true,
      ),
      home: const DoctorBookingLayout(),
    );
  }
}

class DoctorBookingLayout extends StatefulWidget {
  const DoctorBookingLayout({super.key});

  @override
  State<DoctorBookingLayout> createState() => _DoctorBookingLayoutState();
}

class _DoctorBookingLayoutState extends State<DoctorBookingLayout> {
  int _selectedIndex = 0;
  int _selectedDoctorIndex = 0;

  void _openBookingFromGrid(int index) {
    setState(() {
      _selectedDoctorIndex = index;
      _selectedIndex = 1;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctor = doctorCategories[_selectedDoctorIndex];

    final tabs = <Widget>[
      _HomeScreen(doctors: doctorCategories, onDoctorTap: _openBookingFromGrid),
      _BookingScreen(
        selectedDoctor: doctor,
        onBookPressed: () {
          showDialog<void>(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text('Booking Berhasil'),
                content: Text(
                  'Janji konsultasi dengan ${doctor.doctorName} sudah dibuat.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Tutup'),
                  ),
                ],
              );
            },
          );
        },
      ),
      const _ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1F2C45),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withValues(alpha: 0.85),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({required this.doctors, required this.onDoctorTap});

  final List<DoctorCategory> doctors;
  final ValueChanged<int> onDoctorTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text(
              'BOOKING DOKTER',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1C1C1C),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GridView.builder(
                  itemCount: doctors.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return InkWell(
                      onTap: () => onDoctorTap(index),
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 92,
                            height: 92,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD2D3D6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              doctor.icon,
                              size: 36,
                              color: const Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            doctor.categoryName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingScreen extends StatelessWidget {
  const _BookingScreen({
    required this.selectedDoctor,
    required this.onBookPressed,
  });

  final DoctorCategory selectedDoctor;
  final VoidCallback onBookPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const Text(
              'BOOKING DOKTER',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF161616),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFD2D3D6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    selectedDoctor.icon,
                    size: 52,
                    color: const Color(0xFF293343),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedDoctor.doctorName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E2531),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedDoctor.specialization,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF3C465A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedDoctor.schedule,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A556B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFC84A)),
                      const SizedBox(width: 4),
                      Text(
                        selectedDoctor.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2D45),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onBookPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD2D3D6),
                  foregroundColor: const Color(0xFF101010),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                ),
                child: const Text(
                  'Booking',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'FOTO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF161616),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                color: const Color(0xFFD2D3D6),
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=600&q=80',
                        height: 220,
                        width: 220,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const SizedBox(
                            height: 220,
                            width: 220,
                            child: ColoredBox(
                              color: Color(0xFFC0C2C8),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 220,
                            width: 220,
                            color: const Color(0xFFC0C2C8),
                            child: const Icon(
                              Icons.person,
                              size: 90,
                              color: Color(0xFF4B556C),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Profile Pasien',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D3646),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
