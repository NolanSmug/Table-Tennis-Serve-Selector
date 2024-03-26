//
// ContentView.swift
// Table Tennis Serve
//
// Created by Nolan Cyr on 3/24/24.
//

import SwiftUI

let SHORT_SERVE_OPTIONS = ["Underspin", "Topspin", "Sidespin"]
let LONG_SERVE_OPTIONS = ["Underspin", "Topspin", "Sidespin"]
let LOCATION_OPTIONS = ["Inside", "Middle", "Outside"]

let SERVE_OPTIONS: [String: [String: [String]]] = [
    "Classic Underspin": ["Short": SHORT_SERVE_OPTIONS, "Long": LONG_SERVE_OPTIONS],
    "Sidespin Pendulum": ["Short": SHORT_SERVE_OPTIONS, "Long": LONG_SERVE_OPTIONS],
    "Tight Chopper    ": ["Short": SHORT_SERVE_OPTIONS, "Long": LONG_SERVE_OPTIONS],
    "Backhand         ": ["Short": SHORT_SERVE_OPTIONS, "Long": LONG_SERVE_OPTIONS]
]

let defaultColor = Color(red: 255/255, green: 150/255, blue: 61/255)

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedServe = ""
    @State private var ballHorizontalOffset: CGFloat = 0
    @State private var ballVerticalOffset: CGFloat = 1000
    @State private var paddleHorizontalPosition: CGFloat = 192
    @State private var showColorPicker = false
    @State private var chosenColor = defaultColor

    var body: some View {
        let tableImagePath = colorScheme == .dark ? "table-tennis-table-white" : "table-tennis-table"
        let paddleImagePath = colorScheme == .dark ? "paddle_white" : "paddle_black"
        
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Spacer()
                Button(action: openColorPickerPage) {
                    Image(systemName: "paintpalette.fill")
                        .font(.system(size: 28))
                        .padding(.trailing, 20)
                        .foregroundColor(colorScheme == .dark && chosenColor == .black  ? .white : chosenColor)
                }
            }
            .sheet(isPresented: $showColorPicker) {
                ColorPickerView(selectedColor: $chosenColor, showColorPicker: $showColorPicker)
            }
            
            HStack(spacing: 0) {
                Image(tableImagePath)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 450)
                
                Spacer()
                
                Image("ping_pong_ball_orange")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .position(x: -208 + ballHorizontalOffset, y: ballVerticalOffset)
            }
            Image(paddleImagePath)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .position(x: paddleHorizontalPosition)
            
            Spacer()
            
            HStack {
                Text(selectedServe)
                    .font(Font.monospaced(.system(size: 18))())
                    .lineSpacing(4)
                    .padding(.horizontal, 16)
            }
            
            Spacer()
            
            Button(action: generateRandomServe) {
                Text("Generate Random Serve")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .padding(20)
                    .foregroundColor(colorScheme == .dark || chosenColor == .black || chosenColor == .white ? .black : .white)
                    .background(chosenColor == .black ? .white : chosenColor)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
        }
    }
    
    func openColorPickerPage() {
        self.showColorPicker = true
    }

    func generateRandomServe() {
        let formTypes = Array(SERVE_OPTIONS.keys)
        let selectedServeForm = formTypes.randomElement()!
        let distanceTypes = Array(SERVE_OPTIONS[selectedServeForm]!.keys)
        let selectedServeDistance = distanceTypes.randomElement()!
        let spinTypes = SERVE_OPTIONS[selectedServeForm]![selectedServeDistance]!
        let selectedServeSpin = spinTypes.randomElement()!
        let selectedServeLocation = LOCATION_OPTIONS.randomElement()!

        switch selectedServeLocation {
            case "Inside":
                ballHorizontalOffset = -100
            case "Middle":
                ballHorizontalOffset = 0
            case "Outside":
                ballHorizontalOffset = 100
            default:
                break
        }
        
        switch selectedServeDistance {
            case "Short":
                ballVerticalOffset = 80
            case "Long":
                ballVerticalOffset = -40
            default:
                break
        }
        
        switch selectedServeForm {
        case "Sidespin Pendulum":
            paddleHorizontalPosition = 50
        case "Backhand         ":
            paddleHorizontalPosition = 300
        default:
            paddleHorizontalPosition = 100
            break
        }
        

        selectedServe = "Serve Form: \(selectedServeForm)\nServe Dist: \(selectedServeDistance)\nServe Spin: \(selectedServeSpin)\nServe Location: \(selectedServeLocation)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
