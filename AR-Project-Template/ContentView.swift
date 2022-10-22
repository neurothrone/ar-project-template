//
//  ContentView.swift
//  AR-Project-Template
//
//  Created by Zaid Neurothrone on 2022-10-22.
//

import SwiftUI

struct ContentView: View {
  @State private var colors: [Color] = [
    .red,
    .blue,
    .green
  ]
  
  var body: some View {
    CustomARViewRepresentable()
      .ignoresSafeArea()
      .overlay(alignment: .bottom) {
        ScrollView(.horizontal) {
          HStack {
            Button {
              ARManager.shared.actionStream.send(.removeAllAnchors)
            } label: {
              Image(systemName: "trash")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(16)
            }
            
            ForEach(colors, id: \.self) { color in
              Button {
                ARManager.shared.actionStream.send(.placeBlock(color: color))
              } label: {
                color
                  .frame(width: 44, height: 44)
                  .padding()
                  .background(.regularMaterial)
                  .cornerRadius(16)
              }
            }
          }
          .padding()
        }
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
