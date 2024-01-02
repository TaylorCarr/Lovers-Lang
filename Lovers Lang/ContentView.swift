 //
//  ContentView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 11/4/23.
//

import SwiftUI
import SwiftData
import WebKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    let userInfo = UserInfo()
    @State var half = false
    @State var doneLoading = false
    let navBarColor = Color(uiColor: UIColor(red: 230, green: 230, blue: 250, alpha: 0.5))
    
    var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 1)
            .repeatCount(8)
    }

    var body: some View {
        NavigationView {
            if (doneLoading == false) {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .scaleEffect(half ? 1.5 : 1.0)
                    .frame(width: 150, height: 150, alignment: .center)
                
                    .onAppear(perform: {
                        withAnimation(self.repeatingAnimation) {
                            self.half.toggle()
                            self.doneLoading = false
                            print("added")
                        }
                    })
            } else {
                TabView {
                    LoveLanguageView(userInfo: userInfo)
                        .tabItem {
                            Text("Language")
                            Image("romance").resizable()
                        }
                    SettingsView(userInfo: userInfo)
                        .tabItem {
                            Text("Settings")
                            Image("settings").resizable()
                        }
                }
                .navigationBarTitle("Lovers Lang", displayMode: .inline)
                .frame(alignment: .center)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(navBarColor, for: .navigationBar)
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

#Preview {
    ContentView()
}
