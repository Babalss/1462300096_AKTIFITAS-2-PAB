import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Halaman awal menampilkan daftar kategori dokter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('HealthHub'), findsOneWidget);
    expect(find.text('Dokter Umum'), findsOneWidget);
    expect(find.text('Dokter Gigi'), findsOneWidget);
    expect(find.text('Dokter Anak'), findsOneWidget);
    expect(find.text('Dokter Hewan'), findsOneWidget);
  });
}
