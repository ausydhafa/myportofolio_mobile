import 'package:material_ui/material_ui.dart';

import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project title.
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 16),

            // Display project image only when the URL is not empty.
            if (project.projectImageUrl.isNotEmpty)
              Image.network(
                project.projectImageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Unable to load project image.');
                },
              ),

            const SizedBox(height: 20),

            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 8),

            Text(project.description),

            const SizedBox(height: 20),

            const Text(
              'Technologies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 8),

            Text(project.techStack),

            const SizedBox(height: 20),

            const Text(
              'Project URL',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 8),

            SelectableText(project.projectUrl),
          ],
        ),
      ),
    );
  }
}
