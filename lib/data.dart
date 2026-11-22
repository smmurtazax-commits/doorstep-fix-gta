/// Price list — matches the appointment website.
/// All prices CAD, include part + labour unless noted.
library;

class RepairService {
  const RepairService({
    required this.name,
    required this.price,
    required this.durationMins,
    this.note,
  });

  final String name;
  final int price;
  final int durationMins;
  final String? note;

  String get label => '$name — \$$price';
}

const List<RepairService> iphoneServices = <RepairService>[
  RepairService(name: 'iPhone Battery — X / XR / XS', price: 95, durationMins: 45),
  RepairService(name: 'iPhone Battery — 11 / 12 / 13', price: 110, durationMins: 45),
  RepairService(name: 'iPhone Battery — 14', price: 125, durationMins: 45),
  RepairService(name: 'iPhone Screen — XR / 11', price: 149, durationMins: 60),
  RepairService(name: 'iPhone Screen — 12 / 13', price: 169, durationMins: 60),
  RepairService(name: 'iPhone Screen — 14', price: 199, durationMins: 60),
  RepairService(name: 'Charging Port Clean (iPhone)', price: 49, durationMins: 30),
  RepairService(name: 'Charging Port Replacement (iPhone)', price: 110, durationMins: 60),
  RepairService(
    name: 'Diagnostic At Home',
    price: 40,
    durationMins: 30,
    note: 'Free if you do the repair with us',
  ),
];

const List<RepairService> samsungServices = <RepairService>[
  RepairService(
    name: 'Samsung Screen — S20, S21, S22, S21 FE, S20 FE',
    price: 229,
    durationMins: 60,
    note: 'Deposit first — part ordered for your model',
  ),
  RepairService(
    name: 'Samsung Screen — S23, S24, S21+, S22+, S23 FE',
    price: 269,
    durationMins: 60,
    note: 'Deposit first — part ordered for your model',
  ),
  RepairService(
    name: 'Samsung Screen — S23+, S24+, S25, S21 Ultra, S22 Ultra',
    price: 319,
    durationMins: 60,
    note: 'Deposit first — part ordered for your model',
  ),
  RepairService(
    name: 'Samsung Screen — S23 Ultra, S24 Ultra, S25 Ultra',
    price: 369,
    durationMins: 60,
    note: 'Deposit first — part ordered for your model',
  ),
  RepairService(name: 'Samsung Battery — All Galaxy S', price: 109, durationMins: 45),
  RepairService(name: 'Samsung Charging Port Replacement', price: 109, durationMins: 60),
  RepairService(name: 'Samsung Charging Port Clean', price: 49, durationMins: 30),
];

const List<RepairService> allServices = <RepairService>[
  ...iphoneServices,
  ...samsungServices,
];
