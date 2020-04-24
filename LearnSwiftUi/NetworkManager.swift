//
//  NetworkManager.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//

import UIKit

class NetworkManager {
    
    static func loadData(url: URL, completion: @escaping ([PostResponse]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let response = try? JSONDecoder().decode([PostResponse].self, from: data) {
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }.resume()
        
    }
}
