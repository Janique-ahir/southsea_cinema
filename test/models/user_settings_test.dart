import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {
  test('UserSettings holds all four cinema profile values', () {
    const settings = UserSettings(
      name: 'Alex Smith',
      email: 'alex@example.com',
      phone: '07000000000',
      receiveNewsletter: true,
    );

    expect(settings.name, 'Alex Smith');
    expect(settings.email, 'alex@example.com');
    expect(settings.phone, '07000000000');
    expect(settings.receiveNewsletter, isTrue);
  });
}
