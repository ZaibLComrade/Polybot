# Polybot - AI Chat Assistant

Polybot is a modern, feature-rich AI chat assistant built with Flutter. It provides an intuitive interface for interacting with various AI models while offering advanced features like chat history, custom AI training, and team collaboration.

## Features

### Chat Interface

-   Real-time AI chat with multiple models
-   Message formatting and file attachments
-   Chat history with search functionality
-   Typing indicators and message status

### AI Models

-   Support for multiple AI models (GPT-4, GPT-3.5, Claude, Llama 2)
-   Model switching during conversations
-   Custom model training for Enterprise users
-   Token usage tracking and analytics

### User Management

-   User authentication and profile management
-   Customizable user preferences
-   Notification settings
-   Theme customization (Light/Dark mode)

### Subscription Plans

-   Free tier with basic features
-   Pro tier with advanced capabilities
-   Enterprise tier with custom solutions
-   Usage monitoring and billing management

### Security & Privacy

-   End-to-end encryption for messages
-   Secure authentication
-   Privacy settings
-   Data retention controls

## Getting Started

### Prerequisites

-   Flutter SDK (^3.6.0)
-   Dart SDK (^3.6.0)
-   A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/ZaibLComrade/polybot.git
    ```

2. Navigate to the project directory:

    ```bash
    cd polybot
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the application:
    ```bash
    flutter run
    ```

## Project Structure

```
lib
├── models
│   ├── ai_model.dart
│   ├── message.dart
│   ├── user.dart
├── pages
│   ├── auth_pages
│   │   ├── login_page.dart
│   │   ├── register_page.dart
│   ├── chat_pages
│   │   ├── chat_page.dart
│   │   ├── models_page.dart
│   ├── landing_pages
│   │   ├── billing_page.dart
│   │   ├── help_page.dart
│   │   ├── history_page.dart
│   │   ├── landing_page.dart
│   │   ├── pricing_page.dart
│   ├── settings_pages
│   │   ├── change_password_page.dart
│   │   ├── edit_profile_page.dart
│   │   ├── notification_page.dart
│   │   ├── settings_page.dart
│   │   ├── user_page.dart
├── providers
│   ├── auth_provider.dart
│   ├── chat_provider.dart
│   ├── model_provider.dart
│   ├── theme_provider.dart
├── services
│   ├── api_service.dart
├── themes
│   ├── app_theme.dart
├── widgets
│   ├── account
│   │   ├── notification_settings.dart
│   │   ├── password_form.dart
│   │   ├── profile_form.dart
│   ├── chat
│   │   ├── chat_app_bar.dart
│   │   ├── chat_input.dart
│   │   ├── chat_messages.dart
│   │   ├── format_toolbar.dart
│   │   ├── message_bubble.dart
│   │   ├── modal_info_card.dart
│   │   ├── sidebar.dart
│   ├── common
│   │   ├── custom_text_field.dart
│   │   ├── footer.dart
│   │   ├── loading_indicator.dart
│   │   ├── responsive_builder.dart
│   │   ├── skeleton_loader.dart
│   │   ├── typing_indicator.dart
│   ├── landing
│   │   ├── feature_card.dart
│   │   ├── hero_section.dart
│   │   ├── testimonial_card.dart
│   ├── pricing
│   │   ├── pricing_card.dart
├── main.dart
```

## Architecture

Polybot follows a clean architecture pattern with:

-   Provider for state management
-   Modular widget design
-   Responsive layouts
-   Theme customization
-   Clear separation of concerns

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@polybot.com or join our Discord community.

