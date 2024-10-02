//
//  Serve.swift
//  Table Tennis Serve
//
//  Created by Nolan Cyr on 6/21/24.
//

import SwiftUI

class GameState: ObservableObject {
    @Published var currentServe: Serve?
    @Published var ballPosition = CGPoint(x: 0, y: 1000)
    @Published var paddleHorizontalPosition: CGFloat = 192
    @Published var chosenColor = Color(red: 255/255, green: 150/255, blue: 61/255)
    @Published var enabledServeTypes = Set(SERVE_TYPES)
    @Published var enabledSpinTypes = Set(SPIN_TYPES)
    
    func generateRandomServe() {
        guard !enabledServeTypes.isEmpty, !enabledSpinTypes.isEmpty else {
            // when no serve types or spin types are enabled
            return
        }
        
        let selectedServeForm = enabledServeTypes.randomElement()!
        let selectedServeSpin = enabledSpinTypes.randomElement()!
        let selectedServeDistance = DISTANCE_TYPES.randomElement()!
        var selectedServeLocation = LOCATION_OPTIONS.randomElement()!
        
        switch selectedServeLocation {
        case "Inside":
            ballPosition.x = -100
        case "Middle":
            ballPosition.x = 0
        case "Outside":
            ballPosition.x = 100
        default:
            break
        }
        
        switch selectedServeDistance {
        case "Short":
            ballPosition.y = 80
        case "Long":
            ballPosition.y = -40
        default:
            break
        }
        
        switch selectedServeForm {
        case "Sidespin Pendulum":
            paddleHorizontalPosition = 50
        case "Backhand":
            paddleHorizontalPosition = 300
        default:
            paddleHorizontalPosition = 100
        }
        
        // flip location logic for if backhard was selected
        if (selectedServeForm == "Backhand") {
            switch selectedServeLocation {
            case "Inside":
                selectedServeLocation = "Outside"
            case "Outside":
                selectedServeLocation = "Inside"
            default:
                break
            }
        }
        
        currentServe = Serve(form: selectedServeForm,
                             distance: selectedServeDistance,
                             spin: selectedServeSpin,
                             location: selectedServeLocation)
    }
}
