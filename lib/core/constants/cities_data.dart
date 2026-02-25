class CityModel {
  final String nameAr;
  final String nameEn;
  final String country;
  final double latitude;
  final double longitude;

  const CityModel({
    required this.nameAr,
    required this.nameEn,
    required this.country,
    required this.latitude,
    required this.longitude,
  });
}

class CitiesData {
  static const List<CityModel> cities = [
    // سوريا
    CityModel(nameAr: 'دمشق',       nameEn: 'Damascus',       country: 'سوريا',        latitude: 33.5138,  longitude: 36.2765),
    CityModel(nameAr: 'حلب',        nameEn: 'Aleppo',         country: 'سوريا',        latitude: 36.2021,  longitude: 37.1343),
    CityModel(nameAr: 'حمص',        nameEn: 'Homs',           country: 'سوريا',        latitude: 34.7324,  longitude: 36.7137),
    CityModel(nameAr: 'حماة',       nameEn: 'Hama',           country: 'سوريا',        latitude: 35.1318,  longitude: 36.7580),
    CityModel(nameAr: 'اللاذقية',   nameEn: 'Latakia',        country: 'سوريا',        latitude: 35.5317,  longitude: 35.7915),
    CityModel(nameAr: 'دير الزور',  nameEn: 'Deir ez-Zor',   country: 'سوريا',        latitude: 35.3360,  longitude: 40.1400),

    // السعودية
    CityModel(nameAr: 'مكة المكرمة', nameEn: 'Mecca',         country: 'السعودية',     latitude: 21.3891,  longitude: 39.8579),
    CityModel(nameAr: 'المدينة المنورة', nameEn: 'Medina',    country: 'السعودية',     latitude: 24.5247,  longitude: 39.5692),
    CityModel(nameAr: 'الرياض',     nameEn: 'Riyadh',         country: 'السعودية',     latitude: 24.7136,  longitude: 46.6753),
    CityModel(nameAr: 'جدة',        nameEn: 'Jeddah',         country: 'السعودية',     latitude: 21.4858,  longitude: 39.1925),

    // مصر
    CityModel(nameAr: 'القاهرة',    nameEn: 'Cairo',          country: 'مصر',          latitude: 30.0444,  longitude: 31.2357),
    CityModel(nameAr: 'الإسكندرية', nameEn: 'Alexandria',     country: 'مصر',          latitude: 31.2001,  longitude: 29.9187),
    CityModel(nameAr: 'الجيزة',     nameEn: 'Giza',           country: 'مصر',          latitude: 30.0131,  longitude: 31.2089),

    // الإمارات
    CityModel(nameAr: 'دبي',        nameEn: 'Dubai',          country: 'الإمارات',     latitude: 25.2048,  longitude: 55.2708),
    CityModel(nameAr: 'أبوظبي',     nameEn: 'Abu Dhabi',      country: 'الإمارات',     latitude: 24.4539,  longitude: 54.3773),

    // الكويت
    CityModel(nameAr: 'الكويت',     nameEn: 'Kuwait City',    country: 'الكويت',       latitude: 29.3759,  longitude: 47.9774),

    // قطر
    CityModel(nameAr: 'الدوحة',     nameEn: 'Doha',           country: 'قطر',          latitude: 25.2854,  longitude: 51.5310),

    // البحرين
    CityModel(nameAr: 'المنامة',    nameEn: 'Manama',         country: 'البحرين',      latitude: 26.2235,  longitude: 50.5876),

    // عُمان
    CityModel(nameAr: 'مسقط',       nameEn: 'Muscat',         country: 'عُمان',        latitude: 23.5880,  longitude: 58.3829),

    // الأردن
    CityModel(nameAr: 'عمّان',      nameEn: 'Amman',          country: 'الأردن',       latitude: 31.9454,  longitude: 35.9284),

    // لبنان
    CityModel(nameAr: 'بيروت',      nameEn: 'Beirut',         country: 'لبنان',        latitude: 33.8938,  longitude: 35.5018),

    // العراق
    CityModel(nameAr: 'بغداد',      nameEn: 'Baghdad',        country: 'العراق',       latitude: 33.3152,  longitude: 44.3661),
    CityModel(nameAr: 'البصرة',     nameEn: 'Basra',          country: 'العراق',       latitude: 30.5085,  longitude: 47.7804),
    CityModel(nameAr: 'أربيل',      nameEn: 'Erbil',          country: 'العراق',       latitude: 36.1901,  longitude: 44.0091),

    // اليمن
    CityModel(nameAr: 'صنعاء',      nameEn: 'Sanaa',          country: 'اليمن',        latitude: 15.3694,  longitude: 44.1910),
    CityModel(nameAr: 'عدن',        nameEn: 'Aden',           country: 'اليمن',        latitude: 12.7797,  longitude: 45.0095),

    // ليبيا
    CityModel(nameAr: 'طرابلس',     nameEn: 'Tripoli',        country: 'ليبيا',        latitude: 32.8872,  longitude: 13.1913),

    // تونس
    CityModel(nameAr: 'تونس',       nameEn: 'Tunis',          country: 'تونس',         latitude: 36.8065,  longitude: 10.1815),

    // الجزائر
    CityModel(nameAr: 'الجزائر',    nameEn: 'Algiers',        country: 'الجزائر',      latitude: 36.7372,  longitude: 3.0865),

    // المغرب
    CityModel(nameAr: 'الرباط',     nameEn: 'Rabat',          country: 'المغرب',       latitude: 34.0209,  longitude: -6.8416),
    CityModel(nameAr: 'الدار البيضاء', nameEn: 'Casablanca',  country: 'المغرب',       latitude: 33.5731,  longitude: -7.5898),
    CityModel(nameAr: 'مراكش',      nameEn: 'Marrakesh',      country: 'المغرب',       latitude: 31.6295,  longitude: -7.9811),

    // السودان
    CityModel(nameAr: 'الخرطوم',    nameEn: 'Khartoum',       country: 'السودان',      latitude: 15.5007,  longitude: 32.5599),

    // فلسطين
    CityModel(nameAr: 'القدس',      nameEn: 'Jerusalem',      country: 'فلسطين',       latitude: 31.7683,  longitude: 35.2137),
    CityModel(nameAr: 'غزة',        nameEn: 'Gaza',           country: 'فلسطين',       latitude: 31.5017,  longitude: 34.4668),
    CityModel(nameAr: 'رام الله',   nameEn: 'Ramallah',       country: 'فلسطين',       latitude: 31.8996,  longitude: 35.2042),

    // تركيا
    CityModel(nameAr: 'إسطنبول',    nameEn: 'Istanbul',       country: 'تركيا',        latitude: 41.0082,  longitude: 28.9784),
    CityModel(nameAr: 'أنقرة',      nameEn: 'Ankara',         country: 'تركيا',        latitude: 39.9334,  longitude: 32.8597),

    // إيران
    CityModel(nameAr: 'طهران',      nameEn: 'Tehran',         country: 'إيران',        latitude: 35.6892,  longitude: 51.3890),

    // باكستان
    CityModel(nameAr: 'كراتشي',     nameEn: 'Karachi',        country: 'باكستان',      latitude: 24.8607,  longitude: 67.0011),
    CityModel(nameAr: 'لاهور',      nameEn: 'Lahore',         country: 'باكستان',      latitude: 31.5204,  longitude: 74.3587),
    CityModel(nameAr: 'إسلام آباد', nameEn: 'Islamabad',      country: 'باكستان',      latitude: 33.6844,  longitude: 73.0479),

    // ماليزيا
    CityModel(nameAr: 'كوالالمبور', nameEn: 'Kuala Lumpur',   country: 'ماليزيا',      latitude: 3.1390,   longitude: 101.6869),

    // إندونيسيا
    CityModel(nameAr: 'جاكرتا',     nameEn: 'Jakarta',        country: 'إندونيسيا',    latitude: -6.2088,  longitude: 106.8456),

    // النمسا
    CityModel(nameAr: 'فيينا',      nameEn: 'Vienna',         country: 'النمسا',       latitude: 48.2082,  longitude: 16.3738),

    // ألمانيا
    CityModel(nameAr: 'برلين',      nameEn: 'Berlin',         country: 'ألمانيا',      latitude: 52.5200,  longitude: 13.4050),
    CityModel(nameAr: 'ميونيخ',     nameEn: 'Munich',         country: 'ألمانيا',      latitude: 48.1351,  longitude: 11.5820),
    CityModel(nameAr: 'فرانكفورت',  nameEn: 'Frankfurt',      country: 'ألمانيا',      latitude: 50.1109,  longitude: 8.6821),
    CityModel(nameAr: 'هامبورغ',    nameEn: 'Hamburg',        country: 'ألمانيا',      latitude: 53.5753,  longitude: 10.0153),

    // فرنسا
    CityModel(nameAr: 'باريس',      nameEn: 'Paris',          country: 'فرنسا',        latitude: 48.8566,  longitude: 2.3522),

    // المملكة المتحدة
    CityModel(nameAr: 'لندن',       nameEn: 'London',         country: 'المملكة المتحدة', latitude: 51.5074, longitude: -0.1278),
    CityModel(nameAr: 'برمنغهام',   nameEn: 'Birmingham',     country: 'المملكة المتحدة', latitude: 52.4862, longitude: -1.8904),

    // هولندا
    CityModel(nameAr: 'أمستردام',   nameEn: 'Amsterdam',      country: 'هولندا',       latitude: 52.3676,  longitude: 4.9041),

    // بلجيكا
    CityModel(nameAr: 'بروكسل',     nameEn: 'Brussels',       country: 'بلجيكا',       latitude: 50.8503,  longitude: 4.3517),

    // السويد
    CityModel(nameAr: 'ستوكهولم',   nameEn: 'Stockholm',      country: 'السويد',       latitude: 59.3293,  longitude: 18.0686),

    // الدنمارك
    CityModel(nameAr: 'كوبنهاغن',   nameEn: 'Copenhagen',     country: 'الدنمارك',     latitude: 55.6761,  longitude: 12.5683),

    // النرويج
    CityModel(nameAr: 'أوسلو',      nameEn: 'Oslo',           country: 'النرويج',      latitude: 59.9139,  longitude: 10.7522),

    // سويسرا
    CityModel(nameAr: 'زيورخ',      nameEn: 'Zurich',         country: 'سويسرا',       latitude: 47.3769,  longitude: 8.5417),

    // إيطاليا
    CityModel(nameAr: 'روما',       nameEn: 'Rome',           country: 'إيطاليا',      latitude: 41.9028,  longitude: 12.4964),
    CityModel(nameAr: 'ميلانو',     nameEn: 'Milan',          country: 'إيطاليا',      latitude: 45.4642,  longitude: 9.1900),

    // إسبانيا
    CityModel(nameAr: 'مدريد',      nameEn: 'Madrid',         country: 'إسبانيا',      latitude: 40.4168,  longitude: -3.7038),
    CityModel(nameAr: 'برشلونة',    nameEn: 'Barcelona',      country: 'إسبانيا',      latitude: 41.3851,  longitude: 2.1734),

    // كندا
    CityModel(nameAr: 'تورنتو',     nameEn: 'Toronto',        country: 'كندا',         latitude: 43.6532,  longitude: -79.3832),
    CityModel(nameAr: 'مونتريال',   nameEn: 'Montreal',       country: 'كندا',         latitude: 45.5017,  longitude: -73.5673),

    // أمريكا
    CityModel(nameAr: 'نيويورك',    nameEn: 'New York',       country: 'أمريكا',       latitude: 40.7128,  longitude: -74.0060),
    CityModel(nameAr: 'لوس أنجلوس', nameEn: 'Los Angeles',    country: 'أمريكا',       latitude: 34.0522,  longitude: -118.2437),
    CityModel(nameAr: 'شيكاغو',     nameEn: 'Chicago',        country: 'أمريكا',       latitude: 41.8781,  longitude: -87.6298),
    CityModel(nameAr: 'ديترويت',    nameEn: 'Detroit',        country: 'أمريكا',       latitude: 42.3314,  longitude: -83.0458),

    // أستراليا
    CityModel(nameAr: 'سيدني',      nameEn: 'Sydney',         country: 'أستراليا',     latitude: -33.8688, longitude: 151.2093),
    CityModel(nameAr: 'ملبورن',     nameEn: 'Melbourne',      country: 'أستراليا',     latitude: -37.8136, longitude: 144.9631),
  ];
}