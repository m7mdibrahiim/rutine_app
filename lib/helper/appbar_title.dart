import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.size});
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 3),
      baseColor: const Color.fromARGB(255, 54, 158, 244),
      highlightColor: const Color.fromARGB(255, 249, 170, 52),
      child:
          // Center(
          //   child: Text(
          //     "روتيني",
          //     style: GoogleFonts.ruwudu(
          //       fontSize: 30.sp,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),

          Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 37.w,
              ),
              Text(
                "روتيني",
                style: GoogleFonts.ruwudu(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   width: 5.w,
          // ),
          // Positioned(
          //   bottom: 5.h,
          //   left: 160.w,
          //   child: Text(
          //     "day planner",
          //     style: GoogleFonts.arvo(
          //       fontSize: 12.sp,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     textAlign: TextAlign.start,
          //   ),
          // )
        ],
      ),
    );
  }
}
