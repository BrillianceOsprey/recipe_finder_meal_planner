
# Recipe Finder Meal Planner(MealMatch)

## Overview

**Recipe Finder Meal Planner(MealMatch)** is a Flutter-based mobile application designed to help users organize their meals by assigning favorite recipes to each day of the week. It provides full offline support by storing data locally with Hive, and smartly detects online/offline status to always deliver the best user experience. The app connects to a recipe API when online, but remains fully functional when offline.

---

## Key Features

- **Meal Planning**  
  Assign recipes to any day of the week and organize your weekly meal plan.

- **Favorite Recipes**  
  Save recipes as favorites for easy access. Favorites are stored locally for offline use.

- **Automatic Connectivity Management**  
  The app detects your network status, fetching online data when possible and falling back to local data seamlessly.

- **Offline Support**  
  View and manage your favorites and meal plan even with no internet connection.

---

## Project Structure

- **Data Layer**: Handles data sources (local/remote) and repositories.
- **Domain Layer**: Contains data models and core business logic.
- **Presentation Layer**: UI and state management with Riverpod.

---

## Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/BrillianceOsprey/recipe_finder_meal_planner
   cd recipe_finder_meal_planner


2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Hive in main.dart**

   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Hive.initFlutter();
     Register your adapters here, e.g.:
     Hive.registerAdapter(RecipeAdapter());
     Hive.registerAdapter(MealPlanAdapter());
     runApp(const MyApp());
   }
   ```

4. **Run the App**

   ```bash
   flutter run
   ```

---

## Usage

### Meal Plan Management

* On startup, the app loads your meal plan from local storage.
* Add or remove recipes for any day with a simple UI.
* Clear a day or the whole week's meal plan at any time.

### Favorites

* Mark recipes as favorites from anywhere in the app.
* Favorites are available offline.
* Remove favorites easily.

### Connectivity Handling

* The app automatically shows locally saved data when offline.
* When you regain connectivity, data is refreshed automatically.

---

## API Integration

Integrates with the **Spoonacular API** (or a custom recipe API) for searching and fetching recipe details when online.

---

## Tech Stack

* **Flutter**: Cross-platform mobile framework
* **Riverpod**: Robust state management
* **Hive**: Lightweight, fast local storage
* **Connectivity Plus**: Network status management
* **Recipe API**: Online data source

---

## Contributing

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`.
3. Make your changes and commit: `git commit -am 'Add new feature'`.
4. Push the branch: `git push origin feature-branch`.
5. Open a Pull Request.

---

## Future Improvements

* User authentication & cloud sync
* More granular meal/ingredient planning
* Push notifications for reminders

---

## License

This project is licensed under the MIT License.

---



---

**Pro Tips:**
- Don’t forget to mention any required API keys if the recipe API needs one.
- Register your Hive adapters for each model you save locally (e.g. `Recipe`, `MealPlan`).
- If you have screenshots, add them to make your README even more attractive!

Let me know if you want to tweak or extend this further!

