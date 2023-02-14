import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/provider.dart';
import 'src/state_notifier_provider.dart';
import 'src/state_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:styled_widget/styled_widget.dart';

void main() {
  runApp(const App());
}




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        home: AppStatefulScaffold(),
      ),
    );
  }
}





class AppStatefulScaffold extends ConsumerStatefulWidget {
  const AppStatefulScaffold({super.key});

  @override
  ConsumerState<AppStatefulScaffold> createState() => _AppStatefulScaffoldState();
}

class _AppStatefulScaffoldState extends ConsumerState<AppStatefulScaffold> {

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(provider);
    final count = ref.watch(stateProvider);
    final status = ref.watch(counterStatusProvider);


    final appBar = AppBar(
      title: const Text('Flutter WhatsApp'),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.rotateRight),
          onPressed: () {
            ref.invalidate(stateProvider);
            // ref.refresh(stateProvider);
          } ,
        ),
      ],
    );


    return Scaffold(
      appBar: appBar,
      body: Text("Hi, $name. You have clicked the button $count times. $status")
        .textAlignment(TextAlign.center)
        .center(),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          final count = ref.read(stateProvider);
          ref.read(stateProvider.notifier).state = count + 1;
          // ref.read(stateProvider.notifier).update((state) => state + 1);
          ref.read(counterStatusProvider.notifier).updateCounter(count + 1);
        },
      ),
    );
  }
}

