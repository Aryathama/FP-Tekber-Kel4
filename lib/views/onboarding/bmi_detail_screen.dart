import 'package:flutter/material.dart';
import '/viewmodels/onboarding/bmi_detail_viewmodel.dart'; // Sesuaikan path
import '/models/user_profile.dart'; // Untuk meneruskan data
import 'package:provider/provider.dart';
// Jika Anda punya HomePage, import di sini:
// import 'package:onboarding_app/views/home_page.dart';

class BMIDetailScreen extends StatelessWidget {
  // BMI Detail Screen tidak lagi menerima data langsung di konstruktor,
  // melainkan mengambil dari ViewModel yang disediakan oleh Provider.

  @override
  Widget build(BuildContext context) {
    return Consumer<BMIDetailViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Our plan for you is",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    viewModel.planText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: viewModel.dynamicColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "${viewModel.bmi.toStringAsFixed(0)} BMI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: viewModel.dynamicColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Your BMI category is ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: viewModel.bmiCategory,
                          style: TextStyle(
                            color: viewModel.dynamicColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildUserInfoColumn(
                        icon: viewModel.gender == Gender.male ? Icons.male : Icons.female,
                        label: 'Gender',
                        value: viewModel.genderText,
                      ),
                      _buildUserInfoColumn(
                        icon: Icons.person,
                        label: 'Age',
                        value: '${viewModel.age}',
                      ),
                      _buildUserInfoColumn(
                        icon: Icons.monitor_weight,
                        label: 'Weight',
                        value: '${viewModel.weight} kg',
                      ),
                      _buildUserInfoColumn(
                        icon: Icons.height,
                        label: 'Height',
                        value: '${viewModel.height} cm',
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  _buildBMICategoryRow('Underweight', '< 18.5', Colors.blue),
                  SizedBox(height: 10),
                  _buildBMICategoryRow('Normal', '18.5 - 24.9', Colors.green),
                  SizedBox(height: 10),
                  _buildBMICategoryRow('Overweight', '25 - 29.9', Colors.orange),
                  SizedBox(height: 10),
                  _buildBMICategoryRow('Obese', '> 30', Colors.red),

                  Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('Go to Homepage pressed!');
                        // Anda bisa menavigasi ke HomePage di sini.
                        // Contoh:
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Go to Homepage →',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfoColumn({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.grey[700]),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBMICategoryRow(String category, String range, Color dotColor) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dotColor,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            category,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          range,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}