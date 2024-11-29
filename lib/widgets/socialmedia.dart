import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.url,
  });

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: FaIcon(icon, color: Colors.white, size: 25),
      ),
    );
  }
}