import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void setSnackbar(String msg, BuildContext context, int isColorSuccess) {
  Color snackbarColor;
  IconData iconData;

  switch (isColorSuccess) {
    case 0:
      snackbarColor = Colors.green;
      iconData = Icons.task_alt;
      break;
    case 1:
      snackbarColor = Colors.orangeAccent;
      iconData = Icons.warning;
      break;
    case 2:
      snackbarColor = Colors.red;
      iconData = Icons.dangerous;
      break;
    default:
      snackbarColor = Colors.grey;
      iconData = Icons.info;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              msg,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
        ],
      ),
      backgroundColor: snackbarColor,
      elevation: 10,
      duration: Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
    ),
  );
}
