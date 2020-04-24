//
//  PostViewModel.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//
import UIKit
import Combine

class PostViewModel: ObservableObject {
    @Published var articles = [PostModel]()
    
    init() {
        getPosts()
    }
    
    private func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        NetworkManager.loadData(url: url) { articles in
            if let articles = articles {
                self.articles = articles.map(PostModel.init)
            }
        }
        
    }
}
