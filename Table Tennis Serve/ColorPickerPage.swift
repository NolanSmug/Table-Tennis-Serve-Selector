//
//  ColorPickerPage.swift
//  Table Tennis Serve
//
//  Created by Nolan Cyr on 3/26/24.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    @Binding var showColorPicker: Bool
    
    let colors: [Color] = [.red, Color(red: 255/255, green: 150/255, blue: 61/255), .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray, .black, .white]
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Select a color")
                    .font(.headline)
                    .padding()
                    .padding(.leading, 45)
                Spacer()
                Button(action: hideColorPicker){
                    Image(systemName:"xmark")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .padding(.trailing,20)
                        .foregroundColor(.black)
                }
            }
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 20) {
                    ForEach(colors, id: \.self) { color in ColorBox(color: color, selectedColor: $selectedColor, showColorPicker: $showColorPicker)
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .padding(5)
                    }
                }
                .padding()
            }
        }
    }
    
    func hideColorPicker() {
        showColorPicker = false;
    }
}

struct ColorBox: View {
    let color: Color
    @Binding var selectedColor: Color
    @Binding var showColorPicker: Bool
    
    var body: some View {
        Rectangle()
            .fill(color)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectedColor == color ? Color.white : Color.clear, lineWidth: 2)
            )
            .onTapGesture {
                selectedColor = color
                showColorPicker = false
                
            }
    }
}
