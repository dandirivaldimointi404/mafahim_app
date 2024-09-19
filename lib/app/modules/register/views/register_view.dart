import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              buildNameTextField(),
              const SizedBox(height: 16),
              buildUsernameTextField(),
              const SizedBox(height: 16),
              buildPasswordTextField(),
              const SizedBox(height: 32), 
              buildNoHpTextField(),
              const SizedBox(height: 32), 
              buildAlamatTextField(),
              const SizedBox(height: 32), 
              ElevatedButton(
                onPressed: () {
                  controller.register();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameTextField() {
    return TextField(
      controller: controller.nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildUsernameTextField() {
    return TextField(
      controller: controller.usernameController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return TextField(
      controller: controller.passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

   Widget buildNoHpTextField() {
    return TextField(
      controller: controller.nohpController,
      // obscureText: true,
      decoration: const InputDecoration(
        labelText: 'No HP',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildAlamatTextField() {
    return TextField(
      controller: controller.alamatController,
      // obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Alamat',
        border: OutlineInputBorder(),
      ),
    );
  }
}
