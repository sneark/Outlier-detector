# Outlier Detector 

A high-performance Flutter application capable of finding an outlier integer in a massive dataset. 
Designed with **Clean Architecture** + **MVVM**.

## 📂 Project Structure

```text
lib/
├── core/
│   └── widgets/
│       └── loader_view.dart
├── features/
│   └── outlier_detection/
│       ├── data/
│       │   └── string_input_parser.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── outlier_error.dart
│       │   ├── services/
│       │   │   └── outlier_service.dart
│       │   └── usecases/
│       │       └── outlier_detection_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   ├── main_page.dart
│           │   └── result_page.dart
│           └── viewmodels/
│               └── main_view_model.dart
├── app.dart
└── main.dart
