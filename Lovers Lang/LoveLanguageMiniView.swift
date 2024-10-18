//
//  LoveLanguageMiniView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 10/10/24.
//

import SwiftUI

struct LoveLanguageMiniView: View {
    @ObservedObject var userInfo: UserInfo
    
    var body: some View {
        VStack {
            Text("Your Love Language Is:").frame(width: Constants().SCREEN_WIDTH * 0.95, alignment: .leading).padding()
            if userInfo.QuizScore.favoriteLanguage != nil {
                Text(userInfo.QuizScore.favoriteLanguage!.name).foregroundStyle(userInfo.QuizScore.favoriteLanguage!.backgroundColor).frame(width: Constants().SCREEN_WIDTH * 0.95, alignment: .center).fontWeight(.black).padding()
            } else {
                Text("Currently Unavailable").foregroundStyle(Color.black).frame(width: Constants().SCREEN_WIDTH * 0.95, alignment: .center).fontWeight(.black).padding()
            }
        }
    }
}
