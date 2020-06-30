# Firebase Push Notification

Pushing notifications using cloud functions to Flutter app when app is launched, resumed, running and closed.

## Getting Started

1. Add [firebase_messaging](https://pub.dev/packages/firebase_messaging#-readme-tab-) plugin in pubspec.yaml.

2. Follow the instructions correctly from the [README](https://pub.dev/packages/firebase_messaging#-readme-tab-) firebase_messaging in pub.dev page.

3. Copy the code from lib directory.

4. Now you have to select a folder in which you can write your cloud function before deploying.

5. Now Structure your Firebase project like shown below

- Add Listeners by giving device token that is printed out in console when app opens.

![Listeners](https://firebasestorage.googleapis.com/v0/b/web-content-storage.appspot.com/o/ListenersShot.png?alt=media&token=1949d9bd-ba15-4dda-beff-5471fc64906c)

- Add Notifications with title and body of notification

![Notifications](https://firebasestorage.googleapis.com/v0/b/web-content-storage.appspot.com/o/NotificationShot.png?alt=media&token=6fefac63-7921-49ca-8ca9-de437ec945bf)


6. Open the terminal(default shell) from the folder and run the follwing commands-

<!-- setup firebase in your system -->
- $ npm install -g firebase-tools

<!-- now login to your firebase account-->
- $ firebase login

<!-- initialize firebase function -->
- $ firebase init

- Select 'Functions: Configure and deploy Cloud Functions' using space bar.
- Select your project or create one
- Select Javascript
- Confirm ESLint so that you can see bugs before deploying and is the fastest technique
- Confirm to install npm with dependencies

- Add the following line in functions/index.js

```
admin.initializeApp(functions.config().firebase);

var notificationDoc;

exports.notificationTrigger = functions.firestore.document(
    'Notifications/{autoId}'
).onCreate(async (snapshot, context) => {
    notificationDoc = snapshot.data();

    admin.firestore().collection('Listeners').get()
        .then((snapshots) => {
            var tokens = [];
            if (snapshots.empty) {
                return console.log('No Devices');
            }
            else {
                for (var token of snapshots.docs) {
                    tokens.push(token.data().deviceToken);
                }
                var payload = {
                    notification: {
                        title: "Title: " + notificationDoc.title,
                        body: "Body: " + notificationDoc.body,
                        sound: "default"
                    },
                    data: {
                        click_action: "FLUTTER_NOTIFICATION_CLICK",
                        sendername: "Nirmal",
                        message: notificationDoc.body
                    }
                };

                return admin.messaging().sendToDevice(tokens, payload)
            }
        })
        .then((response) => {
            return console.log("Succesfully pushed");
        })
        .catch((error) => {
            console.log(error);
        })
})
```

- Make sure the node version is minimum 10 in functions/package.json or change it as below

```
"engines": {
    "node": "10"
  }
```

<!-- deploy function to firebase -->
- $ firebase deploy --only functions

7. In your Firestore add a new document in Notifications with body and title.

8. Now try sending notifications like this.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
