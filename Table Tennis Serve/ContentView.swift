//
// ContentView.swift
// Table Tennis Serve
//
// Created by Nolan Cyr on 3/24/24.
//

import SwiftUI


let SPIN_TYPES = ["Underspin", "Topspin", "Sidespin"]
let SERVE_TYPES = ["Classic Underspin", "Sidespin Pendulum", "Backhand"]
let DISTANCE_TYPES = ["Short", "Long"]
let LOCATION_OPTIONS = ["Inside", "Middle", "Outside"]

let defaultColor = Color(red: 255/255, green: 150/255, blue: 61/255)

struct BallPosition {
    var horizontal: CGFloat
    var vertical: CGFloat
}

struct Serve: Identifiable {
    let id = UUID()
    let form: String
    let distance: String
    let spin: String
    let location: String
}

struct ServeDescriptionView: View {
    let serve: Serve
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DescriptionRow(title: "Form", value: serve.form)
            DescriptionRow(title: "Distance", value: serve.distance)
            DescriptionRow(title: "Spin", value: serve.spin)
            DescriptionRow(title: "Location", value: serve.location)
        }
        .padding()
        .frame(width: 280)  // Fixed width for the entire ServeDescriptionView
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct DescriptionRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            // Fix width for the title with right alignment
            Text(title + ":")
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .trailing)  // Fixed width with right alignment
            
            // Align the value to the top without centering
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)  // Allow value to take the rest of the space
                .lineLimit(nil)  // Allow text to wrap if necessary
        }
    }
}

struct ContentView: View {
    @StateObject private var gameState = GameState()
    @State private var showColorPicker = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let tableImagePath = colorScheme == .dark ? "table-tennis-table-white" : "table-tennis-table"
        let paddleImagePath = colorScheme == .dark ? "paddle_white" : "paddle_black"
        
        VStack(alignment: .center, spacing: 12) {
            // Top (Color Picker)
            HStack {
                Spacer()
                Button(action: { showColorPicker = true }) {
                    Image(systemName: "paintpalette.fill")
                        .font(.system(size: 28))
                        .padding(.trailing, 20)
                        .foregroundColor(colorScheme == .dark && gameState.chosenColor == .black ? .white : gameState.chosenColor)
                }
            }
            .sheet(isPresented: $showColorPicker) {
                ColorPickerView(selectedColor: $gameState.chosenColor, showColorPicker: $showColorPicker)
            }
            
            // Middle
            HStack(spacing: 0) {
                // Table
                Image(tableImagePath)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 450)
                
                Spacer()
                
                // Ball
                Image(systemName: "circlebadge.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(gameState.chosenColor)
                    .frame(width: 20, height: 20)
                    .position(x: -208 + gameState.ballPosition.x, y: gameState.ballPosition.y)
            }
            
            // Paddle
            Image(paddleImagePath)
                .resizable()
                .padding(8.0)
                .scaledToFit()
                .frame(width: 75, height: 75)
                .position(x: gameState.paddleHorizontalPosition)
            
            Spacer()
            
            // Text
            HStack {
                if let serve = gameState.currentServe {
                    ServeDescriptionView(serve: serve)
                }
            }
            
            Spacer()
            
            // Bottom (Button)
            Button(action: gameState.generateRandomServe) {
                Text("Generate Random Serve")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .padding(20)
                    .foregroundColor(colorScheme == .dark || gameState.chosenColor == .black || gameState.chosenColor == .white ? .black : .white)
                    .background(gameState.chosenColor == .black ? .white : gameState.chosenColor)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
