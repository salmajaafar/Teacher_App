import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_app/controllers/home_controller.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/BottomCurveClipper.dart'; // Assuming this is used for general UI elements
import 'package:parent_app/views/widget/HomeHeader.dart'; // Assuming this widget exists
import 'package:parent_app/views/widget/ScheduleCard.dart'; // Assuming this widget exists
import 'package:parent_app/views/widget/SectionTitle.dart';

// --- View: Main Screen ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the controller
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: ColorsApp.creamBase,
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              HomeHeader(controller: controller), // Assuming HomeHeader is defined elsewhere
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const SectionTitle(title: 'ADVERTISEMENTS'),
                      SizedBox(height: 10.h),
                      AdsCarousel(controller: controller),
                      const CarouselIndicator(),
                      SizedBox(height: 20.h),
                      ActionCardsGrid(controller: controller), // New section for action cards
                      SizedBox(height: 24.h),
                      const SectionTitle(title: 'SCHEDULES'),
                      SizedBox(height: 10.h),
                      SchedulesGrid(controller: controller),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// --- View Component: Ads Carousel ---
class AdsCarousel extends StatelessWidget {
  final HomeController controller;
  const AdsCarousel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160.h,
        viewportFraction: 1,
        enlargeCenterPage: true,
        onPageChanged: (i, _) => controller.onCarouselChanged(i),
      ),
      items: controller.announcements.map((ad) => AdCard(ad: ad)).toList(),
    );
  }
}

// --- View Component: Ad Card ---
class AdCard extends StatelessWidget {
  final dynamic ad;
  const AdCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: ColorsApp.dustyRose,
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ad['title'] ?? "",
                  style: TextStyle(
                    fontFamily: 'KiwiMaru',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.bgPureWhite,
                  ),
                ),
              ),
              Text(
                (ad['createdAt'] as String?)?.split('T')[0] ?? "",
                style: TextStyle(
                  fontSize: 9.sp,
                  color: ColorsApp.bgPureWhite.withOpacity(0.7),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            ad['body'] ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.sp,
              color: ColorsApp.bgPureWhite.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.person, size: 12.sp, color: ColorsApp.bgPureWhite.withOpacity(0.8)),
              SizedBox(width: 4.w),
              Text(
                "By: ${ad['senderName'] ?? "Unknown"}",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsApp.bgPureWhite.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- View Component: Carousel Indicator ---
class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            controller.announcements.length,
            (i) => Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.carouselIndex.value == i
                    ? ColorsApp.PraimaryMain
                    : ColorsApp.dustyRose.withOpacity(0.4),
              ),
            ),
          ),
        ));
  }
}

// --- New View Component: Action Cards Grid ---
class ActionCardsGrid extends StatelessWidget {
  final HomeController controller;
  const ActionCardsGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionCard(
              icon: Icons.menu_book,
              title: 'Sending what was given',
              subtitle: 'Confirm the lessons that have been given and track your progress in the lessons',
              onTap: () => controller.openLessonsGiven(),
              color: ColorsApp.bgSoftPeach, // Adjust color as per design
            ),
            SizedBox(width: 10.w), // Spacing between cards
            ActionCard(
              icon: Icons.edit_note,
              title: 'Sending homework or a note',
              subtitle: 'Assigning and specifying homework tasks',
              onTap: () => controller.openHomework(),
              color: ColorsApp.bgSoftPeach, // Adjust color as per design
            ),
          ],
        ),
        SizedBox(height: 10.h), // Spacing between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionCard(
              icon: Icons.person_outline,
              title: 'Send a note about a student',
              subtitle: 'Keep parents informed about their children\'s behavior',
              onTap: () => controller.openStudentNotes(),
              color: ColorsApp.bgSoftPeach, // Adjust color as per design
            ),
          ],
        ),
      ],
    );
  }
}

// --- New View Component: Action Card ---
class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120.h, // Fixed height for consistency
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: ColorsApp.PraimaryMain, // Icon color as per design
                size: 24.sp,
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'KiwiMaru',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textDarkBrown,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8.sp,
                  color: ColorsApp.textDarkBrown.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- View Component: Schedules Grid ---
class SchedulesGrid extends StatelessWidget {
  final HomeController controller;
  const SchedulesGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(controller.schedules.length, (i) {
        return Expanded(
          child: ScheduleCard(
            title: controller.schedules[i],
            isFirst: i == 0,
            onTap: () => controller.openSchedule(i),
          ),
        );
      }),
    );
  }
}

// --- View Component: Schedule Card ---
// Assuming ScheduleCard is defined in 'package:parent_app/views/widget/ScheduleCard.dart'
// and has properties: title, isFirst, onTap
