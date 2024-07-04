//
//  ContentView.swift
//  InvioWidgetExample
//
//  Created by Hakan Or on 3.07.2024.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @AppStorage("value", store: UserDefaults(suiteName: "group.com.hakanor.InvioWidgetExample")) var value = 0
    
    let data = DataService()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                ZStack {
                    Circle()
                        .stroke(.white.opacity(0.25), lineWidth: 20)

                    let pct = Double(value) / 10
                    Circle()
                        .trim(from: 0, to: pct)
                        .stroke(.red, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        Text("Value")
                            .font(.largeTitle)
                        Text(String(value))
                            .font(.system(size: 70))
                            .bold()
                    }
                    .foregroundStyle(.white)
                    .fontDesign(.rounded)
                }
                .padding(50)
                
                HStack {
                    Button(action: {
                        data.log()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.red)
                                .frame(height: 40)
                            Text("+1")
                                .foregroundColor(.white)
                        }
                        
                    })
                    
                    Button(action: {
                        data.reset()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.red)
                                .frame(height: 40)
                            Image(systemName: "arrow.circlepath")
                                .foregroundStyle(.white)
                        }
                    })
                }
                .padding(.horizontal, 35)
            }
        }
    }
}

#Preview {
    ContentView()
}
