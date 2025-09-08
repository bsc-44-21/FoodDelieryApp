import 'package:flutter/material.dart';
import 'package:food_app/pages/signIn.dart';
import 'order.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // User info variables
  String userName = "Abdul-Rasheed";
  String userEmail = "abdulrasheed@email.com";
  String userPhone = "0123456789";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                "Profile",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Manage your account and preferences",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // User Avatar and Info
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("images/kun.png"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userPhone,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Profile Options
              buildProfileOption(Icons.edit, "Edit Profile", () {
                _showEditDialog();
              }),
              buildProfileOption(Icons.shopping_bag, "My Orders", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Order()),
                );
              }),
              buildProfileOption(Icons.settings, "Settings", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              }),

              buildProfileOption(Icons.logout, "Logout", () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Single Profile Option Widget with onTap
  Widget buildProfileOption(
    IconData icon,
    String title, [
    VoidCallback? onTap,
  ]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 28),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Dialog to edit user info
  void _showEditDialog() {
    final nameController = TextEditingController(text: userName);
    final emailController = TextEditingController(text: userEmail);
    final phoneController = TextEditingController(text: userPhone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (!emailController.text.contains('@') ||
                  !emailController.text.contains('.')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a valid email")),
                );
                return;
              }

              setState(() {
                userName = nameController.text;
                userEmail = emailController.text;
                userPhone = phoneController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}

// ------------------ Settings Screen ------------------
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            trailing: Switch(value: false, onChanged: (val) {}),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
