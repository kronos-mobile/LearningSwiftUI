//
//  PlayerRow.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 5/26/20.
//

import SwiftUI

struct PlayerRow: View {
    var player: Player
    
    var body: some View {
        HStack {
            Image(player.imageName)
                .resizable().scaledToFit()
                .clipShape(Circle())
                .background(Circle())
                .foregroundColor(player.team.color)
            Text(player.name).font(.largeTitle)
            Spacer()
        }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            PlayerRow(player: players[0]).previewLayout(.fixed(width: 500, height: 100))
            PlayerRow(player: players[1]).previewLayout(.fixed(width: 500, height: 100))
            PlayerRow(player: players[2]).previewLayout(.fixed(width: 500, height: 100))
        }
    }
}
