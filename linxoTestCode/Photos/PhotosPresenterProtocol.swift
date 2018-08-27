//
//  PhotosProtocol.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 25/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation

protocol PhotosPresenterProtocol {
    func load()
    func numberOfRows() -> Int?
    func getPhoto(for index: Int) -> Photo?
}

protocol PhotosViewControllerProtocol {
    func reloadTableView()
    func dismissView()
    func show(title: String)
}
