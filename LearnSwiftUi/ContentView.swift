//
//  ContentView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orderModel: OrderModel
    @State var isMenuDisplayed = true
    var body: some View {
        VStack {
//            ContentHeaderView()
//                .layoutPriority(2)
            
            Button(action: {
                self.isMenuDisplayed.toggle()
            }) {
                PageTitleView(title: "Order Pizza", isDisplayingOrders: isMenuDisplayed)
            }
            
            MenuListView(orderModel: orderModel)
                .layoutPriority(isMenuDisplayed ? 1.0 : 0.5)
            
            OrderListView(orderModel: orderModel)
                .layoutPriority(isMenuDisplayed ? 0.5 : 1.0)
            
//            Spacer()
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(orderModel: OrderModel())
                .environmentObject(UserPreferences())
            ContentView(orderModel: OrderModel())
                .environmentObject(UserPreferences())
                .colorScheme(.dark)
                .background(Color.black)
            .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}

