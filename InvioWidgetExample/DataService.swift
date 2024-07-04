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
    
    let userDefaults = UserDefaults(suiteName: "group.com.hakanor.InvioWidgetExample")
   
    func log() {
        var value = progress()
        
        if value < 10 {
            value += 1
        } else {
            value = 0
        }

        userDefaults?.set(value, forKey: "value")
        userDefaults?.synchronize()
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func reset() {
        userDefaults?.set(0, forKey: "value")
        userDefaults?.synchronize()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func progress() -> Int {
        return userDefaults?.integer(forKey: "value") ?? 0
    }
}
