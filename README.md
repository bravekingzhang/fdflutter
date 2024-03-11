# 对于 Flutter 快速开发框架的思考

yet another flutter fast development framework

要打造一个Flutter的快速开发框架，首先要思考的事情是一个快速开发框架需要照顾到哪些功能点，经过2天的思考，我大致整理了一下需要的能力：

- `状态管理`：很明显全局状态管理是不可或缺的，这个在前端领域上，几乎是一种不容置疑的方案沉淀，他就像人体的血液循环系统，连接了每个区域角落。
- `网络请求管理`：这个是标配了，对外的窗口，一般来讲做选型上需要注意可以支持请求拦截，支持响应拦截，以及错误处理机制，方便做重试等等。
- `路由管理`：可以说很多项目路由混乱不堪，导致难以维护，和这个功能脱不了干系，一般来讲，需要支持到页面参数传递，路由守卫的能力。
- `UI组件库`：在Flutter上，可能不太需要考虑这个，因为Flutter本身自己就是已这个为利刃的行家了，不过现在有些企业发布了自己的UI库，觉得可以跟一下。
- `数据持久化`：对于用户的一些设置，个性化配置，通常需要存在本地。而且，有时候，我们在做性能优化的时候，需要缓存网络请求到本地，以便，可以实现秒开页面，因此这依然也是一个不可获取的基础模块。
- `依赖注入`：很多情况下，为了便于管理和使用应用中的服务和数据模型，我们需要这个高级能力，但是属于偏高级点的能力了，所以是一个optional的，你可以不考虑。
- `国际化`：支持多语言开发，现在App一般都还是挺注重这块的，而且最好是立项的时候就考虑进来，为后续的出海做准备，因为这个越到后面，处理起来工作量越大。
- `测试框架`：支持单元测试、组件测试和集成测试，保证业务质量，自动化发现问题。
- `调试工具`：帮助开发者快速定位和解决问题，排查性能问题。
- `CI/CD集成`:支持持续集成和持续部署的解决方案，简化应用的构建、测试和发布过程。

那么，基于上面的分析，我就开始做了一些选型，这里基本上就是按照官方**Flutter Favorites ,**里面推荐的来选了。因为这些建议的库都是目前Flutter社区中比较流行和受欢迎的，能够提供稳定和高效的开发体验。

### 1. 状态管理：Riverpod


- **库名**: `flutter_riverpod`
- **描述**: 一个提供编译时安全、测试友好和易于组合的状态管理库。
- **选择理由**: Riverpod 是 Provider 的升级版，提供更好的性能和灵活性，但是说哪个更好，其实不能一概而论，毕竟不同的人会有不同的编码习惯。

```jsx
@riverpod
Future<String> boredSuggestion(BoredSuggestionRef ref) async {
  final response = await http.get(
    Uri.https('https://boredapi.com/api/activity'),
  );
  final json = jsonDecode(response.body);
  return json['activity']! as String;
}

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boredSuggestion = ref.watch(boredSuggestionProvider);
    // Perform a switch-case on the result to handle loading/error states
    return boredSuggestion.when(
      loading: () => Text('loading'),
      error: (error, stackTrace) => Text('error: $error'),
      data: (data) => Text(data),
    );
  }
}
```

### 2. 网络请求管理：Dio

- **库名**: `dio`
- **描述**: 一个强大的Dart HTTP客户端，支持拦截器、全局配置、FormData、请求取消等。
- **选择理由**: Dio 支持Restful API、拦截器和全局配置，易于扩展和维护。这个已经是老牌的网络请求库了，稳定的很，且支持流式传输，访问大模型也丝毫不马虎。

```jsx
final rs = await dio.get(
  url,
  options: Options(responseType: ResponseType.stream), // Set the response type to `stream`.
);
print(rs.data.stream); // Response stream.
```

### 3. 路由管理：routemaster

- **库名**: `routemaster`
- **描述**: 提供声明式路由解决方案，支持参数传递、路由守卫等。
- **选择理由**: url的方式访问，简化了路由管理的复杂度。

```jsx
'/protected-route': (route) =>
    canUserAccessPage()
      ? MaterialPage(child: ProtectedPage())
      : Redirect('/no-access'),
```

### 4. UI组件库：tdesign_flutter

- **库名**: `tdesign_flutter`
- **描述**: 腾讯TDesign Flutter技术栈组件库，适合在移动端项目中使用。。
- **选择理由**: 样式比原生的稍微好看且统一一些，大厂维护，减少一些在构建UI方面的复杂性。

### 5. 数据持久化：Hive

- **库名**: `hive`
- **描述**: 轻量级且高性能的键值对数据库。
- **选择理由**: Hive 提供了高性能的读写操作，无需使用SQL即可存储对象。

```jsx
var box = Hive.box('myBox');

box.put('name', 'David');

var name = box.get('name');

print('Name: $name');
```

### 6. 依赖注入：GetIt

- **库名**: `get_it`
- **描述**: 一个简单的服务注入，用于依赖注入。
- **选择理由**: GetIt 提供了灵活的依赖注入方式，易于使用且性能高效。

```jsx
final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppModel>(AppModel());

// Alternatively you could write it if you don't like global variables
  GetIt.I.registerSingleton<AppModel>(AppModel());
}

MaterialButton(
  child: Text("Update"),
  onPressed: getIt<AppModel>().update   // given that your AppModel has a method update
),
```

### 7. 国际化和本地化：flutter_localization

- **库名**: `flutter_localization`
- **描述**: Flutter官方提供的国际化和本地化支持。
- **选择理由**: 官方支持，集成简单，覆盖多种语言。

### 8. 测试和调试：flutter_test, mockito

- **库名**: `flutter_test` (内置), `mockito`
- **描述**: `flutter_test`提供了丰富的测试功能，`mockito`用于模拟依赖。
- **选择理由**: `flutter_test`是Flutter的官方测试库，`mockito`可以有效地模拟类和测试行为。

### 9. 日志系统：logger

- **库名**: `logger`
- **描述**: 提供简单而美观的日志输出。
- **选择理由**: `logger`支持不同级别的日志，并且输出格式清晰、美观。

### 10. CI/CD集成

CI/CD集成通常涉及外部服务，如GitHub Actions、Codemagic等，而非Flutter库。

### 目录规划

前面已经做完了选型，下来我们可以确立一下我们快速开发框架的目录结构，我们给框架取名为`fdflutter`，顾名思义，就是`fast development flutter`，如下：

```jsx
fdflutter/
├── lib/
│   ├── core/
│   │   ├── api/
│   │   │   └── api_service.dart
│   │   ├── di/
│   │   │   └── injection_container.dart
│   │   ├── localization/
│   │   │   └── localization_service.dart
│   │   ├── routing/
│   │   │   └── router.dart
│   │   └── utils/
│   │       └── logger.dart
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── local_datasource.dart
│   │   │   └── remote_datasource.dart
│   │   └── repositories/
│   │       └── example_repository.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── example_entity.dart
│   │   └── usecases/
│   │       └── get_example_data.dart
│   ├── presentation/
│   │   ├── pages/
│   │   │   └── example_page.dart
│   │   └── providers/
│   │       └── example_provider.dart
│   └── main.dart
├── test/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── pubspec.yaml
└── README.md

```

在这个结构中，我保持了核心功能、数据层、领域层和表示层的划分：

- **`core/api/`**: 使用**`Dio`**来实现**`ApiService`**，处理所有网络请求。
- **`core/di/`**: 使用**`GetIt`**来实现依赖注入，注册和获取依赖。
- **`core/localization/`**: 使用**`flutter_localization`**来实现本地化服务。
- **`core/routing/`**: 使用**`routemaster`**来实现路由管理。
- **`core/utils/`**: 使用**`logger`**来实现日志记录。
- **`data/`**: 数据层包含数据源和仓库，用于获取和管理数据。
- **`domain/`**: 领域层包含实体和用例，用于实现业务逻辑。
- **`presentation/`**: 表示层包含页面和`Provider`，用于显示UI和管理状态。
- **`test/`**: 测试目录包含各层的测试代码，使用**`flutter_test`**和**`mockito`**来编写测试。