//
//  Lovers_LangApp.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 11/4/23.
//

import SwiftUI
import SwiftData

@main
struct Lovers_LangApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

struct Constants {
    let USER_DEFAULTS = UserDefaults.standard
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.height
    let MAX_INDEX = 29
    let LOVE_LANG_BAR_WIDTH = CGFloat(100)
    let LOVE_LANG_BAR_HEIGHT = CGFloat(20)
}
