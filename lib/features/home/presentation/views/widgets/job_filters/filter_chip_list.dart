import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget _chips(String text) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(20),
    ),
    alignment: Alignment.center,
    child: Text(
      text,
      style: GoogleFonts.inter(
        color: Colors.indigo.shade600,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
