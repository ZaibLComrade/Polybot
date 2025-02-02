# Polybot - AI Chat Assistant

Polybot is a modern, feature-rich AI chat assistant built with Flutter. It provides an intuitive interface for interacting with various AI models while offering advanced features like chat history, custom AI training, and team collaboration.

## Features

### Chat Interface
- Real-time AI chat with multiple models
- Message formatting and file attachments
- Chat history with search functionality
- Typing indicators and message status

### AI Models
- Support for multiple AI models (GPT-4, GPT-3.5, Claude, Llama 2)
- Model switching during conversations
- Custom model training for Enterprise users
- Token usage tracking and analytics

### User Management
- User authentication and profile management
- Customizable user preferences
- Notification settings
- Theme customization (Light/Dark mode)

### Subscription Plans
- Free tier with basic features
- Pro tier with advanced capabilities
- Enterprise tier with custom solutions
- Usage monitoring and billing management

### Security & Privacy
- End-to-end encryption for messages
- Secure authentication
- Privacy settings
- Data retention controls

## Getting Started

### Prerequisites
- Flutter SDK (^3.6.0)
- Dart SDK (^3.6.0)
- A code editor (VS Code, Android Studio, etc.)

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
lib/
├── models/          # Data models
├── pages/           # Screen/page widgets
├── providers/       # State management
├── themes/          # Theme configuration
└── widgets/         # Reusable widgets
    ├── account/     # Account-related widgets
    ├── chat/        # Chat interface widgets
    ├── common/      # Shared widgets
    ├── landing/     # Landing page widgets
    └── pricing/     # Pricing page widgets
```

## Architecture

Polybot follows a clean architecture pattern with:
- Provider for state management
- Modular widget design
- Responsive layouts
- Theme customization
- Clear separation of concerns

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