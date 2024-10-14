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
    @State var signedIn: Bool
    
    var body: some View {
        if signedIn {
            ProfileView()
        } else {
            VStack {
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    switch result {
                        case .success(let auth):
                            switch auth.credential {
                                case let credentials as ASAuthorizationAppleIDCredential:
                                    let userId = credentials.user
                                    username = credentials.email
                                default:
                                    print("credentials error")
                            }
                        default:
                            print("sign in failed")
                    }
                }.signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
//                SignInWithAppleButton(.signUp, onRequest: <#T##(ASAuthorizationAppleIDRequest) -> Void#>, onCompletion: <#T##((Result<ASAuthorization, any Error>) -> Void)##((Result<ASAuthorization, any Error>) -> Void)##(Result<ASAuthorization, any Error>) -> Void#>)
                Button("Continue As Guest", action: {
                    
                })
            }
        }
    }
}

#Preview {
    Login(signedIn: false)
}
