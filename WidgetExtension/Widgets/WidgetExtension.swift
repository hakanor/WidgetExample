//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Hakan Or on 3.07.2024.
//

import WidgetKit
import SwiftUI

/// Timeline Provider https://developer.apple.com/documentation/widgetkit/timelineprovider
/// A type that advises WidgetKit when to update a widget's display.
/// Timeline is the core engine of a widget.
struct Provider: TimelineProvider {
    
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
struct SimpleEntry: TimelineEntry {
    let date: Date
    let value: Int
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.25), lineWidth: 20)
            
            let pct = Double(entry.value) / 10
            Circle()
                .trim(from: 0, to: pct)
                .stroke(.red, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
            
            VStack {
                Text(String(entry.value))
                    .font(.title)
                    .bold()
            }
            .foregroundStyle(.white)
            .fontDesign(.rounded)
        }
        .padding()
    }
}

/// Actual Widget
struct WidgetExtension: Widget {
    /// Widget Identifier
    let kind: String = "WidgetExtension"

    /// Static configuration is type of widget - (Static Widget & Intent Widget )
    /// Static Configuration > Widget with no user-configurable object
    /// Intent Configuration > Widget with a user-configurable object, it uses a custom intent definition to provide users with configurable options. (Stocks widget, user can choose stock)
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                /// Widget View
                WidgetExtensionEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                WidgetExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemLarge]) /// Widget Size
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, value: 1)
    SimpleEntry(date: .now, value: 2)
}

#Preview(as: .systemLarge) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, value: 3)
    SimpleEntry(date: .now, value: 3)
}
