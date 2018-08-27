//
//  ViewPresenter.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 24/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter {
    var viewController: MainViewControllerProtocol?
    var albums: [Album]?
    var authors: [Author]?
    var model: MainModel?
    var selectedAlbum: Album?
    
    required init(viewController: MainViewControllerProtocol) {
        self.viewController = viewController
        model = MainModel(callBackDelegate: self)
    }
    
    // MARK: - Private functions
    func reloadView(with albumsFromModel: [Album]?, and authorsFromModel:[Author]?) {
        authors = authorsFromModel
        if let albumsToSort = albumsFromModel {
            albums = albumsToSort.sorted(by: { $0.title < $1.title })
            DispatchQueue.main.async {
                self.viewController?.reloadTableView()
            }
        }
    }
    
    func load(from urlData: URL) {
        model?.getAlbums(from: urlData)
    }
}

extension MainPresenter: MainDataModelDelegate {
    func getDataFromURLDone<T>(with data: [T]...) {
        if let albumsData = data[0][0] as? [Album] , let authorsData = data[0][1] as? [Author] {
           reloadView(with: albumsData, and: authorsData)
        }
    }
}

extension MainPresenter: MainPresenterProtocol {
    func didSelectCell(at: IndexPath) {
        selectedAlbum = getAlbum(for: at.row)
        viewController?.performSegue(with: SegueIdentifier.openPhotosView.rawValue)
    }
    
    func prepare(for segue: UIStoryboardSegue) {
        if segue.identifier == SegueIdentifier.openPhotosView.rawValue {
            if let viewController = segue.destination as? PhotosViewController, let selectedAlbum = selectedAlbum {
                viewController.presenter = PhotosPresenter(viewController: viewController, for: selectedAlbum)
            }
        }
    }
    
    func getAlbum(for index: Int) -> Album? {
        if let album = albums?[index] {
            return album
        }
        return nil
    }
    
    func getAuthor(for authorID: Int) -> Author? {
        if let author = authors?.first(where: {$0.id == authorID}) {
            return author as Author
        }
        return nil
    }
    
    func numberOfRows() -> Int? {
        if let rows = albums?.count {
            return rows
        }
        return nil
    }
    
    func load() {
        guard let urlData = URL(string: jsonUrl+albumsPage) else {
            return
        }
        load(from: urlData)
    }
}
