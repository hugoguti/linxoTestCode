//
//  ImageLazy.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 26/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageLazy(from urlString: String) {
        guard let urlData = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: urlData) { (data, response, err) in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

extension String {
    
    func loalized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
