import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/bloc/bloc/login_bloc.dart';
import 'package:flutter_siakad_app/common/widgets/buttons.dart';
import 'package:flutter_siakad_app/common/widgets/custom_text_field.dart';
import 'package:flutter_siakad_app/data/models/request/auth_request_model.dart';
import 'package:flutter_siakad_app/page/dosen/dosen_page.dart';
import 'package:flutter_siakad_app/page/mahasiswa/mahasiswa_page.dart';
import '../../../common/constants/colors.dart';

class LoginBottomSheet extends StatefulWidget {
  final String roles;
  const LoginBottomSheet({
    super.key,
    required this.roles,
  });

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 40.0),
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                const Text(
                  "Selamat Datang",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Masukkan email dan password agar bisa mengakses informasi administrasi.",
                  style: TextStyle(
                    color: ColorName.grey,
                  ),
                ),
                const SizedBox(height: 50.0),
                CustomTextField(
                  controller: usernameController,
                  label: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12.0),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    state.maybeWhen(orElse: () {
                      return;
                    }, loaded: (data) {
                      if (data.user.roles != widget.roles) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text(
                                  'Anda tidak memiliki akses sebagai ${widget.roles}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      if (data.user.roles == 'mahasiswa') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MahasiswaPage(),
                          ),
                        );
                      } else if (data.user.roles == 'dosen') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DosenPage(),
                          ),
                        );
                      }
                    }, error: (message) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(message),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state.maybeWhen(
                            orElse: () => false,
                            error: (message) => true,
                          ))
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                state.maybeWhen(
                                  orElse: () => '',
                                  error: (message) => message,
                                ),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          state.maybeWhen(
                            orElse: () => Button.filled(
                              onPressed: () {
                                final authRequestModel = AuthRequestModel(
                                    email: usernameController.text,
                                    password: passwordController.text);
                                context.read<LoginBloc>().add(
                                      LoginEvent.login(authRequestModel),
                                    );
                              },
                              label: 'Masuk',
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
