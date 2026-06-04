# 🧱 Mason Brick Guide — Feature Generator

> A tool to generate complete Clean Architecture features with a single command.

---

## 📋 Table of Contents

1. [Prerequisites](#-prerequisites)
2. [Initial Setup (Once)](#️-initial-setup-once)
3. [Generating a New Feature](#-generating-a-new-feature)
4. [Generated Files](#-generated-files)
5. [Post-Generation Steps](#-post-generation-steps)
6. [Full Practical Examples](#-full-practical-examples)
7. [FAQ](#-faq)

---

## ✅ Prerequisites

Make sure **Mason CLI** is installed on your machine:

```bash
dart pub global activate mason_cli
```

Verify the installation:
```bash
mason --version
```

---

## ⚙️ Initial Setup (Once)

From the **project root** (same directory as `mason.yaml`):

```bash
mason get
```

This command reads `mason.yaml` and installs the local brick:
```yaml
# mason.yaml (already exists in the project)
bricks:
  feature:
    path: bricks/feature
```

---

## 🚀 Generating a New Feature

### General Syntax

```bash
mason make feature --feature_name <snake_case> --entity_name <PascalCase>
```

### Variables

| Variable | Description | Format | Example |
|----------|-------------|--------|---------|
| `feature_name` | Feature name | `snake_case` | `order`, `user_profile` |
| `entity_name` | Main entity name | `PascalCase` | `Order`, `UserProfile` |

> **Rule:** `feature_name` is typically `entity_name` in lowercase.  
> Example: `feature_name=order` → `entity_name=Order`

### Quick Examples

```bash
# Orders feature
mason make feature --feature_name order --entity_name Order

# Notifications feature
mason make feature --feature_name notification --entity_name Notification

# Products feature
mason make feature --feature_name product --entity_name Product

# Compound name feature
mason make feature --feature_name medical_report --entity_name MedicalReport
```

### Interactive Mode (No Arguments)

```bash
mason make feature
```

Mason will prompt you to enter values manually:
```
Enter feature name (snake_case): order
Enter main entity name (PascalCase): Order
```

---

## 📁 Generated Files

Running the command with `feature_name=order` and `entity_name=Order` produces:

```
lib/features/order/
│
├── data/
│   ├── datasources/
│   │   └── order_remote_data_source.dart    ← Abstract class + Implementation
│   ├── models/
│   │   └── order_model.dart                  ← Extends OrderEntity + fromJson/toJson
│   └── repositories/
│       └── order_repository_impl.dart        ← Uses safeCall automatically
│
├── domain/
│   ├── entities/
│   │   └── order_entity.dart                 ← Equatable entity
│   ├── repositories/
│   │   └── order_repository.dart             ← Abstract interface
│   └── usecases/
│       └── get_orders_usecase.dart           ← UseCase<List<OrderEntity>, NoParam>
│
├── presentation/
│   ├── manager/order/
│   │   ├── order_cubit.dart                  ← Cubit with loadData()
│   │   └── order_state.dart                  ← Initial/Loading/Loaded/Error
│   ├── pages/
│   │   └── order_page.dart                   ← BlocProvider + BlocBuilder
│   └── widgets/
│       └── order_widgets.dart                ← Ready-made ListView
│
└── order_injection.dart                       ← GetIt registrations
```

**Total: 11 Dart files generated**

---

## 🔧 Post-Generation Steps

After generation, you need **3 manual steps** to complete the feature:

---

### Step 1 — Add the Endpoint

Open `lib/core/constants/api_endpoints.dart` and add:

```dart
class ApiEndpoints {
  static String baseUrlDev = Env.baseUrl;
  static String baseUrlProd = Env.baseUrl;
  static String apiKey = Env.apiKey;
  static const products = '/products';

  // ← Add your new feature endpoint
  static const orders = '/orders';
}
```

Then in the generated `order_remote_data_source.dart`, replace the TODO placeholder:
```dart
// Before (generated TODO):
final response = await _dio.get(ApiEndpoints.products); // ← change this

// After:
final response = await _dio.get(ApiEndpoints.orders);
```

---

### Step 2 — Register the Feature in DI

Open `lib/core/di/injection_container.dart` and add:

```dart
// Add the import
import '../../features/order/order_injection.dart';

Future<void> initCore() async {
  // ... existing code ...

  // Features
  initHome();
  initCart();
  initProfile();
  initOrder(); // ← Add this line
}
```

---

### Step 3 — Add the Route

Open `lib/config/routing/app_router.dart` and add:

```dart
// Add the import
import '../../features/order/presentation/pages/order_page.dart';

// Add a GoRoute inside branches or routes
GoRoute(
  path: '/orders',
  name: 'orders',
  builder: (context, state) => const OrderPage(),
),
```

---

## ✏️ Optional Steps (Customizing Generated Code)

### Fill in the Entity Fields

```dart
// lib/features/order/domain/entities/order_entity.dart

// Before (empty scaffold):
class OrderEntity extends Equatable {
  const OrderEntity();

  @override
  List<Object?> get props => [];
}

// After customization:
class OrderEntity extends Equatable {
  final int id;
  final String status;
  final double total;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.status,
    required this.total,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, status, total, createdAt];
}
```

### Fill in the Model fromJson / toJson

```dart
// lib/features/order/data/models/order_model.dart
factory OrderModel.fromJson(Map<String, dynamic> json) {
  return OrderModel(
    id: json['id'] as int,
    status: json['status'] as String,
    total: (json['total'] as num).toDouble(),
    createdAt: DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'status': status,
    'total': total,
    'created_at': createdAt.toIso8601String(),
  };
}
```

### Customize the Widget

```dart
// lib/features/order/presentation/widgets/order_widgets.dart
// Replace the simple ListTile with custom UI:
itemBuilder: (context, index) {
  final item = items[index];
  return OrderCard(order: item); // ← your custom widget
},
```

---

## 📖 Full Practical Examples

### Example 1 — Notifications Feature

```bash
mason make feature --feature_name notification --entity_name Notification
```

**Post-generation:**

```dart
// 1. api_endpoints.dart
static const notifications = '/notifications';

// 2. notification_remote_data_source.dart
final response = await _dio.get(ApiEndpoints.notifications);

// 3. injection_container.dart
import '../../features/notification/notification_injection.dart';
// inside initCore():
initNotification();

// 4. app_router.dart
import '../../features/notification/presentation/pages/notification_page.dart';
GoRoute(
  path: '/notifications',
  name: 'notifications',
  builder: (context, state) => const NotificationPage(),
),
```

---

### Example 2 — Medical Reports Feature (Compound Name)

```bash
mason make feature --feature_name medical_report --entity_name MedicalReport
```

Files are generated with the `medical_report` prefix:
```
lib/features/medical_report/
├── data/datasources/medical_report_remote_data_source.dart
├── data/models/medical_report_model.dart
├── domain/entities/medical_report_entity.dart
...
└── medical_report_injection.dart
```

```dart
// injection_container.dart
import '../../features/medical_report/medical_report_injection.dart';
initMedicalReport();
```

---

## ❓ FAQ

**Q: Will it overwrite existing files?**  
A: Yes, if the feature already exists. Mason will ask for confirmation before overwriting.

**Q: What if I made a typo in the name?**  
A: Delete the feature folder manually and re-run the command.

**Q: Can I add a Local Data Source?**  
A: The current template generates Remote only. Use `home_local_data_source.dart` in the `home` feature as a reference.

**Q: Why do I see red errors in VS Code inside the `bricks/` folder?**  
A: This is expected — template files contain `{{}}` Mustache syntax which is not valid Dart. This is already handled via `analysis_options.yaml` with `exclude: ['bricks/**']`.

**Q: What if I need additional use cases (Create, Delete, Update)?**  
A: Create them manually inside `domain/usecases/` following the same pattern as `get_orders_usecase.dart`.

---

## 🗂️ `mason.yaml` Structure

```yaml
# In the project root
bricks:
  feature:
    path: bricks/feature   ← path to the local brick
```

---

*This guide is for the `flutter_clean_architecture_template` project.*
