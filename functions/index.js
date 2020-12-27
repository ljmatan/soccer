const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.onUserRegister = functions.region('europe-west1').auth.user().onCreate((user) => {
    admin.database().ref('users/' + user.uid).set({
        'registerTime': user.metadata.creationTime,
        'level': 1,
        'gold': 0,
        'cash': 0,
        'games': { 'total': 0, 'won': 0, 'lost': 0, 'left': 0, },
    });

    return true;
});

exports.onUserDelete = functions.region('europe-west1').auth.user().onDelete((user) => {
    admin.database().ref('users/' + user.uid).remove();

    return true;
});

/*exports.onMatchmakingEnter = functions.region('europe-west1').database.ref('active').onWrite((snapshot, context) => {
    admin.database().ref('active').orderByChild('level').equalTo(snapshot.val().level).on()
});*/