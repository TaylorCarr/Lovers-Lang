//
//  SplashView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 12/31/23.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) private var screenMode
    @State var half = false
    @State var doneLoading = false
    
    var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 1)
            .repeatCount(8)
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: appropriateImage())
                .resizable()
                .scaleEffect(half ? 1.5 : 1.0)
                .frame(width: 100, height: 100, alignment: .center)
        }.onAppear(perform: {
            withAnimation(self.repeatingAnimation) {
                self.half.toggle()
                self.doneLoading = false
            }
        })
    }
    
    func appropriateImage() -> UIImage {
        let lightIcon = UIImage(named: "LightImage")
        let darkIcon = UIImage(named: "DarkImage")
        
        if (screenMode == .light) {
            return lightIcon!
        } else {
            return darkIcon!
        }
    }
}


#Preview {
    SplashView()
}
