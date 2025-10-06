// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swiftdine_mobile/themes/app_theme.dart';

class OfferScreen extends StatefulWidget {
  final bool isLoggedIn;
  final bool isBirthdayMonth;
  final String userName;
  final Duration birthdayCountdown;

  const OfferScreen({
    super.key,
    required this.isLoggedIn,
    required this.isBirthdayMonth,
    required this.userName,
    required this.birthdayCountdown,
  });

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  late Timer _timer;
  late DateTime _targetDate;
  Duration _timeLeft = Duration.zero;

  final List<Map<String, String>> touristOffers = [
    {
      'img': 'assets/images/tour1.png',
      'title': 'Hotel Guest Dine-In Discount',
      'desc': 'Enjoy 15% off your meal when you show your hotel keycard.',
      'validity': 'Valid till 2025-06-30',
    },
    {
      'img': 'assets/images/tour2.png',
      'title': 'Airport Arrival Snack Deal',
      'desc': 'Free drink with any snack purchase at the airport lounge.',
      'validity': 'Valid till 2025-07-15',
    },
    {
      'img': 'assets/images/tour3.png',
      'title': 'Tourist Welcome Dinner',
      'desc': 'Exclusive 20% off on your first dinner at selected restaurants.',
      'validity': 'Valid till 2025-08-01',
    },
  ];

  final List<Map<String, dynamic>> seasonOffers = [
    {
      'img': 'assets/images/season2.png',
      'name': 'Christmas Roast Platter – 20% Off',
      'discount': '20% Off',
      'validity': '2025-12-01 to 2025-12-31',
      'outlets': 18,
      'tag': 'Christmas',
    },
    {
      'img': 'assets/images/season3.png',
      'name': 'Ramadan Iftar Packages',
      'discount': 'Special Packages',
      'validity': '2025-04-01 to 2025-04-30',
      'outlets': 10,
      'tag': 'Ramadan',
    },
    {
      'img': 'assets/images/season1.png',
      'name': 'Awurudu Food Combos – Up to 25% Off',
      'discount': '25% Off',
      'validity': '2025-04-10 to 2025-04-25',
      'outlets': 12,
      'tag': 'Awurudu',
    },
    {
      'img': 'assets/images/season4.png',
      'name': 'Independence Day Local Buffet Specials',
      'discount': '15% Off',
      'validity': '2025-02-01 to 2025-02-10',
      'outlets': 14,
      'tag': 'Independence',
    },
  ];

  final List<Map<String, String>> groupDiningOffers = [
    {
      'img': 'assets/images/group1.png',
      'title': 'Bring Friends, Save More',
      'desc': 'Enjoy bigger savings when you bring your friends.',
      'offer_price': 'Rs1,200',
      'old_price': 'Rs1,500',
      'save': '25%',
    },
    {
      'img': 'assets/images/group2.png',
      'title': 'Family Bundle – Meal for 4',
      'desc': 'Enjoy 20% off your total bill for groups of 4 or more.',
      'offer_price': 'Rs2,500',
      'old_price': 'Rs3,000',
      'save': '30%',
    },
    {
      'img': 'assets/images/group3.png',
      'title': 'Couple’s Night Out',
      'desc': 'Get a free mocktail and dessert for two.',
      'offer_price': 'Rs1,800',
      'old_price': 'Rs2,250',
      'save': '10%',
    },
  ];

  @override
  void initState() {
    super.initState();
    _targetDate = DateTime.now().add(widget.birthdayCountdown);
    _startCountdown();
  }

  void _startCountdown() {
    _updateTimeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTimeLeft());
  }

  void _updateTimeLeft() {
    final now = DateTime.now();
    setState(() {
      _timeLeft = _targetDate.difference(now);
      if (_timeLeft.isNegative) {
        _timeLeft = Duration.zero;
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildSeasonalOffers() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: seasonOffers.length,
        itemBuilder: (context, index) {
          final offer = seasonOffers[index];
          return Container(
            width: 300,
            margin: const EdgeInsets.only(left: 16, right: 8),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      offer['img'],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(offer['name'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          'Validity: ${offer['validity']}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGroupDiningCardVertical(Map<String, String> offer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              offer['img']!,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(offer['title']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(offer['desc']!),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      offer['offer_price']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      offer['old_price']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Save ${offer['save']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTouristOffers() {
    return Column(
      children: touristOffers.map(_buildOfferCard).toList(),
    );
  }

  Widget _buildHeader() {
    final d = _timeLeft.inDays.toString().padLeft(2, '0');
    final h = (_timeLeft.inHours % 24).toString().padLeft(2, '0');
    final m = (_timeLeft.inMinutes % 60).toString().padLeft(2, '0');
    final s = (_timeLeft.inSeconds % 60).toString().padLeft(2, '0');

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Image.asset('assets/images/headb.png', fit: BoxFit.cover),
        ),
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.black.withAlpha((0.5 * 255).toInt()),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.isLoggedIn && widget.isBirthdayMonth
                        ? [
                            Text(
                              '🎂 Happy Birthday, ${widget.userName}!',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Birthday on ${DateFormat('MMMM dd, yyyy').format(_targetDate)}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildTimeBox(d, 'Days'),
                                _buildTimeBox(h, 'Hours'),
                                _buildTimeBox(m, 'Min'),
                                _buildTimeBox(s, 'Sec'),
                              ],
                            ),
                          ]
                        : [
                            const Text(
                              'Welcome to SwiftDine Offers!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Explore exciting discounts available now!',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _buildOfferCard(Map<String, String> offer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                offer['img']!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(offer['desc']!, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(
                    offer['validity']!,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildSectionTitle("🎉 Seasonal Offers"),
          _buildSeasonalOffers(),
          const SizedBox(height: 20),
          _buildSectionTitle("👨‍👩‍👧 Group Dining Offers"),
          ...groupDiningOffers.map(_buildGroupDiningCardVertical),
          const SizedBox(height: 20),
          _buildSectionTitle("🌍 Tourist Offers"),
          _buildTouristOffers(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
