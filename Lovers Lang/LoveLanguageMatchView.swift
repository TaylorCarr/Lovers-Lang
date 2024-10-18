//
//  LoveLanguageMatchView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 10/10/24.
//

import SwiftUI

struct LoveLanguageMatchView: View {
    @State var partnerScore: languages?
    @AppStorage("partnerId") var partnerId: String?
    @AppStorage("partnerUsername") var partnerUsername: String?
    
    var body: some View {
        VStack {
            Text("Partner's Love Language Is:").frame(width: Constants().SCREEN_WIDTH * 0.95, alignment: .leading).padding()
            if partnerScore != nil {
                Text(partnerScore!.name).foregroundStyle(partnerScore!.backgroundColor).frame(width: Constants().SCREEN_WIDTH * 0.95, alignment: .center).fontWeight(.black).padding()
            }
            else {
                Text("Currently Unavailable").foregroundStyle(Color.black).frame(width: Constants().SCREEN_WIDTH * 0.95, alignment: .center).fontWeight(.black).padding()
            }
        }.onAppear {
            // call http handler to fetch user's partner score
            print("match view onAppear()")
            
            if let parnterId = partnerId, let partnerUsername = partnerUsername {
                let handlerResponse = httpHandler().getScore(userId: partnerId!, username: partnerUsername)
                if handlerResponse.count > 0 {
                    let scoreResponse = handlerResponse["score"] as! QuizScoreStruct
                    self.partnerScore = scoreResponse.favoriteLanguage
                }
            }
        }
    }
}
