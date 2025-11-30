import 'package:flutter/material.dart';
import 'models.dart';

class BusinessDetailsScreen extends StatefulWidget {
  final Business business;

  const BusinessDetailsScreen({super.key, required this.business});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  
  // In a real app, this function would be triggered by scanning a QR code
  void _simulateVisit() {
    setState(() {
      widget.business.addVisit();
    });
    
    if (widget.business.isRewardUnlocked) {
      _showRewardDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Stamp Added! Come back again.")),
      );
    }
  }

  void _showRewardDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("CONGRATULATIONS! 🎉"),
        content: Text("You have unlocked: ${widget.business.offerTitle}\nShow this screen to the cashier."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                // Logic to reset card or archive it
                widget.business.currentVisits = 0; 
              });
            },
            child: const Text("Claim & Reset"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.business.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Offer Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.black,
              child: Column(
                children: [
                  const Text("THE DAZZLING OFFER", style: TextStyle(color: Colors.white, fontSize: 12)),
                  const SizedBox(height: 10),
                  Text(
                    widget.business.offerTitle,
                    style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Stamp Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Your Loyalty Card",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildStampGrid(),

            const SizedBox(height: 30),

            // Action Button (Simulating QR Scan)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: widget.business.isRewardUnlocked ? _showRewardDialog : _simulateVisit,
                icon: Icon(widget.business.isRewardUnlocked ? Icons.card_giftcard : Icons.qr_code),
                label: Text(
                  widget.business.isRewardUnlocked ? "CLAIM REWARD" : "ADD STAMP (Staff Only)",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Note: In the final version, the 'Add Stamp' button will be replaced by a QR Code Scanner used by the restaurant staff.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStampGrid() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 5 stamps per row
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: widget.business.requiredVisits,
        itemBuilder: (context, index) {
          bool isStamped = index < widget.business.currentVisits;
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isStamped ? const Color(0xFFD4AF37) : Colors.grey[200],
              border: Border.all(color: const Color(0xFFD4AF37), width: 2),
            ),
            child: Center(
              child: isStamped
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text("${index + 1}", style: const TextStyle(color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }
}
