# iOSChat

iOSChat is a live chat application for iOS that allows users to communicate with each other in real-time. The application provides features such as account registration and authentication using Firebase, a backend-as-a-service platform.

## Features

- Account registration: Users can create a new account by providing their email address and password.
- Authentication: Users can log in to their existing accounts using their registered email and password.
- Live chat: Once logged in, users can engage in live chat conversations with other users who are also using the application.
- Real-time updates: Messages sent in the chat are immediately displayed to all participants, providing a seamless and interactive chat experience.

## Getting Started

To use the iOSChat application, follow these steps:

1. Clone or download the iOSChat project from the repository.
2. Obtain your own `GoogleService-Info.plist` file from Firebase. This file contains the necessary configuration details for connecting the application to your Firebase project. Add this to the iOSChat folder. (sorry we don't wanna leak our API key)
3. Set up your Firebase project:
   - Create a new Firebase project from the [Firebase Console](https://console.firebase.google.com).
   - Enable the Firebase Authentication feature and configure the desired authentication providers (e.g., Email/Password).
   - Create a Firestore database and set up the required rules.
4. Open the project in Xcode by double-clicking the `iOSChat.xcworkspace` file.
5. Build and run the project on a simulator or a physical iOS device.

## Firestore Database Structure

The Firestore database for iOSChat is structured as follows:

- **chats**: Collection containing chat documents.
  - **{chatId}**: Document representing an individual chat.
    - **userids**: Array field containing the IDs of the users participating in the chat.
    - **messages**: Array field containing the messages exchanged in the chat.
- **users**: Collection containing users
  - **{userID}**: Document representing an individual user.
    - **name**: String field containing the name of the selected user.
## Dependencies

iOSChat utilizes the following dependencies:

- Firebase: Provides authentication and realtime database functionality.
- FirebaseFirestore: Enables integration with Firestore, the cloud-based NoSQL database by Firebase.

The project uses Swift and is built using Xcode.

## Contributing

Contributions to iOSChat are welcome! If you find any issues or have suggestions for improvement, please create an issue or submit a pull request.

