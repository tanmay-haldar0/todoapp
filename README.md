# 📝 Flutter Todo App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Material 3](https://img.shields.io/badge/Material%203-757575?style=for-the-badge&logo=material-design&logoColor=white)](https://m3.material.io)
[![SharedPreferences](https://img.shields.io/badge/SharedPreferences-FF6B6B?style=for-the-badge&logo=flutter&logoColor=white)](https://pub.dev/packages/shared_preferences)

## ✨ A beautiful, modern todo app built with Flutter

Stay organized with this elegant task management app featuring glass-morphism design, smooth animations, persistent storage, and a delightful user experience.

---

## 🌟 Features

### ✨ **Core Functionality**
- ➕ **Add Tasks** - Quick task creation with glass-morphism input field
- ✅ **Mark Complete** - Tap anywhere on task to toggle completion with smooth animations
- 🗑️ **Delete Tasks** - Swipe left to delete or use delete button
- 💾 **Persistent Storage** - Tasks saved automatically using SharedPreferences with JSON serialization
- 📊 **Progress Tracking** - Live completion counter in app bar ("X of Y completed")

### 🎨 **UI/UX Highlights**
- 🌈 **Gradient Background** - Beautiful green gradient (1B5E20 → 2E7D32 → 4CAF50 → 66BB6A)
- 🪟 **Glass-morphism Design** - Translucent white cards with blur effects
- 🎭 **Material 3 Design** - Modern, clean interface with rounded corners
- ✨ **Smooth Animations** - Staggered list entrance animations and smooth transitions
- 🎯 **Custom Checkboxes** - Beautiful animated checkboxes with check icons
- 📱 **Responsive Design** - Works perfectly on all screen sizes

### 🔧 **Technical Features**
- 🏗️ **State Management** - Efficient setState implementation with proper widget lifecycle
- 💾 **Local Storage** - JSON-based data persistence with fallback support
- 🎨 **Custom Animations** - TweenAnimationBuilder for smooth entrance effects
- 📦 **Minimal Dependencies** - Only uses shared_preferences for storage
- 🔄 **Data Migration** - Backward compatibility with plain text todos

---

## 📸 Screenshots

| Home Screen | Add Task | Completed Tasks |
|-------------|----------|-----------------|
| ![Home Screen](https://via.placeholder.com/300x600/2E7D32/FFFFFF?text=Home+Screen) | ![Add Task](https://via.placeholder.com/300x600/4CAF50/FFFFFF?text=Add+Task) | ![Completed Tasks](https://via.placeholder.com/300x600/66BB6A/FFFFFF?text=Completed) |

> 💡 **Tip**: Replace placeholder images with actual screenshots from your device

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-todoapp.git
   cd flutter-todoapp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 🎯 Usage

### Adding Tasks
1. Tap the glass-morphism input field at the top
2. Type your task description
3. Press the "+" button or hit Enter

### Managing Tasks
- **Complete**: Tap anywhere on a task card to toggle completion
- **Delete**: Swipe left on a task or tap the red delete icon
- **View Progress**: Check the live completion counter in the app bar

### Features in Action
- ✨ **Animations**: Watch tasks slide in with staggered entrance animations
- 🎨 **Visual Feedback**: Smooth checkbox animations and text strikethrough
- 🪟 **Glass Effect**: Beautiful translucent cards with subtle shadows
- 📱 **Responsive**: Works on phones, tablets, and different orientations

---

## 🏗️ Project Structure

```
lib/
└── main.dart                 # Complete app implementation
    ├── MyApp                # Root widget with theme configuration
    ├── TodoItem             # Data model with JSON serialization
    ├── TodoListPage         # Main screen state management
    └── _TodoListPageState   # State class with all functionality
```

### Key Components
- **`TodoItem`** - Data model with JSON serialization and backward compatibility
- **`TodoListPage`** - Main StatefulWidget with complete UI and logic
- **`_TodoListPageState`** - State management with SharedPreferences integration
- **Glass-morphism Input** - Custom input field with gradient add button
- **Animated Todo Cards** - Individual task widgets with Dismissible and InkWell
- **Empty State** - Beautiful animated placeholder when no tasks exist

---

## 🎨 Customization

### Colors
The app uses a beautiful green gradient theme. Customize colors in `main.dart`:

```dart
// App theme colors
colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32))

// App bar gradient
colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]

// Main background gradient
colors: [Color(0xFF2E7D32), Color(0xFF4CAF50), Color(0xFF66BB6A)]
stops: [0.0, 0.5, 1.0]

// Add button gradient
colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)]
```

### Animations
Modify animation durations in the `TweenAnimationBuilder` widgets:

```dart
// Staggered list animations
duration: Duration(milliseconds: 300 + (index * 50))

// Empty state animation
duration: Duration(milliseconds: 800)

// Checkbox animation
duration: Duration(milliseconds: 300)
```

---

## 🔧 Technical Details

### State Management
- Uses `setState()` for reactive UI updates
- Efficient state updates with minimal rebuilds
- Proper widget lifecycle management (initState, dispose)
- Persistent state restoration on app restart

### Data Persistence
- **Storage**: SharedPreferences for local data
- **Format**: JSON serialization with TodoItem.toJson()/fromJson()
- **Versioning**: Uses 'todos_v1' key for future migration support
- **Fallback**: Backward compatibility with plain text todos
- **Auto-save**: Automatic persistence on every change

### Performance
- **Optimized Lists**: ListView.separated with proper separators
- **Memory Management**: TextEditingController disposal
- **Smooth Animations**: TweenAnimationBuilder for 60fps transitions
- **Efficient Rendering**: Conditional rendering for empty state

---

## 🛠️ Development

### Adding New Features
1. **New Task Properties**: Extend `TodoItem` model with additional fields
2. **Categories**: Add category field and filtering UI
3. **Due Dates**: Integrate date picker and sorting functionality
4. **Priority Levels**: Add priority system with color coding
5. **Sync**: Add cloud storage integration (Firebase, etc.)
6. **Search**: Add search functionality for tasks
7. **Themes**: Implement multiple color themes

### Code Style
- Follows Flutter/Dart conventions
- Clean, readable code structure
- Comprehensive comments and documentation

---

## 📱 Platform Support

- ✅ **Android** - Full support with Material Design
- ✅ **iOS** - Full support with Cupertino adaptations
- ✅ **Web** - Responsive web app (experimental)
- ✅ **Desktop** - Windows, macOS, Linux support

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Ideas for Contributions
- 🎨 UI/UX improvements
- 🚀 Performance optimizations
- 📱 Platform-specific features
- 🧪 Unit and widget tests
- 📚 Documentation updates

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework
- **Material Design** - For the beautiful design system
- **Community** - For inspiration and feedback

---

## 📞 Contact

Made with ❤️ and Flutter

- [GitHub](https://github.com/yourusername)
- [LinkedIn](https://linkedin.com/in/yourprofile)
- [Email](mailto:your.email@example.com)