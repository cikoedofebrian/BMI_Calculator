import 'dart:math';

import 'package:app/bmiresult.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _weightSliderValue = 50;
  double _heightSliderValue = 150;

  void getResult() {
    final double bmi =
        _weightSliderValue / (pow((_heightSliderValue / 100.0), 2));
    Color color = Colors.green;
    String text = "Your weight are perfect, Keep it up!";
    if (bmi < 18.5) {
      color = Colors.blue;
      text = "You are underweight, please eat more foods!";
    } else if (bmi >= 25 && bmi < 30) {
      color = Colors.orange;
      text = "You are overweight, please eat less foods!";
    } else {
      color = Colors.red;
      text =
          "You are extremely overweight, please eat less foods and consider taking a workout!";
    }

    Navigator.pushNamed(context, '/result',
        arguments: BMIResult(text: text, result: bmi, color: color));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello Ciko,",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Welcome to BMI Calculator!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Height",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "${_heightSliderValue.toStringAsFixed(0)} cm",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Slider(
                thumbColor: Colors.white,
                activeColor: Colors.white,
                inactiveColor: Colors.black,
                value: _heightSliderValue,
                min: 1,
                max: 300,
                onChanged: (double value) {
                  setState(() {
                    _heightSliderValue = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Weight",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "${_weightSliderValue.toStringAsFixed(0)} kg",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Slider(
                thumbColor: Colors.white,
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                value: _weightSliderValue,
                min: 1,
                max: 200,
                onChanged: (double value) {
                  setState(() {
                    _weightSliderValue = value;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => getResult(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 60,
                  child: Text(
                    'GET BMI RESULT',
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
