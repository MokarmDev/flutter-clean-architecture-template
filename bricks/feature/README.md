# 🧱 Feature Brick — Clean Architecture Generator

Generate a **complete, production-ready feature** in one command, following this project's exact Clean Architecture patterns.

---

## 📦 Generated Files (11 files)

```
lib/features/{feature_name}/
├── data/
│   ├── datasources/
│   │   └── {feature_name}_remote_data_source.dart   ← abstract + impl
│   ├── models/
│   │   └── {entity_name}_model.dart                 ← extends entity + fromJson/toJson
│   └── repositories/
│       └── {feature_name}_repository_impl.dart      ← uses safeCall
├── domain/
│   ├── entities/
│   │   └── {entity_name}_entity.dart                ← Equatable entity
│   ├── repositories/
│   │   └── {feature_name}_repository.dart           ← abstract interface
│   └── usecases/
│       └── get_{entity_name}s_usecase.dart          ← UseCase<List<Entity>, NoParam>
├── presentation/
│   ├── manager/{entity_name}/
│   │   ├── {entity_name}_cubit.dart                 ← Cubit with loadData()
│   │   └── {entity_name}_state.dart                 ← Initial/Loading/Loaded/Error
│   ├── pages/
│   │   └── {feature_name}_page.dart                 ← BlocProvider + BlocBuilder
│   └── widgets/
│       └── {feature_name}_widgets.dart              ← ListView widget
└── {feature_name}_injection.dart                    ← GetIt registrations
```

---

## 🚀 Usage

### Step 1 — Make sure Mason is installed
```bash
dart pub global activate mason_cli
```

### Step 2 — Install the Bricks (Only once)
```bash
mason get
```

### Step 3 — Generate a new feature
```bash
# Syntax:
mason make feature --feature_name <snake_case_name> --entity_name <PascalCaseName>

# Examples:
mason make feature --feature_name auth --entity_name Auth
mason make feature --feature_name product --entity_name Product
mason make feature --feature_name order --entity_name Order
mason make feature --feature_name notification --entity_name Notification
```

---

## ✅ Post-Generation — Only 3 steps

### 1. Add the endpoint in `core/constants/api_endpoints.dart`
```dart
static const String orders = '/orders';
```

### 2. Register the feature in `core/di/injection_container.dart`
```dart
import '../../features/order/order_injection.dart';

Future<void> initCore() async {
  // ...
  initOrder(); 
}
```

### 3. Add the Route in `config/routing/app_router.dart`
```dart
import '../../features/order/presentation/pages/order_page.dart';

GoRoute(
  path: '/orders',
  name: 'orders',
  builder: (context, state) => const OrderPage(),
),
```

---

## 📝 Notes
- `{entity_name}_model.dart` contains empty `fromJson` and `toJson` methods — complete them according to your API
- The entity is simple — add the fields you need
- Works automatically with `safeCall` located in `core/utils/safe_call.dart`
