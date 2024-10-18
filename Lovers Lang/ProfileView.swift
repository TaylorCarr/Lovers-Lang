//
//  ProfileView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 10/10/24.
//

import SwiftUI
import AuthenticationServices

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("firstName") var firstName: String = "Guest"
    @AppStorage("lastName") var lastName: String = "User"
    @AppStorage("username") var username: String?
    @AppStorage("userId") var userId: String?
    @ObservedObject var userInfo: UserInfo
//    @AppStorage("usersLoveLanguages") var usersLoveLanguages: QuizScore?
    
    var body: some View {
        NavigationView {
            VStack {
                LoveLanguageMiniView(userInfo: userInfo).frame(height: Constants().SCREEN_HEIGHT * 0.3)
                Divider()
                LoveLanguageMatchView().frame(height: Constants().SCREEN_HEIGHT * 0.3, alignment: .top)
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    switch result {
                        case .success(let auth):
                            switch auth.credential {
                                case let credentials as ASAuthorizationAppleIDCredential:
                                    print(credentials)
                                    userId = credentials.user
                                    username = (credentials.email != nil) ? self.username : credentials.email
                                    firstName = credentials.fullName?.givenName ?? "Guest"
                                    lastName = credentials.fullName?.familyName ?? "User"
                                    httpHandler().createUser(userId: userId!, username: username!, firstName: firstName, lastName: lastName, userScore: userInfo.QuizScore)
                                default:
                                    print("credentials error")
                            }
                        default:
                            print("sign in failed")
                    }
                }.signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black).frame(width: Constants().SCREEN_WIDTH * 0.9, height: Constants().SCREEN_WIDTH * 0.1).padding()
            }.navigationTitle(Text(verbatim: firstName + " " + lastName))
                .frame(height: Constants().SCREEN_HEIGHT * 0.7, alignment: .top)
        }
    }
}


