import 'package:flutter/material.dart';

enum BusinessType { restaurant, medical, shop, other }

class Business {
  final String id;
  final String name;
  final String description;
  final String imageUrl; // Use placeholder URLs for now
  final BusinessType type;
  final String offerTitle; // e.g., "Free Meal"
  final int requiredVisits; // e.g., 5
  int currentVisits; // User's progress

  Business({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.offerTitle,
    required this.requiredVisits,
    this.currentVisits = 0,
  });

  // Logic to check if reward is unlocked
  bool get isRewardUnlocked => currentVisits >= requiredVisits;

  // Simulate visiting the shop
  void addVisit() {
    if (currentVisits < requiredVisits) {
      currentVisits++;
    } else {
      // Reset after claiming (logic can be changed based on needs)
      currentVisits = 0; 
    }
  }
}

// MOCK DATA: This simulates your network of customers
List<Business> dummyBusinesses = [
  Business(
    id: '1',
    name: 'Golden Fork Restaurant',
    description: 'Luxury dining with an exclusive menu.',
    imageUrl: 'https://via.placeholder.com/150/FFD700/000000?text=Restaurant',
    type: BusinessType.restaurant,
    offerTitle: 'Free Main Course',
    requiredVisits: 5,
    currentVisits: 2,
  ),
  Business(
    id: '2',
    name: 'Dubai Smile Dental',
    description: 'Top tier dental care for Dazzling members.',
    imageUrl: 'https://via.placeholder.com/150/00BFFF/FFFFFF?text=Medical',
    type: BusinessType.medical,
    offerTitle: '50% Off Cleaning',
    requiredVisits: 3,
    currentVisits: 0,
  ),
  Business(
    id: '3',
    name: 'Velvet Boutique',
    description: 'Fashion trends directly from Paris.',
    imageUrl: 'https://via.placeholder.com/150/FF69B4/FFFFFF?text=Shop',
    type: BusinessType.shop,
    offerTitle: '200 AED Voucher',
    requiredVisits: 8,
    currentVisits: 7,
  ),
];