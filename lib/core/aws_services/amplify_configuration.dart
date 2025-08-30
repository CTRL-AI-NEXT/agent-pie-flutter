// import 'dart:convert';
//
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_core/amplify_core.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';
//
// import '../environment_setup/environment.dart';
// import '../utils/logger_util.dart';
// import 'prefix_resolver.dart';
//
// class CognitoHelpingHand {
//   static final _amplifyDevConfig = jsonEncode({
//     "UserAgent": "aws-amplify-cli/1.6.0",
//     "Version": "1.0",
//     "auth": {
//       "plugins": {
//         "awsCognitoAuthPlugin": {
//           "IdentityManager": {"Default": {}},
//           "CredentialsProvider": {
//             "CognitoIdentity": {
//               "Default": {
//                 "PoolId": <PoolID>,
//                 "Region": <Region>
//               }
//             }
//           },
//           "CognitoUserPool": {
//             "Default": {
//               "PoolId": <PoolID>,
//               "AppClientId": <AppClientID>,
//               "Region": <Region>"
//             }
//           },
//           "Auth": {
//             "Default": {
//               "authenticationFlowType": "USER_SRP_AUTH",
//               "OAuth": {
//                 "WebDomain": <WebDomain>,
//                 "AppClientId": <AppClientID>,
//                 "SignInRedirectURI":
//                     "[CUSTOM REDIRECT SCHEME AFTER SIGN IN, e.g. myapp://]",
//                 "SignOutRedirectURI":
//                     "[CUSTOM REDIRECT SCHEME AFTER SIGN OUT, e.g. myapp://]",
//                 "Scopes": [
//                   "phone",
//                   "email",
//                   "openid",
//                   "profile",
//                   "aws.cognito.signin.user.admin"
//                 ]
//               }
//             }
//           }
//         }
//       }
//     },
//     "storage": {
//       "plugins": {
//         "awsS3StoragePlugin": {"bucket": <Bucket Name>, "region": <Region>}
//       }
//     }
//   });
//
//   static final _amplifyStagingConfig = jsonEncode({
//     "UserAgent": "aws-amplify-cli/1.6.0",
//     "Version": "1.0",
//     "auth": {
//       "plugins": {
//         "awsCognitoAuthPlugin": {
//           "IdentityManager": {"Default": {}},
//           "CredentialsProvider": {
//             "CognitoIdentity": {
//               "Default": {
//                 "PoolId": <PoolID>,
//                 "Region": <Region>
//               }
//             }
//           },
//           "CognitoUserPool": {
//             "Default": {
//               "PoolId": <PoolID>,
//               "AppClientId": <AppClientID>,
//               "Region": <Region>"
//             }
//           },
//           "Auth": {
//             "Default": {
//               "authenticationFlowType": "USER_SRP_AUTH",
//               "OAuth": {
//                 "WebDomain": <WebDomain>,
//                 "AppClientId": <AppClientID>,
//                 "SignInRedirectURI":
//                     "[CUSTOM REDIRECT SCHEME AFTER SIGN IN, e.g. myapp://]",
//                 "SignOutRedirectURI":
//                     "[CUSTOM REDIRECT SCHEME AFTER SIGN OUT, e.g. myapp://]",
//                 "Scopes": [
//                   "phone",
//                   "email",
//                   "openid",
//                   "profile",
//                   "aws.cognito.signin.user.admin"
//                 ]
//               }
//             }
//           }
//         }
//       }
//     },
//     "storage": {
//       "plugins": {
//         "awsS3StoragePlugin": {"bucket": <Bucket Name>, "region": <Region>}
//       }
//     }
//   });
//
//   static Future<void> configureAmplify({required String environment}) async {
//     try {
//       final storage =
//           AmplifyStorageS3(prefixResolver: const MyPrefixResolver());
//       Amplify.addPlugins([AmplifyAuthCognito(), storage]);
//       await Amplify.configure(environment == Environment.development
//           ? _amplifyDevConfig
//           : _amplifyStagingConfig);
//       logger.i('$environment Amplify configured successfully');
//     } catch (e) {
//       logger.e('Error configuring $environment Amplify: $e');
//     }
//   }
// }
