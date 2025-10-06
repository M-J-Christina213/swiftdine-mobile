import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I place an order?',
      'answer': 'Browse our menu, add items to your cart, then checkout.',
    },
    {
      'question': 'What payment methods do you accept?',
      'answer': 'We accept Cash on Delivery and Card payments via our partner.',
    },
    {
      'question': 'Can I change my delivery address after ordering?',
      'answer': 'Please contact support as soon as possible to change delivery details.',
    },
  ];

  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = List.generate(faqs.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _expanded[index] = !isExpanded;
                    });
                  },
                  children: faqs.asMap().entries.map<ExpansionPanel>((entry) {
                    int index = entry.key;
                    Map<String, String> faq = entry.value;
                    return ExpansionPanel(
                      headerBuilder: (ctx, isExpanded) => ListTile(
                        title: Text(faq['question']!),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(faq['answer']!),
                      ),
                      isExpanded: _expanded[index],
                    );
                  }).toList(),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Contact Support'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact support at support@example.com')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
