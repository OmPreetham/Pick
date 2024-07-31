//
//  PlayView.swift
//  Pick
//
//  Created by Om Preetham Bandi on 7/30/24.
//

import SwiftUI

struct PlayView: View {
    @State private var score: Int = 0
    @State private var picks: String = "1"
    @State private var showingSheet: Bool = false
    
    private var pickCount: Int {
        Int(picks) ?? 0
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text(numberToWords(score))
                    .foregroundStyle(.white)
                    .font(.system(size: 60, weight: .bold))
                    .multilineTextAlignment(.trailing)
                
                Spacer()
                
                Stand()
                
                Spacer()
                
                ZStack {
                    ForEach(0..<pickCount, id: \.self) { _ in
                        NeedleView(score: $score)
                    }
                    
                    if score == pickCount {
                        VStack {
                            Text("YEYY! You Picked All")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                            
                            Button("New Game", systemImage: "slider.horizontal.3") {
                                picks = ""
                                showingSheet = true
                                score = 0
                            }
                            .padding(10)
                            .foregroundStyle(.white)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .offset(y: -30)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(.white)
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                EditView(picks: $picks)
                    .presentationDetents([.large, .medium])
            }
            .navigationTitle("PICKS")
            .padding(.horizontal, 10)
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(.dark)
        }
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
