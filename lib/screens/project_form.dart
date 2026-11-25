import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';

  bool _isSubmitting = false;

  /// Validate HTTP and HTTPS URLs.
  String? _validateUrl(String? value, {bool optional = false}) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return optional ? null : 'URL cannot be empty!';
    }

    final uri = Uri.tryParse(text);

    if (uri == null ||
        !uri.hasScheme ||
        !['http', 'https'].contains(uri.scheme.toLowerCase()) ||
        uri.host.isEmpty) {
      return 'Enter a valid HTTP or HTTPS URL!';
    }

    return null;
  }

  Future<void> _submit() async {
    // Validate all form fields.
    if (!_formKey.currentState!.validate()) return;

    // Save field values.
    _formKey.currentState!.save();

    // Check authentication before submitting.
    final allowed = await ensureLoggedIn(context);

    if (!mounted || !allowed) return;

    // Obtain the current token.
    final authState = context.read<AuthState>();

    final token = authState.token;

    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Create the Project object.
      final newProject = Project(
        title: _title.trim(),
        description: _description.trim(),
        techStack: _techStack.trim(),
        projectUrl: _projectUrl.trim(),
        projectImageUrl: _projectImageUrl.trim(),
      );

      // Send authenticated POST request to Django.
      final createdProject = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );

      if (!mounted) return;

      // Show confirmation after successful creation.
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Project successfully created!'),
            content: Text(
              'Your project "${createdProject.title}" '
              'has been saved to Django.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      // Return to the previous screen.
      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;

      // If token is invalid, clear the session and request login again.
      if (e.statusCode == 401) {
        try {
          await context.read<AuthState>().logout();
        } catch (_) {
          // AuthState clears the local token in finally.
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your session expired. Please log in again.'),
          ),
        );

        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to create project. '
              'HTTP status: ${e.statusCode}',
            ),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to connect to the server.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      drawer: const LeftDrawer(),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter project title',
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _title = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title cannot be empty!';
                    }

                    return null;
                  },
                ),
              ),

              // Description.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Describe your project',
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _description = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description cannot be empty!';
                    }

                    return null;
                  },
                ),
              ),

              // Tech Stack.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Flutter, Django, Python',
                    labelText: 'Tech Stack',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _techStack = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tech Stack cannot be empty!';
                    }

                    return null;
                  },
                ),
              ),

              // Project URL.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    hintText: 'https://example.com',
                    labelText: 'Project URL',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _projectUrl = value ?? '';
                  },
                  validator: (value) => _validateUrl(value),
                ),
              ),

              // Optional Project Image URL.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    hintText: 'https://example.com/image.png',
                    labelText: 'Project Image URL (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _projectImageUrl = value ?? '';
                  },
                  validator: (value) => _validateUrl(value, optional: true),
                ),
              ),

              const SizedBox(height: 16),

              // Submit button.
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save Project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
