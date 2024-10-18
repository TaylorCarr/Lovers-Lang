//
//  LoveLanguageMatchView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 10/10/24.
//

import SwiftUI

struct LoveLanguageMatchView: View {
    let partnerScore: languages? = nil
    
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
        }
    }
}
