//
//  ProfileView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 10/10/24.
//

import SwiftUI
import AuthenticationServices

struct ProfileView: View {
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
//    @AppStorage("usersLoveLanguages") var usersLoveLanguages: QuizScore?
    
    var body: some View {
        NavigationView {
            VStack {
                LoveLanguageMiniView()
                Divider()
                LoveLanguageMatchView()
            }.navigationTitle(Text(verbatim: firstName + " " + lastName))
        }
    }
}


