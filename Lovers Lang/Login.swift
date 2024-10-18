//
//  Login.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 11/5/23.
//

import SwiftUI
import AuthenticationServices

struct Login: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("username") var username: String?
    @AppStorage("userId") var userId: String?
    @AppStorage("firstName") var firstName: String?
    @AppStorage("lastName") var lastName: String?
    @ObservedObject var userInfo: UserInfo
    @State var signedIn: Bool
    
    var body: some View {
        if signedIn {
            ProfileView(firstName: firstName ?? "Guest", lastName: lastName ?? "User", userInfo: userInfo)
        } else {
            VStack {
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    switch result {
                        case .success(let auth):
                            switch auth.credential {
                                case let credentials as ASAuthorizationAppleIDCredential:
                                    userId = credentials.user
                                    username = credentials.email
                                    firstName = credentials.fullName?.givenName
                                    lastName = credentials.fullName?.familyName
                                httpHandler().createUser(userId: userId!, username: username!, firstName: firstName!, lastName: lastName!, userScore: userInfo.QuizScore)
                                default:
                                    print("credentials error")
                            }
                        default:
                            print("sign in failed")
                    }
                }.signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black).frame(width: Constants().SCREEN_WIDTH * 0.9, height: Constants().SCREEN_WIDTH * 0.1).padding()
                Button("Continue As Guest", action: {
//                    username = nil
//                    userId = "guest"
//                    signedIn = true
                    userId = "taycarr1234"
                    username = "taycarr@gmail.com"
                    signedIn = true
                    
                    let handlerResponse = httpHandler().getScore(userId: userId!, username: username!)
                    if handlerResponse.count > 0 {
                        let scoreResponse = handlerResponse["score"] as! QuizScoreStruct
                        userInfo.QuizScore = scoreResponse
                    }
                }).padding()
            }
        }
    }
}

#Preview {
    Login(userInfo: UserInfo(), signedIn: false)
}
