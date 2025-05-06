//
//  AddDiaryEntryView.swift
//  meditationApp
//
//  Created by Firuza on 06.05.2025.
//

import SwiftUI

struct AddDiaryEntryView: View {
    @ObservedObject var viewModel: DiaryViewModel
    @Environment(\.presentationMode) private var presentationMode

    @State private var title   = ""
    @State private var content = ""
    @State private var mood    = 2
    private let moodEmojis     = ["😞", "😐", "🙂", "😃", "🤩"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Today's Mood")) {
                    Picker("", selection: $mood) {
                        ForEach(0..<moodEmojis.count, id: \.self) {
                            Text(moodEmojis[$0]).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }

                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(minHeight: 120)
                }
            }
            .navigationBarTitle("New Entry", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    },
                trailing:
                    Button("Save") {
                        viewModel.addEntry(title: title, content: content, mood: mood)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
            )
        }
    }
}
