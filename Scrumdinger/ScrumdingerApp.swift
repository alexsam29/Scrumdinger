//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Alex Samaniego on 2025-03-15.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
