// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_seller_app/presentation/home/bloc/update_resi/update_resi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

class InputResiPage extends StatefulWidget {
  final int orderId;
  const InputResiPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<InputResiPage> createState() => _InputResiPageState();
}

class _InputResiPageState extends State<InputResiPage> {
  final inputResiController = TextEditingController();

  @override
  void dispose() {
    inputResiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Resi'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField(
            controller: inputResiController,
            label: 'No Resi',
            hintText: 'Masukkan No Resi',
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<UpdateResiBloc, UpdateResiState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {
                const Center(
                  child: CircularProgressIndicator(),
                );
              },
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Resi Berhasil di update")));
                context.pop();
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gagal mengupdate resi")));
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  disabled: inputResiController.text.isEmpty,
                  onPressed: () {
                    final data = inputResiController.text;
                    context
                        .read<UpdateResiBloc>()
                        .add(UpdateResiEvent.updateResi(widget.orderId, data));
                  },
                  label: 'Simpan',
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
