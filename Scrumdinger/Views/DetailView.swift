//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Alex Samaniego on 2025-03-22.
//

import SwiftUI
import ThemeKit

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel("Start meeting")
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label(
                        "No meetings yet",
                        systemImage: "calendar.badge.exclamationmark"
                    )
                } else {
                    ForEach(scrum.history) { history in
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                            Spacer()
                            Text(history.date, style: .time)
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingScrum = scrum
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(
                    scrum: $editingScrum,
                    saveEdits: { DailyScrum in scrum = editingScrum }
                )
                .navigationTitle(scrum.title)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        @Previewable @State var scrum = DailyScrum.sampleData[0]
        DetailView(scrum: $scrum)
    }
}
