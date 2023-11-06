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
    
    let navBarColor = Color(uiColor: UIColor(red: 230, green: 230, blue: 250, alpha: 0.5))

    var body: some View {
        NavigationView {
            TabView {
                MemoriesView()
                    .tabItem {
                        Text("Memories")
                        Image("Photos").resizable()
                    }
                ReasonsView()
                    .tabItem {
                        Text("Reasons")
                        Image("Reasons").resizable()
                    }
                MusicView()
                    .tabItem {
                        Text("Music")
                        Image("Music").resizable()
                    }
            }.navigationBarTitle("ODE TO CHY", displayMode: .inline).frame(alignment: .center).toolbarBackground(.visible, for: .navigationBar).toolbarBackground(navBarColor, for: .navigationBar)
        }
        
    }
}

struct MemoriesView: View {

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<17) { index in
                    Image("\(index)").resizable().aspectRatio(contentMode: .fit)
                }
            }
        }
        
    }
}

struct MusicView: View {
    var body: some View {
        VStack {
            WebView(url: URL(string:"https://music.apple.com/us/playlist/ode-to-chynna/pl.u-BqZbH39GD5E")!)
        }
    }
    
    struct WebView: UIViewRepresentable {
        // 1
        let url: URL

        
        // 2
        func makeUIView(context: Context) -> WKWebView {

            return WKWebView()
        }
        
        // 3
        func updateUIView(_ webView: WKWebView, context: Context) {

            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

struct ReasonsView: View {
    var reasonsArray = ["You are the most intelligent woman I've ever met", "Your work ethic is unmatched", "You have a kind heart", "You're the most beautiful woman in the world", "You make me laugh", "You teach me things", "You give the most comforting hugs. When you hold me it makes me feel like everything is going to be alright", "Your pretty brown eyes"]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<reasonsArray.count) { index in
                        Text(reasonsArray[index])
                    }
                }.navigationTitle("Why I Love You")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
