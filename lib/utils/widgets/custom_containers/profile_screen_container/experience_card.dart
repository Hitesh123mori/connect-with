import 'package:connectwith/models/user/experience.dart';
import 'package:connectwith/utils/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../helper_functions/date_formate.dart';

class ExperienceCard extends StatefulWidget {
  final Experience experience;
  const ExperienceCard({super.key, required this.experience});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.theme['secondaryColor']?.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company name and logo
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.theme['primaryColor']?.withOpacity(0.2),
                child: Icon(Icons.business, color: AppColors.theme['primaryColor']),
              ),
              SizedBox(width: 10),
              // Company name and total duration
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.experience.companyName ?? "Company Name",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${_calculateTotalDuration()}",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Timeline for positions
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              children: widget.experience.positions!.map((position) {
                final isLast = position == widget.experience.positions!.last;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Column(
                        children: [
                          // Timeline dot
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.theme['primaryColor'],
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 50,
                              color: AppColors.theme['primaryColor']?.withOpacity(0.5),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    // Position details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            position.title ?? "Position Name",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${position.startDate ?? "Start Date"} - ${position.endDate ?? "End Date"} - ${_calculateDuration((position.startDate ?? "") , (position.endDate ?? ""))}",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            position.location ?? "Location",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          if (position.skills != null)
                            Wrap(
                              children: position.skills!.asMap().entries.map((entry) {
                                final index = entry.key;
                                final skill = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        skill,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (index != position.skills!.length - 1)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            "•", // Dot separator
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotalDuration() {
    final positions = widget.experience.positions;
    if (positions == null || positions.isEmpty) return "Duration not available";

    int totalDays = 0;

    for (var position in positions) {
      DateTime? start = _parseDate(position.startDate ?? "");
      DateTime? end = _parseEndDate(position.endDate ?? "");

      if (start != null && end != null) {
        final duration = end.difference(start);
        totalDays += duration.inDays;
      }
    }

    if (totalDays == 0) return "Duration not available";

    final years = totalDays ~/ 365;
    final months = (totalDays % 365) ~/ 30;

    return "${years > 0 ? "$years yr " : ""}${months > 0 ? "$months mos" : ""}";
  }

  String _calculateDuration(String startDate, String endDate) {
    DateTime? start = _parseDate(startDate);
    DateTime? end = _parseEndDate(endDate);

    if (start == null || end == null) return "Duration not available";

    final duration = end.difference(start);
    final years = duration.inDays ~/ 365;
    final months = (duration.inDays % 365) ~/ 30;

    return "${years > 0 ? "$years yr " : ""}${months > 0 ? "$months mos" : ""}";
  }

  DateTime? _parseDate(String date) {
    try {
      final parts = date.split(' ');
      if (parts.length != 2) return null;

      final month = parts[0];
      final year = parts[1];

      final monthInt = _monthToInt(month);

      if (monthInt == null) return null;

      return DateTime(int.parse(year), monthInt, 1);
    } catch (_) {
      return null;
    }
  }

  DateTime? _parseEndDate(String endDate) {
    if (endDate == "Present") {
      return DateTime.now();
    } else {
      return _parseDate(endDate);
    }
  }

  int? _monthToInt(String month) {
    const months = {
      "Jan": 1,
      "Feb": 2,
      "Mar": 3,
      "Apr": 4,
      "May": 5,
      "Jun": 6,
      "Jul": 7,
      "Aug": 8,
      "Sep": 9,
      "Oct": 10,
      "Nov": 11,
      "Dec": 12,
    };
    return months[month];
  }
}
