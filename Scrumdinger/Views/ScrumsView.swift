//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Alex Samaniego on 2025-03-21.
//

import SwiftUI
import ThemeKit

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false

    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)

                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationBarTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums)
        }
    }

}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        @Previewable @State var scrums = DailyScrum.sampleData
        ScrumsView(scrums: $scrums)
    }
}
