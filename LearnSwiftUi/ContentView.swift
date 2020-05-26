//
//  ContentView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("gs")
                .resizable()
                .frame(height: 250)
            
            Image("steph")
                .clipShape(Circle())
                .background(Circle())
                .foregroundColor(.white)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 15).offset(x: 0, y: -90)
                .padding(.bottom, -90)
            
            Text("Steph Curry")
                .font(.system(size: 30))
                .fontWeight(.bold)
            
            StatText(statName: "Age", statValue: "31")
            StatText(statName: "Height", statValue: "6' 3\"")
            StatText(statName: "Weight", statValue: "190lbs")
            
            Spacer()
        }.edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
