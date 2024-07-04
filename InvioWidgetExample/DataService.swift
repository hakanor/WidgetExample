//
//  DataService.swift
//  InvioWidgetExample
//
//  Created by Hakan Or on 3.07.2024.
//

import Foundation
import SwiftUI
import WidgetKit

struct DataService {
    @AppStorage("value", store: UserDefaults(suiteName: "group.com.hakanor.InvioWidgetExample")) private var value = 0
    
    func log() {
        if value < 10 {
            value += 1
        } else {
            value = 0
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func reset() {
        value = 0
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func progress() -> Int {
        return value
    }
}
