//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by Hakan Or on 3.07.2024.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetExtension()
        InteractiveWidget()
    }
}
