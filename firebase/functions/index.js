const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const collections = {
  level: [
    '',
    'users',
    'ngos',
    'admin',
    'super_admin',
  ],
  posts: "posts",
  requests: "requests"
};

// auth trigger (new user signup)
exports.userSignup = functions.auth.user().onCreate(async (user) => {
  // for background triggers you must return a value/promise
  if (user.email === 'superadmin@mail.com') {
    await admin.firestore().collection(collections.level[4]).doc(user.uid).set({
      posts: 0,
      rank: 0,
      xp: 0,
      updated: admin.firestore.Timestamp.now(),
      upvotedOn: [],
    });
    return admin.auth().setCustomUserClaims(user.uid, {
      accessLevel: 4,
    });
  } else {
    await admin.firestore().collection(collections.level[1]).doc(user.uid).set({
      posts: 0,
      rank: 0,
      xp: 0,
      updated: admin.firestore.Timestamp.now(),
      upvotedOn: [],
    });
    return admin.auth().setCustomUserClaims(user.uid, {
      accessLevel: 1,
    });
  }
});

// cloud firestore trigger (new post added)
exports.newPost = functions.firestore.document(collections.posts + '/{docId}').onCreate(async (snapshot, context) => {
  var uid = snapshot.data().uid;
  var doc = admin.firestore().collection(collections.level[1]).doc(uid);
  return doc.update({
    posts: admin.firestore.FieldValue.increment(1),
    updated: admin.firestore.Timestamp.now(),
  });
});

// http call (approve user for higher role)
exports.upgrade = functions.https.onCall(async (data, context) => {
  console.log('data id = ' + data.id);
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'only authenticated can add requests',
    );
  }

  // only privileged users can upgrade someone to Lv2 or Lv3
  var user = await admin.auth().getUser(context.auth.uid);
  var userLevel = user.customClaims.accessLevel;
  if (userLevel !== 3 && userLevel !== 4) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'only highly privileged users can add requests',
    );
  }

  console.log('userLevel = ' + user.email);
  var client = await admin.auth().getUser(data.id);
  var collection = collections.level[client.customClaims.accessLevel];
  console.log('client collection = ' + collection);
  var clientDoc = admin.firestore().collection(collection).doc(client.uid);
  var requestDoc = admin.firestore().collection(collections.requests).doc(client.uid);

  var upgradeRequestInfo = await requestDoc.get();

  console.log('upgrade info = ' + upgradeRequestInfo.data().address);

  // only super users can upgrade someone to Lv3
  if (upgradeRequestInfo.data().level === 3 && userLevel !== 4) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'only super users can add requests',
    );
  }

  var clientActivityInfo = await clientDoc.get();

  console.log('client info = ' + clientActivityInfo.data().posts);

  var dataToWrite = {
    posts: clientActivityInfo.data().posts,
    rank: clientActivityInfo.data().rank,
    xp: clientActivityInfo.data().xp,
    upvotedOn: clientActivityInfo.data().upvotedOn,
    updated: admin.firestore.Timestamp.now(),
    name: upgradeRequestInfo.data().name,
    email: upgradeRequestInfo.data().email,
    phone: upgradeRequestInfo.data().phone,
    address: upgradeRequestInfo.data().address,
    docLink: upgradeRequestInfo.data().docLink,
  }

  await clientDoc.delete();
  await requestDoc.delete();

  collection = collections.level[upgradeRequestInfo.data().level];
  console.log('collection info = ' + collection);
  await admin.firestore().collection(collection).doc(client.uid).set(dataToWrite);
  return admin.auth().setCustomUserClaims(client.uid, {
    accessLevel: upgradeRequestInfo.data().level,
  });
});
