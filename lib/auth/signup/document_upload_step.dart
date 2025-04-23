import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:ridehailing_driver/theme/contants.dart';

const double defaultPadding = 16.0;

class DocumentUploadStep extends StatelessWidget {
  final VoidCallback onUploadGhanaCard;
  final VoidCallback onUploadInsurance;
  final VoidCallback onUploadRoadworthiness;
  final VoidCallback onUploadVIT;

  const DocumentUploadStep({
    super.key,
    required this.onUploadGhanaCard,
    required this.onUploadInsurance,
    required this.onUploadRoadworthiness,
    required this.onUploadVIT,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _animatedDocumentCard(
            context,
            title: "Ghana Card",
            description: "Please upload a front view of your Ghana Card",
            onUpload: onUploadGhanaCard,
          ),
          _animatedDocumentCard(
            context,
            title: "Proof of Insurance *",
            description:
                "Third party or comprehensive insurance. Contact your local provider for help.",
            onUpload: onUploadInsurance,
          ),
          _animatedDocumentCard(
            context,
            title: "Roadworthiness Sticker *",
            description:
                "You can bring this to training instead. More info at ",
            linkText: "dvla.gov.gh",
            onUpload: onUploadRoadworthiness,
          ),
          _animatedDocumentCard(
            context,
            title: "Vehicle Income Tax (VIT) Sticker",
            description:
                "Issued by GRA for commercial vehicles. Visit a Domestic Tax Revenue office.",
            onUpload: onUploadVIT,
          ),
        ],
      ),
    );
  }

  Widget _animatedDocumentCard(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onUpload,
    String? linkText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: const Duration(milliseconds: 500),
        openBuilder:
            (context, _) => const Scaffold(
              // You can replace this with an upload preview page
              body: Center(child: Text("Upload Preview Coming Soon")),
            ),
        closedElevation: 4,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        closedColor: Colors.white,
        closedBuilder:
            (context, openContainer) => InkWell(
              onTap: openContainer,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: description),
                          if (linkText != null)
                            TextSpan(
                              text: linkText,
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file_rounded),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: onUpload,
                      label: const Text(
                        "Upload file",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
