//
//  PostResponse.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//

struct PostResponse: Codable {
    let userId: Int
    let id: Int?
    let title: String?
    let body: String?
}
