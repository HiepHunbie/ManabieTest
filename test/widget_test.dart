import 'dart:io';
import 'package:demo/controller/all_job/job_controller.dart';
import 'package:demo/controller/home/home_controller.dart';
import 'package:demo/model/job/job_model.dart';
import 'package:demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:matcher/matcher.dart' as m;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
  });

  final bindingJob = BindingsBuilder(() {
    Get.lazyPut<JobController>(() => JobController());
  });

  // HomeController
  test('Test Binding HomeController', () {
    expect(Get.isPrepared<HomeController>(), false);

    binding.builder();

    expect(Get.isPrepared<HomeController>(), true);

    Get.reset();
  });
  test('Test HomeController', () async {
    /// Controller can't be on memory
    expect(() => Get.find<HomeController>(), throwsA(m.TypeMatcher<String>()));

    /// build Binding
    binding.builder();

    /// recover your controller
    final controller = Get.find<HomeController>();

    /// check if onInit was called
    expect(controller.initialized, true);
  });

  test('init Data HomeController', () async {
    final controller = Get.find<HomeController>();
    expect(0, controller.tabIndex.value);
  });

  test('changeTabIndex HomeController', () async {
    final controller = Get.find<HomeController>();
    controller.changeTabIndex(1);
    expect(1, controller.tabIndex.value);
  });

  // JobController
  test('Test Binding JobController', () {
    expect(Get.isPrepared<JobController>(), false);

    bindingJob.builder();

    expect(Get.isPrepared<JobController>(), true);

    Get.reset();
  });

  test('Test JobController', () async {
    expect(() => Get.find<JobController>(), throwsA(m.TypeMatcher<String>()));

    bindingJob.builder();

    final controller = Get.find<JobController>();

    expect(controller.initialized, true);
  });

  test('init Data JobController', () async {
    final controller = Get.find<JobController>();
    expect(1, controller.jobModels[0].id);
    expect(8, controller.jobModels.length);
  });

  test('updateValue JobController', () async {
    final controller = Get.find<JobController>();
    JobModel jobModel = JobModel(1, "Công việc số 1", JobType.PENDING);
    controller.updateValue(jobModel);
    expect(JobType.PENDING, controller.jobModels[0].type);
  });
}
