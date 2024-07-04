//
//  InteractiveWidget.swift
//  WidgetExtensionExtension
//
//  Created by Hakan Or on 3.07.2024.
//

import WidgetKit
import SwiftUI

struct InteractiveWidgetProvider: TimelineProvider {
    
    let data = DataService()
    
    /// Placeholder version of widget
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), value: data.progress())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), value: data.progress())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            
            let entry = SimpleEntry(date: entryDate, value: data.progress())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

/// Data for snapshot
struct InteractiveWidgetEntry: TimelineEntry {
    let date: Date
    let value: Int
}

struct InteractiveWidgetEntryView : View {
    var entry: InteractiveWidgetProvider.Entry
    var data = DataService()

    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.25), lineWidth: 15)
            
            let pct = Double(data.progress()) / 10
            Circle()
                .trim(from: 0, to: pct)
                .stroke(.red, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
            VStack {
                Text(String(data.progress()))
                    .font(.title)
                    .bold()
            }
            .foregroundStyle(.white)
            .fontDesign(.rounded)
        }
        .padding()
        HStack {
            Button(intent: InteractiveWidgetIncrementIntent()) {
                ZStack {
                    Capsule()
                        .foregroundStyle(.white.opacity(0.2))
                        .frame(width: 50, height: 30)
                    Text("+1")
                }
            }
            Button(intent: InteractiveWidgetResetIntent()) {
                ZStack {
                    Capsule()
                        .foregroundStyle(.white.opacity(0.2))
                        .frame(width: 50, height: 30)
                    Image(systemName: "arrow.circlepath")
                }
                
            }
        }
        .tint(.clear)
        .foregroundStyle(.red)
    }
}

struct InteractiveWidget: Widget {
    let kind: String = "InteractiveWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: InteractiveWidgetProvider()) { entry in
            if #available(iOS 17.0, *) {
                InteractiveWidgetEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                InteractiveWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Interactive Widget")
        .description("This is an example of interactive widget.")
    }
}

#Preview(as: .systemSmall) {
    InteractiveWidget()
} timeline: {
    SimpleEntry(date: .now, value: 1)
    SimpleEntry(date: .now, value: 2)
}

#Preview(as: .systemLarge) {
    InteractiveWidget()
} timeline: {
    SimpleEntry(date: .now, value: 3)
    SimpleEntry(date: .now, value: 3)
}
