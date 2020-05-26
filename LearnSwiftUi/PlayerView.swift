//
//  ContentView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//

import SwiftUI

struct PlayerView: View {
    var player: Player
    
    var body: some View {
        VStack {
            Image(player.team.imageName)
                .resizable()
                .frame(height: 250)
            
            Image(player.imageName)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .background(Circle())
                .foregroundColor(.white)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 15).offset(x: 0, y: -90)
                .padding(.bottom, -90)
            
            Text(player.name)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
            
            StatText(statName: "Age", statValue: String(player.age))
            StatText(statName: "Height", statValue: player.height)
            StatText(statName: "Weight", statValue: String(player.weight) + "lbs")
            
            Spacer()
        }.edgesIgnoringSafeArea(.top)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerView(player: players[2])
            .previewDevice("iPhone XR")
            .previewDisplayName("iPhone XR")
            
            PlayerView(player: players[2])
                .previewDevice("iPhone 8")
                .previewDisplayName("iPhone 8")
                .environment(\.sizeCategory, .extraLarge)
            
            PlayerView(player: players[2])
            .previewDevice("iPhone 8")
            .previewDisplayName("iPhone 8")
            .environment(\.sizeCategory, .extraSmall)
            
            PlayerView(player: players[2]).previewDevice("iPhone SE")
        }
    }
}
