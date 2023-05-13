//
//  ContentView.swift
//  SwiftUI-Sequeence-Gesture-Sample
//
//  Created by ekayaint on 8.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    var body: some View {
        let dragGesture=DragGesture()
            .onChanged{ value in
                self.offset = value.translation
            }.onEnded{ _ in
                withAnimation{
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded{ value in
                withAnimation{
                    self.isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        return VStack(spacing:20) {
            Text("Sequence Gesture Sample").font(.title).bold()
            Text("LongPressGesture & DragGesture").font(.title2)
            Spacer()
            Circle().fill(Color.red)
                .frame(width:64,height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
