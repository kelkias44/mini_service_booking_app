import 'package:flutter/widgets.dart';

class EmptyServiceWidget extends StatelessWidget {
  const EmptyServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Service Yet!"),
    );
  }
}
