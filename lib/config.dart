/// ============================================================
/// CONFIG — Business constants for DoorStep Fix GTA
/// ============================================================
///
/// Booking system (owner decision, Nov 22, 2026): ONLINE FORM ->
/// WHATSAPP ONLY. There is no third-party booking platform.
///
/// [whatsAppNumber] / [whatsAppDisplayNumber]
///    Owner-provided WhatsApp number (Canada, +1), set Nov 22, 2026.
///    Link format used by the app: https://wa.me/16476840588
///    The Book form opens that link with the booking summary prefilled.
library;

const String whatsAppNumber = '16476840588';
const String whatsAppDisplayNumber = '647-684-0588';
const String whatsAppLink = 'https://wa.me/16476840588';

const String businessName = 'DoorStep Fix GTA';
const String businessTagline =
    'iPhone & Samsung Repair At Your Home — Fixed in 30-45 mins';
const String trustLine =
    'Former TELUS Mobile Klinik technician, 2 years professional repairs';

const List<String> serviceCities = <String>[
  'Pickering',
  'Ajax',
  'Whitby',
  'Scarborough',
  'Markham',
  'Richmond Hill',
  'North York',
  'Toronto',
];

const List<String> bookingSlots = <String>[
  '11:00 AM',
  '1:00 PM',
  '3:00 PM',
];

const int homeVisitFee = 25;
const int visitFeeWaivedAt = 120;
