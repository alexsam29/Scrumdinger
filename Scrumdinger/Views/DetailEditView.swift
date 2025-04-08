//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Alex Samaniego on 2025-03-23.
//

import SwiftUI
import ThemeKit

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    let saveEdits: (DailyScrum) -> Void

    @State private var newAttendeeName = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(
                        value: $scrum.lengthInMinutesAsDouble,
                        in: 5...30,
                        step: 1
                    ) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(
                                name: newAttendeeName
                            )
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""

                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    if !scrum.title.isEmpty && !scrum.attendees.isEmpty {
                        saveEdits(scrum)
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    DetailEditView(scrum: $scrum, saveEdits: { _ in })
}
