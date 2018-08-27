//
//  MainPresenterProtocol.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 24/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation
import UIKit

protocol MainPresenterProtocol {
    func load()
    func numberOfRows() -> Int?
    func getAlbum(for index: Int) -> Album? 
    func getAuthor(for authorID: Int) -> Author?
    func prepare(for segue: UIStoryboardSegue)
    func didSelectCell(at: IndexPath)
}

protocol MainViewControllerProtocol {
    func reloadTableView()
    func performSegue(with identifier: String)
}
