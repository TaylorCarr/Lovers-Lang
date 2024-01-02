//
//  SplashView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 12/31/23.
//

import SwiftUI

struct SplashView: View {
    @State var half = false
    @State var doneLoading = false
    
    var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 1)
            .repeatCount(8)
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                if (doneLoading == false) {
                    
                    
                } else {
//                    Lovers_LangApp()
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation{
                        self.doneLoading = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
