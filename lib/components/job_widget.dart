import 'package:demo/model/job/job_model.dart';
import 'package:demo/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobWidget extends StatelessWidget {
  final JobModel jobModel;
  final Function(JobType) onChangeValue;

  const JobWidget(
      {Key? key, required this.jobModel, required this.onChangeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobModel.title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: () {
            onChangeValue(JobType.PENDING);
          },
          child: ListTile(
            leading: Radio(
              value: JobType.PENDING,
              groupValue: jobModel.type,
              onChanged: (value) {
                onChangeValue(JobType.PENDING);
              },
            ),
            title: Text('pending_job'.tr),
          ),
        ),
        InkWell(
          onTap: () {
            onChangeValue(JobType.DONE);
          },
          child: ListTile(
            leading: Radio(
              value: JobType.DONE,
              groupValue: jobModel.type,
              onChanged: (value) {
                onChangeValue(JobType.DONE);
              },
            ),
            title: Text('done_job'.tr),
          ),
        ),
      ],
    );
  }
}
