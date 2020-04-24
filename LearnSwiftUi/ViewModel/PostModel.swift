//
//  PostModel.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//
import UIKit

class PostModel: Identifiable {
    let id = UUID()
    let post: PostResponse
    
    init(article: PostResponse) {
        self.post = article
    }
    
    var title: String {
        return post.title ?? ""
    }
    
    var description: String {
        return post.body ?? ""
    }
}
