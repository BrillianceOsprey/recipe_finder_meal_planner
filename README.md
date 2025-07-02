# Recipe Finder Meal Planner

## Overview

**Recipe Finder Meal Planner** is a Flutter-based mobile application designed to help users organize their meals by assigning favorite recipes to each day of the week. It provides full offline support by storing data locally with Hive, and smartly detects online/offline status to always deliver the best user experience. The app connects to a recipe API when online, but remains fully functional when offline.

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
