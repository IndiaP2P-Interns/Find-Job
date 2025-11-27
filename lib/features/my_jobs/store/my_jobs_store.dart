import 'package:find_job/core/response_state.dart';
import 'package:find_job/features/home/domain/model/job.dart';
import 'package:mobx/mobx.dart';

part 'my_jobs_store.g.dart';

class MyJobsStore = _MyJobsStore with _$MyJobsStore;

abstract class _MyJobsStore with Store {
  @observable
  ObservableList<Job> appliedJobs = ObservableList<Job>();

  @observable
  ObservableList<Job> savedJobs = ObservableList<Job>();

  @observable
  Response<dynamic> state = Empty();

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchAppliedJobs() async {
    isLoading = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      appliedJobs.clear();
      appliedJobs.addAll([
        Job(
          id: '1',
          title: 'Senior Flutter Developer',
          description: 'We are looking for an experienced Flutter developer...',
          requiredSkills: ['Flutter', 'Dart', 'Firebase'],
          niceToHaveSkills: ['AWS', 'GraphQL'],
          location: 'New York, USA',
          isRemote: true,
          employmentType: 'Full-time',
          minExperience: 3,
          maxExperience: 5,
          minSalary: 120000,
          maxSalary: 150000,
          salaryCurrency: 'USD',
          company: 'Tech Corp',
          companyLogoUrl: '',
          expiresAt: DateTime.now().add(const Duration(days: 30)),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          viewsCount: 150,
          applicationsCount: 45,
          applied: true,
          applicationStatus: 'Interview',
          isSaved: true,
        ),
        Job(
          id: '2',
          title: 'Product Designer',
          description: 'Design beautiful interfaces...',
          requiredSkills: ['Figma', 'UI/UX'],
          niceToHaveSkills: ['Sketch'],
          location: 'San Francisco, CA',
          isRemote: false,
          employmentType: 'Contract',
          minExperience: 2,
          maxExperience: 4,
          minSalary: 90000,
          maxSalary: 110000,
          salaryCurrency: 'USD',
          company: 'Design Studio',
          companyLogoUrl: '',
          expiresAt: DateTime.now().add(const Duration(days: 15)),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          viewsCount: 89,
          applicationsCount: 12,
          applied: true,
          applicationStatus: 'Applied',
          isSaved: false,
        ),
      ]);
      
      state = Success(appliedJobs);
    } catch (e) {
      state = Error(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchSavedJobs() async {
    isLoading = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      savedJobs.clear();
      savedJobs.addAll([
        Job(
          id: '3',
          title: 'Backend Engineer',
          description: 'Build scalable APIs...',
          requiredSkills: ['Node.js', 'Express', 'MongoDB'],
          niceToHaveSkills: ['Docker', 'Kubernetes'],
          location: 'London, UK',
          isRemote: true,
          employmentType: 'Full-time',
          minExperience: 4,
          maxExperience: 6,
          minSalary: 60000,
          maxSalary: 80000,
          salaryCurrency: 'GBP',
          company: 'FinTech Solutions',
          companyLogoUrl: '',
          expiresAt: DateTime.now().add(const Duration(days: 20)),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          viewsCount: 200,
          applicationsCount: 60,
          applied: false,
          applicationStatus: '',
          isSaved: true,
        ),
        // Include the saved job from applied list for consistency if needed
        // For now, keeping lists separate for simplicity
      ]);
      
      state = Success(savedJobs);
    } catch (e) {
      state = Error(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  void toggleSaveJob(Job job) {
    if (job.isSaved) {
      savedJobs.removeWhere((element) => element.id == job.id);
      job.isSaved = false;
    } else {
      job.isSaved = true;
      savedJobs.add(job);
    }
    // In a real app, this would call an API
  }
}
