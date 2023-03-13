library ednet_code_generation;

import 'dart:io';
import 'package:ednet_core/ednet_core.dart';
import 'package:yaml/yaml.dart';

part 'src/ednet_code_generator.dart';

part 'src/doc_gen.dart';

part 'src/lib_gen.dart';

part 'src/test_gen.dart';

part 'src/web_gen.dart';

late String libraryName;
late String domainName;
String? outputDir;
late String modelName;

late CoreRepository ednetCoreRepository;
late Domain ednetCoreDomain;
late Model ednetCoreModel;

String? modelJson;
String? yamlString;
