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
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFB5B5B5)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              SizedBox(
                height: 210,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1D1D1D),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F7F9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'fotoku.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person_2_outlined,
                              color: Color(0xFF3D86EA),
                              size: 56,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const _ProfileInfoRow(
                icon: Icons.person_outline,
                text: 'Muhammad Iqbal Alghozi',
              ),
              const _ProfileInfoRow(
                icon: Icons.badge_outlined,
                text: '1462300096',
              ),
              const _ProfileInfoRow(
                icon: Icons.email_outlined,
                text: 'ikbalalghozi@gmail.com',
              ),
              const _ProfileInfoRow(
                icon: Icons.location_on_outlined,
                text: 'Sidoarjo',
              ),
              const _ProfileInfoRow(
                icon: Icons.camera_alt_outlined,
                text: '@Alghoz.ii',
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFBEBEBE)),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF3496E8), size: 26),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF242424),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
