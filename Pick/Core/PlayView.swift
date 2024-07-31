//
//  PlayView.swift
//  Pick
//
//  Created by Om Preetham Bandi on 7/30/24.
//

import SwiftUI

struct PlayView: View {
    @State private var score: Int = 0
    @AppStorage("level") var level: Int = 1
    @AppStorage("picks") var picks: Int = 1
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Group {
                    Text(numberToWords(level))
                        .font(.callout)
                    
                    Text(numberToWords(score))
                        .font(.system(size: 60, weight: .bold))
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                
                Spacer()
                
                Divider()
                    .background(Color.white)
                
                Spacer()
                
                ZStack {
                    if score == picks {
                        VStack {
                            Text("Bravo!!! You Picked \(picks)!")
                                .font(.largeTitle)
                            
                            Button("Pick More", systemImage: "figure.pickleball") {
                                picks *= 2
                                level += 1
                                score = 0
                            }
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    } else {
                        ForEach(0..<picks, id: \.self) { _ in
                            NeedleView(score: $score)
                        }
                    }
                }
                .offset(y: -50)
            }
        }
        .padding(.horizontal, 10)
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .foregroundStyle(.white)
    }
    
    func numberToWords(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        if let words = formatter.string(from: NSNumber(value: number)) {
            return words
        } else {
            return "\(number)"
        }
    }
}

struct NeedleView: View {
    @State private var offset: CGSize = .zero
    @Binding var score: Int
    @State private var needleOpacity: Double = 1
    
    let screenHeight: CGFloat = UIScreen.main.bounds.height / 2
    @State private var initialTouchPosition: CGFloat = 0
    
    var body: some View {
        ZStack {
            Needle(needleOpacity: needleOpacity)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.smooth) {
                                if initialTouchPosition == 0 {
                                    initialTouchPosition = value.startLocation.y
                                }
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            let dragDistance = value.startLocation.y - value.location.y
                            
                            if dragDistance > screenHeight / 2 {
                                score += 1
                                needleOpacity = 0
                            }
                            
                            initialTouchPosition = 0
                            offset = .zero
                        }
                )
        }
    }
}
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlayView()
    }
}
