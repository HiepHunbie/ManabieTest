import 'package:demo/model/job/job_model.dart';
import 'package:demo/utils/constants.dart';
import 'package:get/get.dart';

class JobController extends GetxController {

  var jobModels = [
    JobModel(1,"Công việc số 1", JobType.DONE),
    JobModel(2,"Công việc số 2", JobType.DONE),
    JobModel(3,"Công việc số 3", JobType.PENDING),
    JobModel(4,"Công việc số 4", JobType.PENDING),
    JobModel(5,"Công việc số 5", JobType.DONE),
    JobModel(6,"Công việc số 6", JobType.PENDING),
    JobModel(7,"Công việc số 7", JobType.DONE),
    JobModel(8,"Công việc số 8", JobType.DONE),
  ].obs;

  List<JobModel> getListJobModel(JobType jobType){
    return jobModels.where((e) => e.type == jobType).map((e) => e).toList();
  }

  void updateValue(JobModel jobModel){
    for(int i = 0; i< jobModels.length; i++){
      if(jobModels[i].id == jobModel.id){
        jobModels[i] = jobModel;
        break;
      }
    }
    update();
  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}