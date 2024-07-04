//
//  InteractiveWidgetIntent.swift
//  WidgetExtensionExtension
//
//  Created by Hakan Or on 3.07.2024.
//

import SwiftUI
import AppIntents

struct InteractiveWidgetIncrementIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Increment Value"
    
    func perform() async throws -> some IntentResult {
        let data = DataService()
        data.log()
        return .result()
    }
}

struct InteractiveWidgetResetIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Reset Value"
    
    func perform() async throws -> some IntentResult {
        let data = DataService()
        data.reset()
        return .result()
    }
}
