// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:parent_app/controllers/profile_controller.dart';
// import 'package:parent_app/core/colorsApp.dart';
// import 'package:parent_app/views/widget/buttonStyle.dart';
// import 'package:parent_app/views/widget/semi_circle_header.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(ProfileController());

//     return Scaffold(
//       backgroundColor: ColorsApp.creamBase,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.bottomCenter,
//               children: [
//                 const SemiCircleHeader(title: 'PROFILE'),
//                 Positioned(
//                   bottom: -48.h,
//                   child: CircleAvatar(
//                     radius: 48.r,
//                     backgroundColor: ColorsApp.bgPureWhite,
//                     child: CircleAvatar(
//                       radius: 44.r,
//                       backgroundColor: ColorsApp.bgSoftPeach,
//                       child: Icon(Icons.person, size: 48.sp, color: ColorsApp.PraimaryMain),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 58.h),
//             Obx(() => Text(
//                   c.name.value,
//                   style: TextStyle(
//                     fontFamily: 'KiwiMaru',
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w800,
//                     color: ColorsApp.textDarkBrown,
//                   ),
//                 )),
//             SizedBox(height: 20.h),
//             Obx(() => _infoField('PHONE', c.phone.value)),
//             SizedBox(height: 12.h),
//             Obx(() => _infoField('EMAIL', c.email.value)),
//             SizedBox(height: 20.h),
//             _tagSection('THE GRADES HE/SHE STUDIES:', c.grades),
//             SizedBox(height: 16.h),
//             _tagSection('THE SUBJECTS HE/SHE STUDIES:', c.subjects),
//             SizedBox(height: 30.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: CustomButton(
//                 width: double.infinity,
//                 textButton: 'Log out',
//                 icon: Icons.logout,
//                 onPressed: c.logout,
//               ),
//             ),
//             SizedBox(height: 24.h),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoField(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//         decoration: BoxDecoration(
//           color: ColorsApp.bgPureWhite,
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: RichText(
//                 text: TextSpan(
//                   style: TextStyle(
//                     fontFamily: 'KiwiMaru',
//                     fontSize: 12.sp,
//                     color: ColorsApp.textDarkBrown,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: '$label: ',
//                       style: const TextStyle(fontWeight: FontWeight.w800),
//                     ),
//                     TextSpan(text: value),
//                   ],
//                 ),
//               ),
//             ),
//             Icon(Icons.edit, color: ColorsApp.PraimaryMain, size: 20.sp),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _tagSection(String title, RxList<String> list) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontFamily: 'KiwiMaru',
//               fontSize: 11.sp,
//               fontWeight: FontWeight.w700,
//               color: ColorsApp.textDarkBrown,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Obx(() => Wrap(
//                 spacing: 8.w,
//                 runSpacing: 8.h,
//                 children: list
//                     .map((t) => Container(
//                           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                           decoration: BoxDecoration(
//                             color: ColorsApp.bgSoftPeach,
//                             borderRadius: BorderRadius.circular(20.r),
//                           ),
//                           child: Text(
//                             t,
//                             style: TextStyle(
//                               fontFamily: 'KiwiMaru',
//                               fontSize: 10.sp,
//                               color: ColorsApp.PraimaryMain,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               )),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_app/controllers/profile_controller.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/buttonStyle.dart';
import 'package:parent_app/views/widget/semi_circle_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: ColorsApp.creamBase,
      body: Obx(() => c.isLoading.value 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                const SemiCircleHeader(title: 'PROFILE'),
                Positioned(
                  bottom: -48.h,
                  child: CircleAvatar(
                    radius: 48.r,
                    backgroundColor: ColorsApp.bgPureWhite,
                    child: CircleAvatar(
                      radius: 44.r,
                      backgroundColor: ColorsApp.bgSoftPeach,
                      child: Icon(Icons.person, size: 48.sp, color: ColorsApp.PraimaryMain),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 58.h),
            Obx(() => Text(
                  c.name.value,
                  style: TextStyle(
                    fontFamily: 'KiwiMaru',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: ColorsApp.textDarkBrown,
                  ),
                )),
            SizedBox(height: 20.h),
            Obx(() => _infoField('PHONE', c.phone.value)),
            SizedBox(height: 12.h),
            Obx(() => _infoField('EMAIL', c.email.value)),
            SizedBox(height: 20.h),
            _tagSection('THE GRADES HE/SHE STUDIES:', c.grades),
            SizedBox(height: 16.h),
            _tagSection('THE SUBJECTS HE/SHE STUDIES:', c.subjects),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomButton(
                width: double.infinity,
                textButton: 'Log out',
                icon: Icons.logout,
                onPressed: c.logout,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      )),
    );
  }

  Widget _infoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: ColorsApp.bgPureWhite,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'KiwiMaru',
                    fontSize: 12.sp,
                    color: ColorsApp.textDarkBrown,
                  ),
                  children: [
                    TextSpan(
                      text: '$label: ',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    TextSpan(text: value),
                  ],
                ),
              ),
            ),
            Icon(Icons.edit, color: ColorsApp.PraimaryMain, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _tagSection(String title, RxList<String> list) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'KiwiMaru',
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: ColorsApp.textDarkBrown,
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() => Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: list
                    .map((t) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: ColorsApp.bgSoftPeach,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            t,
                            style: TextStyle(
                              fontFamily: 'KiwiMaru',
                              fontSize: 10.sp,
                              color: ColorsApp.PraimaryMain,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }
}