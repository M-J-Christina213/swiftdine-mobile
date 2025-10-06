import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/controllers/address_controller.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Map<String, String>> addresses = [
    {
      'district': 'Colombo',
      'province': 'Western',
      'city': 'Colombo 7',
      'lane': '12 Flower Road',
      'postalCode': '00700',
    },
    {
      'district': 'Kandy',
      'province': 'Central',
      'city': 'Kandy',
      'lane': '45 Lake Street',
      'postalCode': '20000',
    },
  ];

  void _showAddressDialog({Map<String, String>? existingAddress, int? index}) {
    final addressController = AddressController();

    // Initialize text fields with existing data if editing
    if (existingAddress != null) {
      addressController.districtController.text = existingAddress['district'] ?? '';
      addressController.provinceController.text = existingAddress['province'] ?? '';
      addressController.cityController.text = existingAddress['city'] ?? '';
      addressController.laneController.text = existingAddress['lane'] ?? '';
      addressController.postalCodeController.text = existingAddress['postalCode'] ?? '';
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existingAddress == null ? 'Add Address' : 'Edit Address'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(addressController.districtController, 'District'),
              _buildTextField(addressController.provinceController, 'Province'),
              _buildTextField(addressController.cityController, 'City'),
              _buildTextField(addressController.laneController, 'Lane/Street'),
              _buildTextField(addressController.postalCodeController, 'Postal Code', keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addressController.dispose();
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newAddress = {
                'district': addressController.districtController.text.trim(),
                'province': addressController.provinceController.text.trim(),
                'city': addressController.cityController.text.trim(),
                'lane': addressController.laneController.text.trim(),
                'postalCode': addressController.postalCodeController.text.trim(),
              };

              setState(() {
                if (index == null) {
                  addresses.add(newAddress);
                } else {
                  addresses[index] = newAddress;
                }
              });

              addressController.dispose();
              Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Addresses')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddressDialog(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: addresses.isEmpty
            ? const Center(child: Text('No addresses added yet. Tap + to add.'))
            : ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final addr = addresses[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text('${addr['lane']}, ${addr['city']}'),
                      subtitle: Text('${addr['district']}, ${addr['province']} - ${addr['postalCode']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showAddressDialog(existingAddress: addr, index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                addresses.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}