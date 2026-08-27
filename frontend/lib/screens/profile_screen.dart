import 'package:flutter/material.dart';
import '../core/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                      bottomRight: Radius.circular(150),
                    ),
                  ),
                  child: const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_back_ios, color: Colors.white),
                          Text("Profile", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Icon(Icons.notifications_outlined, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: AppTheme.background,
                      child: Icon(Icons.person, size: 40, color: AppTheme.primary),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  "Enjelin Morgeana",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 4),
                const Text("@enjelin_morgeana", style: TextStyle(color: AppTheme.textGrey)),
                const SizedBox(height: 30),
                _buildMenuItem(Icons.diamond_outlined, "Invite Friends"),
                _buildMenuItem(Icons.person_outline, "Account info"),
                _buildMenuItem(Icons.people_outline, "Personal profile"),
                _buildMenuItem(Icons.message_outlined, "Message center"),
                _buildMenuItem(Icons.security_outlined, "Login and security"),
                _buildMenuItem(Icons.lock_outline, "Data and privacy"),
                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textGrey),
        ],
      ),
    );
  }
}
