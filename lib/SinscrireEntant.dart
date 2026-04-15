import 'package:flutter/material.dart';

import 'SinscrireElève.dart';
import 'SinscrireProf.dart';


class SinscrireEnTant extends StatefulWidget {
  const SinscrireEnTant({super.key});

  @override
  State<SinscrireEnTant> createState() => _SinscrireEnTantState();
}

class _SinscrireEnTantState extends State<SinscrireEnTant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1A1F5C),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A1F5C),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "S'inscrire",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        body: Stack(
            children: [
              Positioned(
                top: -60,
                left: -60,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              Positioned(
                bottom: -75,
                right: -70,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:  Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              Center(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),

                            Text(
                              "Bienvenue",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'poppins',
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Inscrivez vous en tant que",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: 'poppins',
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 50),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SinscrireEleve(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Apprenant",
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SinscrireProf(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Professeur",
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      )
                  )
              ),
            ]
        )
    );
  }
}