//
//  NeedleCell.swift
//  Pick
//
//  Created by Om Preetham Bandi on 7/30/24.
//

import SwiftUI

// Define the Triangle shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Start at the top center
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        // Draw line to bottom left corner
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Draw line to bottom right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Close the path
        path.closeSubpath()
        return path
    }
}

struct Needle: View {
    var needleWidth: Double = 2
    var needleHeight: Double = 100
    var bodyWidth: Double = 4
    var bodyHeight: Double = 30
    var spacing: Double = -3
    var needleColor: Color = .white
    var bodyColor: Color = .white
    var needleOpacity: Double = 1
    
    // Random offset values
    private let randomOffsetX: CGFloat = CGFloat(Int.random(in: -100...100))
    private let randomOffsetY: CGFloat = CGFloat(Double.random(in: -50...50))
    private let rotationDegree: Double =  Double.random(in: 0..<360)

    var body: some View {
        VStack(spacing: spacing) {
            ZStack {
                Rectangle()
                    .foregroundColor(bodyColor)
                    .frame(width: bodyWidth, height: bodyHeight)
                    .clipShape(Ellipse())
                
                Rectangle()
                    .foregroundColor(.black.opacity(0.9))
                    .frame(width: bodyWidth / 2, height: bodyHeight * 0.75)
                    .clipShape(Ellipse())
            }
            
            Triangle()
                .fill(needleColor)
                .rotationEffect(Angle(degrees: 180))
                .frame(width: needleWidth, height: needleHeight)
        }
        .rotationEffect(Angle(degrees: rotationDegree))
        .offset(x: randomOffsetX, y: randomOffsetY)
        .opacity(needleOpacity)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        Needle(
            needleWidth: 10,
            needleHeight: 300,
            bodyWidth: 20,
            bodyHeight: 100,
            spacing: -10
        )
    }
}
