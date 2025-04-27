import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_agora_token/get_agora_token_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/set_livestreaming/set_livestreaming_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/live_streaming_on_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
// import 'live_streaming_page.dart';

class LiveStreamingCreatePage extends StatefulWidget {
  const LiveStreamingCreatePage({super.key});

  @override
  State<LiveStreamingCreatePage> createState() =>
      _LiveStreamingCreatePageState();
}

class _LiveStreamingCreatePageState extends State<LiveStreamingCreatePage> {
  final titleLiveStreamController = TextEditingController();

  @override
  void dispose() {
    titleLiveStreamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Live Streaming'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField(
            controller: titleLiveStreamController,
            label: 'Judul',
            hintText: 'Masukkan judul live stream',
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<GetAgoraTokenBloc, GetAgoraTokenState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (channel, uid, token) {
                context.pushReplacement(LiveStreamingOnPage(
                    token: token, channelName: channel, uid: uid));
              },
              error: (message) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              },
            );
            // TODO: implement listener
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  disabled: titleLiveStreamController.text.isEmpty,
                  onPressed: () async {
                    final authData = await AuthLocalDatasource().getLoginData();
                    context.read<SetLivestreamingBloc>().add(
                        const SetLivestreamingEvent.setLivestreaming(true));
                    context.read<GetAgoraTokenBloc>().add(
                        GetAgoraTokenEvent.getAgoraToken(
                            authData.data!.user!.name!
                                .trim()
                                .replaceAll(' ', ''),
                            authData.data!.user!.id.toString()));
                  },
                  // onPressed: () => context.pushReplacement(const LiveStreamingPage()),
                  label: 'Lanjut',
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
