//
//  PlayerList.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 5/26/20.
//

import SwiftUI

struct PlayerList: View {
    var body: some View {
        NavigationView {
            List(players) {
                player in
                NavigationLink(destination: PlayerView(player: player)) {
                    PlayerRow(player: player)
                }
            }.navigationBarTitle(Text("NBA Finals Players"), displayMode: .large)
        }
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
        PlayerList()
    }
}
