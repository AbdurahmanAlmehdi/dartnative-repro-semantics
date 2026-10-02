import 'package:dartnative/dartnative.dart';

import 'dartnative_plugin_registrant.dart';

void main() {
  DartNativePluginRegistrant.registerAll();
  runApp(const SemanticsRepro());
}

class SemanticsRepro extends StatefulWidget {
  const SemanticsRepro({super.key});

  @override
  State<SemanticsRepro> createState() => _SemanticsReproState();
}

class _SemanticsReproState extends State<SemanticsRepro> {
  String _status = 'Record #184 kept';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      brightness: Brightness.light,
      appBar: AppBar(title: const Text('Semantics')),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('No Semantics widget',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            const Text(
              "Expected (Flutter): Semantics(label: 'Hold to delete', button: true, ...) "
              'makes VoiceOver / TalkBack read the custom control as a labelled button.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 4),
            const Text(
              'Actual: no Semantics, and Icon has no semanticLabel, so the two controls '
              'below have no label or button role in the accessibility tree.',
              style: TextStyle(fontSize: 13, color: Color(0xFFC62828)),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                // 1. Custom hold-to-delete control.
                GestureDetector(
                  onLongPress: () => setState(() => _status = 'Record #184 deleted'),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.delete, color: Color(0xFFFFFFFF), size: 30),
                  ),
                ),
                const SizedBox(width: 24),
                // 2. Icon-only button.
                IconButton(
                  icon: const Icon(Icons.ios_share),
                  onPressed: () => setState(() => _status = 'Export tapped'),
                ),
                const SizedBox(width: 24),
                // 3. For comparison: a text button, which the platform labels.
                Button(
                  title: 'Save',
                  onPressed: () => setState(() => _status = 'Save tapped'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '1: hold-to-delete (GestureDetector)   2: export (icon-only IconButton)   '
              '3: Save (text Button, for comparison)',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
            ),
            const SizedBox(height: 12),
            Text(_status, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
