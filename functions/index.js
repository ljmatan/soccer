const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

var database = admin.database();

exports.onUserRegister = functions.region('europe-west1').auth.user().onCreate((user) => {
    database.ref('users/' + user.uid).set({
        'registerTime': user.metadata.creationTime,
        'notificationsAllowed': true,
        'stats': {
            'level': 1,
            'gold': 0,
            'cash': 0,
            'games': { 'total': 0, 'won': 0, 'lost': 0, 'left': 0, },
        },
        'gifts': {
            'last': null,
        }
    });

    return true;
});

exports.onUserDelete = functions.region('europe-west1').auth.user().onDelete((user) => {
    database.ref('users/' + user.uid).remove();

    return true;
});

/*function generateGameId() {
    var possibleChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    var gameId = "";
    for (var j = 0; j < 20; j++) gameId += possibleChars.charAt(Math.floor(Math.random() * possibleChars.length));
    return gameId;
}

exports.onMatchmakingEnter = functions.database.ref('matchmaking/{playerId}').onCreate((snap, context) => {
    var gameId = generateGameId();

    database.ref('matchmaking').once('value').then(players => {
        var secondPlayer = null;
        players.forEach(player => {
            if (player.val() === "placeholder" && player.key !== context.params.playerId) {
                secondPlayer = player;
            }
        });

        if (secondPlayer === null) return null;

        database.ref("matchmaking").transaction(function (matchmaking) {

            // If any of the players gets into another game during the transaction, abort the operation
            if (matchmaking === null || matchmaking[context.params.playerId] !== "placeholder" || matchmaking[secondPlayer.key] !== "placeholder") return matchmaking;

            matchmaking[context.params.playerId] = gameId;
            matchmaking[secondPlayer.key] = gameId;
            return matchmaking;

        }).then(result => {

            if (result.snapshot.child(context.params.playerId).val() !== gameId) return;

            var game = {
                gameInfo: {
                    gameId: gameId,
                    playersIds: [context.params.playerId, secondPlayer.key]
                },
                turn: context.params.playerId
            }

            database.ref("games/" + gameId).set(game).then(snapshot => {

                console.log("Game created successfully!")
                return null;
            }).catch(error => {
                console.log(error);
            });

            return null;

        }).catch(error => {
            console.log(error);
        });

        return null;
    }).catch(error => {
        console.log(error);
    });
});*/