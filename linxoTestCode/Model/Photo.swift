//
//  Photo.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 26/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
