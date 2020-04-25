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
            ContentHeaderView()
            
            MenuListView()
            
            OrderListView()
            
            Spacer()
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//            ContentView()
//                .colorScheme(.dark)
//                .background(Color.black)
//            .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}

