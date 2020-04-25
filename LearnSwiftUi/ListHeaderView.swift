//
//  ListHeaderView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/25/20.
//

import SwiftUI

struct ListHeaderView: View {
    var text: String
    var body: some View {
        HStack() {
            Text(text)
                .padding(.leading, 5)
            Spacer()
        }
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView(text: "Menu")
    }
}
