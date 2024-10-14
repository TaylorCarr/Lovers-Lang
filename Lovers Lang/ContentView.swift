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
    @Environment(\.colorScheme) private var screenMode
    let userInfo = UserInfo()
    @State var half = false
    @State var doneLoading = false
    @State var signedIn: Bool
    @AppStorage("userId") var userId: String?
    let navBarColor = Color(uiColor: UIColor(red: 230, green: 230, blue: 250, alpha: 0.5))
    
//    var repeatingAnimation: Animation {
//        Animation
//            .easeInOut(duration: 1)
//            .repeatCount(8)
//    }

    var body: some View {
        NavigationView {
            if (doneLoading == false) {
                SplashView()
            } else {
                TabView {
                    Group {
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
                        Login(signedIn: signedIn)
                            .tabItem {
                                Text("Profile")
                            }.onAppear {
                                if userId != nil {
                                    signedIn = true
                                } else {
                                    signedIn = false
                                }
                            }
                    }
                }
                .navigationBarTitle("Lovers' Lang", displayMode: .inline)
                .frame(alignment: .center)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation{
                    self.doneLoading = true
                }
            }
        }.background(Color("Background")).foregroundStyle(Color("Text"))
    }
    
//    func appropriateImage() -> UIImage {
//        var lightIcon = UIImage(named: "IconLight")
//        var darkIcon = UIImage(named: "IconDark")
//        
//        if (screenMode == .light) {
//            return lightIcon!
//        } else {
//            return darkIcon!
//        }
//    }
}

#Preview {
    ContentView(signedIn: false)
}
