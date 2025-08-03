import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/register_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final nomeCtrl     = TextEditingController();
  final paternoCtrl  = TextEditingController();
  final maternoCtrl  = TextEditingController();
  final curpCtrl     = TextEditingController();
  final emailCtrl    = TextEditingController();
  final passCtrl     = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Registro'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ChangeNotifierProvider(
              create: (_) => RegisterViewModel(),
              child: Consumer<RegisterViewModel>(
                builder: (context, vm, _) => Column(
                  children: [
                    TextField(
                      controller: nomeCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Nombre', prefixIcon: Icon(Icons.person)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: paternoCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Apellido paterno',
                          prefixIcon: Icon(Icons.person_outline)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: maternoCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Apellido materno',
                          prefixIcon: Icon(Icons.person_outline)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: curpCtrl,
                      decoration: const InputDecoration(
                          labelText: 'CURP',
                          prefixIcon: Icon(Icons.badge_outlined)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Correo',
                          prefixIcon: Icon(Icons.email_outlined)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock_outline)),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    vm.isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final ok = await vm.register({
                                  'curp': curpCtrl.text,
                                  'nombre': nomeCtrl.text,
                                  'apellidoPaterno': paternoCtrl.text,
                                  'apellidoMaterno': maternoCtrl.text,
                                  'email': emailCtrl.text,
                                  'password': passCtrl.text,
                                  'role': 'paciente',
                                });
                                if (ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Usuario registrado 🎉')),
                                  );
                                  await Future.delayed(const Duration(milliseconds: 800));
                                  context.go('/');
                                }
                              },
                              child: const Text('Registrar'),
                            ),
                          ),
                    if (vm.error != null) ...[
                      const SizedBox(height: 16),
                      Text(vm.error!, style: const TextStyle(color: Colors.red)),
                    ]
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
