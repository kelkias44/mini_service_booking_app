# Mini Service Booking App 🛠️

A Flutter-based application for managing service bookings with full CRUD functionality, built following Clean Architecture principles and powered by GetX for state management.

## Features ✨

### Core Functionality
- **Service List View**  
  Browse services with beautiful cards showing key details and availability status
- **Service Details**  
  Comprehensive view with expandable sections and hero animations
- **Add New Service**  
  Form with image upload (camera/gallery) and real-time validation
- **Edit Service**  
  Pre-filled forms with existing data and seamless updates
- **Delete Service**  
  Secure deletion with confirmation dialog and undo capability

### Bonus Features 🚀
- **Smart Search & Filters**  
  Combined search by name/category + filter by price range (₹100-₹5000) and rating (⭐1-⭐5)
- **Lottie Animations**  
  Custom loading sequences and empty state illustrations
- **Swipe-to-Refresh**  
  Pull down to refresh service list with haptic feedback
- **Responsive Design**  
  Perfect display on devices from 5" phones to 10" tablets

## Tech Stack 💻

| Category             | Technologies                                                              |
|----------------------|---------------------------------------------------------------------------|
| **Framework**        | Flutter                                                                   |
| **State Management** | GetX                                                                      |
| **API Client**       | Dio with Interceptors                                                     |
| **Image Handling**   | Cloudinary + Image Picker                                                 |
| **Local Storage**    | GetStorage for caching                                                    |
| **Animations**       | Lottie                                                                    |
| **DI**               | GetX Dependency Injection 

## Setup 🚀
1. Clone repository
```bash
git clone https://github.com/your-username/mini-service-booking.git
```
2. Open the project on code editor
3. Install dependencies
```bash
flutter pub get
```
4. Run the app
```bash
flutter run
```

## App Preview 📱

### Services List
<img src="screenshots/service_list.jpg" width="300">

### Services Detail
<img src="screenshots/service_detail.jpg" width="300">

### Add Service Form
| <img src="screenshots/add_service.jpg" width="300"> | <img src="screenshots/add_service_image_selected.jpg" width="300"> |

### Update Service
<img src="screenshots/update_service.jpg" width="300">

### Filter Service
<img src="screenshots/filter_service.jpg" width="300">




