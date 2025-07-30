import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/register_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nombreController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final curpController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => RegisterViewModel(),
        child: Consumer<RegisterViewModel>(
          builder: (context, vm, child) => Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Registro', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 32),
                    TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: apellidoPaternoController,
                      decoration: const InputDecoration(labelText: 'Apellido paterno'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: apellidoMaternoController,
                      decoration: const InputDecoration(labelText: 'Apellido materno'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: curpController,
                      decoration: const InputDecoration(labelText: 'CURP'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Correo electrónico'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 32),
                    vm.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              final ok = await vm.register({
                                'curp': curpController.text,
                                'nombre': nombreController.text,
                                'apellidoPaterno': apellidoPaternoController.text,
                                'apellidoMaterno': apellidoMaternoController.text,
                                'email': emailController.text,
                                'password': passwordController.text,
                                'role': 'paciente',
                              });

                              if (ok) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('¡Usuario registrado con éxito!')),
                                );
                                await Future.delayed(const Duration(milliseconds: 800));
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(vm.error ?? 'Ocurrió un error al registrar')),
                                );
                              }
                            },
                            child: const Text('Registrar'),
                          ),
                    if (vm.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(vm.error!, style: const TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
