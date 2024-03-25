import SwiftUI

struct TableTennisTableView: View {
    let selectedServeDistance: String
    let selectedServeLocation: String
    
    var body: some View {
        ZStack {
            Image("table-tennis-table.svg")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .position(getDotPosition())
        }
    }
    
    func getDotPosition() -> CGPoint {
        let tableWidth: CGFloat = 274 // Assuming the table image width is 274 points
        let tableHeight: CGFloat = 137 // Assuming the table image height is 137 points
        
        var xPosition: CGFloat = 0
        var yPosition: CGFloat = tableHeight / 2 // Assuming the dot should be placed at the center of the opponent's side
        
        switch selectedServeDistance {
        case "Short":
            yPosition = tableHeight * 0.75 // Place the dot closer to the net for short serves
        case "Long":
            yPosition = tableHeight * 0.25 // Place the dot closer to the end for long serves
        default:
            break
        }
        
        switch selectedServeLocation {
        case "Inside":
            xPosition = tableWidth * 0.25
        case "Outside":
            xPosition = tableWidth * 0.75
        default:
            xPosition = tableWidth * 0.5 // Middle
        }
        
        return CGPoint(x: xPosition, y: yPosition)
    }
}
