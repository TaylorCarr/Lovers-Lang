//
//  SettingsView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 1/2/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var showAlert = false
    @ObservedObject var userInfo: UserInfo
    var body: some View {
        VStack {
            Section {
                List {
                    Button("Reset Love Language Score", action: {
                        Constants().USER_DEFAULTS.removeObject(forKey: "usersLoveLanguages")
                        userInfo.QuizScore = QuizScoreStruct()
                        showAlert.toggle()
                    })
                }
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Success!"), message: Text("Your quiz scores have been erased"))
        }
    }
}

#Preview {
    SettingsView(userInfo: UserInfo())
}
