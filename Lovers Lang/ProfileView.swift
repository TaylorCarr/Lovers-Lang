//
//  ProfileView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 10/10/24.
//

import SwiftUI
import AuthenticationServices

struct ProfileView: View {
    @AppStorage("firstName") var firstName: String = "Guest"
    @AppStorage("lastName") var lastName: String = "User"
    @ObservedObject var userInfo: UserInfo
//    @AppStorage("usersLoveLanguages") var usersLoveLanguages: QuizScore?
    
    var body: some View {
        NavigationView {
            VStack {
                LoveLanguageMiniView(userInfo: userInfo).frame(height: Constants().SCREEN_HEIGHT * 0.4)
                Divider()
                LoveLanguageMatchView().frame(height: Constants().SCREEN_HEIGHT * 0.4, alignment: .top)
            }.navigationTitle(Text(verbatim: firstName + " " + lastName))
                .frame(height: Constants().SCREEN_HEIGHT * 0.8)
        }
    }
}


