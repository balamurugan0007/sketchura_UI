# 🎨 Sketchura UI

### A modern Flutter UI toolkit for faster and cleaner app development

![Preview](assets/cover.jpg)


`sketchura_ui` is a Flutter UI builder package that helps developers **reduce boilerplate code** and **build beautiful interfaces quickly**.  
It provides **simple, reusable, and customizable UI components** designed to make your development workflow smoother and more efficient.

---
Documentation Website URL
[Link Text](https://sketchura-ui.vercel.app/)


## 🚀 Features

- 🧩 Reusable and customizable widgets  
- 🎨 Modern UI design with flexible styling  
- ⚡ Easy integration with existing Flutter apps  
- 🛠️ Reduces boilerplate and simplifies UI building  
- 💻 Developer-friendly APIs with clean structure  

---

## 📦 Installation

Add this line to your **pubspec.yaml**:

```yaml
dependencies:
  sketchura_ui: ^0.0.5
```


# 🌟 SkResponsive

A **responsive utility class** for Flutter, inspired by Tailwind CSS breakpoints, providing easy identification of screen sizes, device types, and adaptive sizing for padding, fonts, gaps, icons, and containers.Check More About 
[SkResponsive](https://sketchura-ui.vercel.app/#/ResposiveUtils)

---

## 🔹 Example Usage

```dart
// Identify screen size
final sizeName = SkResponsive.getScreenSize(context); // 'sm', 'md', etc.

// Check device type
bool isMobile = SkResponsive.isMobile(context);
bool isTablet = SkResponsive.isTablet(context);
bool isDesktop = SkResponsive.isDesktop(context);

// Get adaptive double value
double fontSize = SkResponsive.valueDouble(
  context,
  mobile: 14.0,
  tablet: 16.0,
  desktop: 18.0,
);

// Get adaptive int value
int columns = SkResponsive.valueInt(
  context,
  mobile: 2,
  tablet: 3,
  desktop: 4,
);

// Generic responsive value
T value = SkResponsive.value<String>(
  context,
  mobile: 'small',
  tablet: 'medium',
  desktop: 'large',
);

// Adaptive padding and gaps
EdgeInsets padding = SkResponsive.identifyPadding(context);
EdgeInsets hPadding = SkResponsive.identifyHorizontalPadding(context);
SizedBox gap = SkResponsive.identifyGap(context);

// Adaptive icon size
double iconSize = SkResponsive.identifyIconSize(context);

// Adaptive container width
double containerWidth = SkResponsive.identifyContainerWidth(context);

// Check breakpoints
bool largerThanMd = SkResponsive.isLargerThan(context, 'md');
bool smallerThanLg = SkResponsive.isSmallerThan(context, 'lg');

// Get scale factor for responsive sizing
double scale = SkResponsive.getScaleFactor(context);
```

# 🚀 Sketchura Buttons

Beautiful, customizable, and developer-friendly button components built for **Flutter** — designed to speed up your UI development with clean design, modern style, and flexible customization.

---

## 🌈 Overview

The `Sketchura Buttons` package provides four elegant button components:

| Button Type       | Description |
|--------------------|-------------|
| **`SkFilledButton`** | For primary actions — filled with your app’s main color |
| **`SkOutlinedButton`** | For secondary actions — outlined border style |
| **`SkTextButton`** | For minimal inline or tertiary actions |
| **`SkIconButton`** | For icon + text combinations — perfect for CTAs and menus |

Check More About SkButtons
[SkButtons](https://sketchura-ui.vercel.app/#/button)

All buttons are built with **Material + InkWell** interactions, ensuring native Flutter ripple effects and consistent behavior across devices.


---
## ✨ Features

- 🎨 Multiple button types: Filled, Outlined, Text  
- ⚡ Ripple effect on tap  
- 🔹 Customizable colors, borders, radius, and padding  
- 🧠 Supports icons, text, and custom child widgets  
- 🖥️ Works in forms, dialogs, and anywhere buttons are needed  

---

## 🚀 Example Usage

```dart
SkButton(
  label: "Submit",
  onTap: () {
    print("Button pressed");
  },

)
```

# 🧩 SkInput

A **modern, reusable, and customizable input field** for Flutter — part of the **Sketchura UI Library**.  
`SkInput` helps you build beautiful, consistent form fields faster with support for icons, validation, titles, and outlined styles. Check More About SkInput Widget
[SkInput](https://sketchura-ui.vercel.app/#/input)

---


## ✨ Features

- 🏷️ Optional **title** with a required `*` indicator  
- 🔒 Supports **password fields** (`obscureText`)  
- 🎨 **Outlined** or **flat** input styles  
- 🧠 Built-in **validation** support  
- 🧱 **Prefix / suffix icons**  
- ⚙️ Fully **customizable**: colors, borders, radius, text styles, and size  

---


## 🚀 Example Usage

```dart
import 'package:flutter/material.dart';
import "package:sketchura_ui/core/utils/sk_input/sk_input.dart";

class InputExample extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SkInput(
          title: "Email Address",
          hintText: "Enter your email",
          controller: controller,
          isOutlined: true,
          prefixIcon: Icon(Icons.email_outlined),
          isRequired: true,
          onChanged: (value) {
            print("Email entered: $value");
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email cannot be empty";
            }
            return null;
          },
        ),
      ),
    );
  }
}
```

# 🧩 SkAccordion

A **customizable accordion/expandable widget** for Flutter — part of the **Sketchura UI Library**.  
`SkAccordion` allows you to show collapsible content sections with smooth animations and flexible styling.Check More About accordian Widget
[SkAccordian](https://sketchura-ui.vercel.app/#/accordian)

---

## ✨ Features

- 🏷️ Expandable/collapsible content  
- 🎨 Customizable **header and content styles**  
- 🚀 Smooth **expand/collapse animation**  
- ✅ Optional **initially expanded** state  
- 📐 Adjustable **width**  

---

## 🚀 Example Usage

```dart
import 'package:flutter/material.dart';
import "package:sketchura_ui/core/utils/sk_accordian/sk_accordion.dart";

class AccordionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SkAccordion(
          title: "Frequently Asked Questions",
          content: Text(
            "This is the expanded content area. You can put any widget here.",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
```

# 🧩 SkBreadcrumbs

A **flexible breadcrumb navigation widget** for Flutter — part of the **Sketchura UI Library**.  
`SkBreadcrumbs` allows you to display hierarchical navigation paths, with customizable styles, separators, and tap handling.Check More About 
[SkBreadcrumbs](https://sketchura-ui.vercel.app/#/breadcrumsPage)

---

## ✨ Features

- 🏷️ Displays **breadcrumb navigation** for hierarchical paths  
- 🎨 Customizable **text styles** for active and inactive items  
- ⚙️ Custom **separator widget** between items  
- ✅ Optional **underline for clickable items**  
- 📌 Handles **tap events** to navigate or trigger actions  
- 🚀 Fully responsive with **Wrap layout**

---

## 🚀 Example Usage

```dart
import 'package:flutter/material.dart';
import "package:sketchura_ui/core/utils/sk_breadcrums/sk_breadcrums.dart";

class BreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SkBreadcrumbs(
          items: ['Home', 'Products', 'Electronics', 'Smartphones'],
          onTap: (index) {
            print('Clicked item at index: $index');
          },
        ),
      ),
    );
  }
}

```

# 🧩 SkGlobalBadge

A **flexible badge widget** for Flutter — part of the **Sketchura UI Library**.  
`SkGlobalBadge` allows you to display notification badges or labels on top of any widget, such as icons, buttons, or custom containers.Check More About 
[SkGlobalBadge](https://sketchura-ui.vercel.app/#/badges)

---

## ✨ Features

- 🏷️ Display **badge values** on any widget  
- 🎨 Customizable **badge color, text color, border radius, and padding**  
- ✅ Optional **show/hide badge dynamically**  
- 📌 Supports **any child widget** (icon, container, button, etc.)  
- 🚀 Lightweight and easy to use  

---

## 🚀 Basic Usage

```dart
import 'package:flutter/material.dart';
import "package:sketchura_ui/core/utils/sk_badge/sk_badges.dart";

class BadgeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SkGlobalBadge(
          value: "5",
          child: Icon(Icons.notifications, size: 30),
        ),
      ),
    );
  }
}

```

# 📝 SkBottomSheet

**SkBottomSheet** is a **reusable custom bottom sheet** widget for Flutter.  
It provides a clean, modern design with customizable **height**, **background color**, and **border radius**.  
You can also show it easily using a static `show` method.Check More About 
[SkBottomSheet](https://sketchura-ui.vercel.app/#/bottomsheet)

---

## 🔹 Features

- Customizable **height** and **background color**.  
- Optional **top border radius** for rounded sheet corners.  
- Includes a built-in **drag handle** for better UX.  
- Easily reusable across any screen in your Flutter app.  

---

## 🚀 Example Usage

### Simple Bottom Sheet

```dart
SkBottomSheet.show(
  context,
  title: "Filter Options",
  content: Column(
    children: [
      ListTile(title: Text("Option 1")),
      ListTile(title: Text("Option 2")),
      ListTile(title: Text("Option 3")),
    ],
  ),
);

```

# 🔔 SkToast

**SkToast** is a lightweight and fully customizable **Flutter toast/snackbar system** built using `Overlay`.  
It supports **success, warning, error, and info** types and can display **titles, messages, and close buttons**.  Check More About 
[SkToast](https://sketchura-ui.vercel.app/#/skToast)

---

## 🔹 Features

- Multiple toast types: **success, warning, error, info**  
- Optional **title and message** display  
- **Close button** support  
- Fully **customizable styling**: colors, padding, margin, radius, elevation, icon size  
- Appears **floating from the top** with smooth animation  

---

## 🚀 Example Usage

```dart
SkToast.show(
  context: context,
  title: "Success!",
  message: "Your data has been saved successfully.",
  type: SkToast.successToast,
  isTittleShow: true,
  isDesShow: true,
  showCloseButton: true,
  duration: Duration(seconds: 4),
);
```

# 🔔 SkSnackbar

A **customizable snackbar utility** for Flutter, part of the Sketchura UI library.  
Supports **floating or fixed snackbars**, action buttons, and multiple predefined types like success, error, info, and warning.Check More About 
[SkSnackbar](https://sketchura-ui.vercel.app/#/snackbar)

---

## 🔹 Example Usage

```dart
// Basic snackbar
SkSnackbar.show(
  context,
  message: "This is a custom snackbar!",
);

// Success snackbar with optional callback
SkSnackbar.success(
  context,
  "Operation completed successfully",
  onTap: () {
    print("Snackbar action tapped!");
  },
);

// Error snackbar
SkSnackbar.error(context, "Something went wrong!");

// Info snackbar
SkSnackbar.info(context, "Here is some info");

// Warning snackbar
SkSnackbar.warning(context, "Be careful!");

```
# ⬇️ SkDropDown Widgets

**SkDropDownListMenu** and **SkDropDownList** are **customizable dropdown menu widgets** for Flutter, providing **simple selection** and **animated expansion**.  
These widgets allow both basic selection from a list of strings and custom child widgets.Check More About 
[SkDropDown](https://sketchura-ui.vercel.app/#/dropdownmenu)

---

## 🔹 SkDropDownListMenu

A **simple dropdown menu** that displays a list of strings with optional custom child and hint text.  

### Example Usage

```dart
SkDropDownListMenu(
  menus: ["Option 1", "Option 2", "Option 3"],
  hintText: "Select an option",
  onChanged: (value) {
    print("Selected: $value");
  },
  w: 200,
  h: 50,
  child: Icon(Icons.menu), // optional custom leading widget
),

```

# 🗑️ SkDismissibleList

A **reusable swipe-to-dismiss list widget** for Flutter.  
Allows users to **swipe left or right to remove items** from a list with customizable background and icon.Check More About 
[SkDismissibleList](https://sketchura-ui.vercel.app/#/dissmissable)

---

## 🔹 Example Usage

```dart
SkDismissibleList<String>(
  items: ['Item 1', 'Item 2', 'Item 3'],
  itemBuilder: (context, item) {
    return ListTile(
      title: Text(item),
    );
  },
  onDismissed: (item) {
    print('Dismissed: $item');
  },
  backgroundColor: Colors.redAccent,
  deleteIcon: Icons.delete_forever,
  deleteIconColor: Colors.white,
),
```

# 🔍 SkSearchBar & SkSearchWithFilteredList

**Powerful search components** for Flutter — part of the **Sketchura UI Library**.  
These widgets allow you to add a **search bar with live filtering**, optional icons, and custom UI for search results.

---

## ✨ Features

- 🔹 **SkSearchBar**: Basic search bar with hint text, custom icon, and clear button.  
- 🔹 **SkSearchWithFilteredList**: Search bar + dynamic filtered list of items.  
- 🎨 Fully **customizable** (colors, radius, icon, width, height).  
- 🚀 Works with **any list type** and supports custom item builders.  
- ✅ Optional **results count**, empty state, and live filtering.  

---

## 🚀 SkSearchBar Usage

```dart
SkSearchBar(
  hintText: 'Search...',
  icon: Icon(Icons.search),
  onChanged: (value) {
    print('Search query: $value');
  },
  backgroundColor: Colors.grey[200],
  radious: 24,
)
```

# 🔎 SkAnimated Search Bars

**Animated and advanced search bar widgets** for Flutter — part of the **Sketchura UI Library**.  

These widgets provide **interactive, stylish, and customizable search bars** with multiple animation styles, live suggestions, and seamless UX.

---

## ✨ Available Widgets

1. **SkSimpleAnimatedSearchBar** – Expanding search bar with clear button and smooth animation.  
2. **SkSlideInSearchBar** – Slide-in search bar with toggle button and close animation.  
3. **SkBouncingSearchBar** – Elastic bounce animation for search activation.  
4. **SkFloatingFilterSearchBar** – Floating search bar with live filtering and suggestions.

---

## 🚀 Usage Examples

### 1️⃣ SkSimpleAnimatedSearchBar

```dart
SkSimpleAnimatedSearchBar(
  hintText: "Search products...",
  onSearchChanged: (query) {
    print("Search query: $query");
  },
)


```


# 🧩 SkNavbarDropdown

A **flexible and customizable navbar dropdown** for Flutter — part of the **Sketchura UI Library**.  
`SkNavbarDropdown` allows you to create dropdown menus in navigation bars with support for **icons, headers, dividers, animations, and custom styles**.

---

## ✨ Features

- 🏷️ **Dropdown navigation** for navbar items  
- 🎨 Customizable **text styles, colors, and dropdown width**  
- ⚙️ Supports **icons, trailing widgets, headers, and dividers**  
- 🚀 Smooth **expand/collapse animation** with hover effect  
- ✅ Optional **caret icon**, rounded or pill styles  
- 📌 Pre-built **user menu, notifications, and theme menu utilities**  
- 📏 Adjustable **max dropdown height, border radius, and shadow**  

---

## 🚀 Basic Usage

```dart
import 'package:flutter/material.dart';
import "package:sketchura_ui/core/utils/sk_navbar_dropdown_list/sk_Navbar_dropdown.dart";

class NavbarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SkNavbarDropdown(
          title: 'Products',
          items: [
            SkNavbarDropdownItem(label: 'Web App', onTap: () {}),
            SkNavbarDropdownItem(label: 'Mobile App', onTap: () {}),
            SkNavbarDropdownItem(label: 'Desktop App', onTap: () {}),
          ],
        ),
      ),
    );
  }
}

```
# 📊 SkChart

**SkChart** is a **custom, reusable Flutter chart widget** built with `CustomPaint`.  
It supports **bar charts** and **line charts** without relying on any external charting packages.  

---

## 🔹 Features

- **Bar Chart & Line Chart** support.  
- Fully **customizable colors** and height.  
- **Smooth, lightweight rendering** using Flutter's `CustomPaint`.  
- Rounded corners for bar charts.  
- Optional **background color** customization.  

---

## 🚀 Example Usage

### Bar Chart

```dart
SkChart(
  title: "Monthly Sales",
  values: [20, 80, 50, 100, 40, 70, 90],
  color: Colors.blue,
  chartType: ChartType.bar,
  height: 200,
  backgroundColor: Colors.white,
)
```

# 🛎 SkBottomNavigationBar

A **customizable, reusable bottom navigation bar** for Flutter.  
Supports **badges**, **active icons**, and both **controlled and uncontrolled modes**.

---

## 🔹 Example Usage

```dart
SkBottomNavigationBar(
  items: [
    SkBottomNavItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
      badge: 0, // small dot
    ),
    SkBottomNavItem(
      icon: Icon(Icons.message_outlined),
      activeIcon: Icon(Icons.message),
      label: 'Messages',
      badge: 5, // numeric badge
    ),
    SkBottomNavItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ],
  currentIndex: 0, // controlled mode
  onTap: (index) {
    print("Tapped item $index");
  },
  backgroundColor: Colors.white,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
);
```

# 🌟 SkAppBar

A **highly customizable AppBar** for Flutter that supports multiple pre-defined styles, gradient/floating layouts, subtitles, flexible space, and more.  

---

## 🔹 Example Usage

```dart
// 1. Standard AppBar
SkAppBar(
  title: 'Home',
  style: SkAppBarStyle.standard,
)

// 2. Light AppBar with subtitle
SkAppBar(
  title: 'Profile',
  subtitle: 'Manage your account',
  style: SkAppBarStyle.light,
)

// 3. Gradient AppBar
SkAppBar(
  title: 'Dashboard',
  style: SkAppBarStyle.gradient,
  gradient: LinearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
)

// 4. Floating AppBar
SkAppBar(
  title: 'Settings',
  style: SkAppBarStyle.floating,
)

// 5. Transparent AppBar
SkAppBar(
  title: 'Gallery',
  style: SkAppBarStyle.transparent,
)

// 6. Large AppBar
SkAppBar(
  title: 'Product Details',
  subtitle: 'All product information',
  style: SkAppBarStyle.large,
)

```

# 🌟 SkTabs

A **customizable TabBar with TabBarView** for Flutter, supporting multiple pre-defined styles, pill/floating/outlined tabs, scrollable tabs, leading/trailing widgets, gradients, and more.

---

## 🔹 Example Usage

```dart
// 1. Standard Tabs
SkTabs(
  tabs: ['Tab 1', 'Tab 2', 'Tab 3'],
  tabViews: [Widget1(), Widget2(), Widget3()],
  style: SkTabStyle.standard,
)

// 2. Pill Tabs
SkTabs(
  tabs: ['Profile', 'Settings', 'Billing'],
  tabViews: [ProfileView(), SettingsView(), BillingView()],
  style: SkTabStyle.pill,
)

// 3. Floating Tabs
SkTabs(
  tabs: ['Messages', 'Notifications'],
  tabViews: [MessagesView(), NotificationsView()],
  style: SkTabStyle.floating,
)

// 4. Outlined Tabs
SkTabs(
  tabs: ['Active', 'Completed', 'Archived'],
  tabViews: [ActiveView(), CompletedView(), ArchivedView()],
  style: SkTabStyle.outlined,
)

// 5. Quick Variations
SkTabVariations.pill(
  tabs: ['Tab 1', 'Tab 2'],
  tabViews: [View1(), View2()],
  context: context,
)

SkTabVariations.floating(
  tabs: ['Tab 1', 'Tab 2'],
  tabViews: [View1(), View2()],
  context: context,
)
```