const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const collections = {
  users: "users",
  posts: "posts",
  authority: "authorities",
  higher_auths: "higher auths",
};

// auth trigger (new user signup)
exports.userSignup = functions.auth.user().onCreate((user) => {
  // for background triggers you must return a value/promise
  return admin.auth().setCustomUserClaims(user.uid, {
    regular: true,
    authority: false,
    high_auth: false,
    super_admin: false,
  });
});
