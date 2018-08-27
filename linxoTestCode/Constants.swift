//
//  Constants.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 24/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation

// MARK: - For data model
let jsonUrl = "https://jsonplaceholder.typicode.com/"
let albumsPage = "albums"
let authorsPage = "users"
let photosPage = "photos"
let albumIDParam = "?albumId"

enum RequestType {
    case Albums
    case Authors
    case Photos
}

// MARK: - For views
let loaderRowsNumber = 20

// MARK: - For Storyboard
enum SegueIdentifier: String {
    case openPhotosView
    //Si jamais il y a d'autres viewcontroller à ouvrir dans le storyboard
}
