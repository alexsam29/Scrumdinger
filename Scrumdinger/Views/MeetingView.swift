//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Alex Samaniego on 2025-03-15.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                ProgressView(value: 5, total: 15)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Seconds Elapsed").font(.caption)
                        Label("300", systemImage: "hourglass.tophalf.fill")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Seconds Remaining").font(.caption)
                        Label("600", systemImage: "hourglass.bottomhalf.fill")
                    }
                }.accessibilityElement(children: .ignore)
                Circle()
                    .strokeBorder(lineWidth: 24)
                    .accessibilityLabel("Time remaining")
                    .accessibilityValue("10 minutes")
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        @Previewable @State var scrum = DailyScrum.sampleData[0]
        MeetingView(scrum: $scrum)
    }
}
