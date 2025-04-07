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
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                    
                }
                .listRowBackground(scrum.theme.mainColor)
            }
                .navigationBarTitle("Daily Scrums")
                .toolbar {
                    Button(action: {  }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Scrum")
                }
        }
        
    }
    
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        @Previewable @State var scrums = DailyScrum.sampleData
        ScrumsView(scrums: $scrums)
    }
}
