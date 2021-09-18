import 'package:demo/components/job_widget.dart';
import 'package:demo/controller/all_job/job_controller.dart';
import 'package:demo/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class PendingJobView extends StatelessWidget {
  final JobController _jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(
        () => Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "pending_job".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 26),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                  _jobController.getListJobModel(JobType.PENDING).length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JobWidget(
                        jobModel: _jobController
                            .getListJobModel(JobType.PENDING)[index],
                        onChangeValue: (value) {
                          _jobController
                              .getListJobModel(JobType.PENDING)[index]
                              .type = value;
                          _jobController
                              .updateValue(_jobController.jobModels[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
