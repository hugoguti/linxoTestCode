//
//  PhotosPresenter.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 25/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation

class PhotosPresenter {
    
    var viewController: PhotosViewControllerProtocol?
    var album: Album?
    var model: MainModel?
    var photos: [Photo]?
    
    required init(viewController: PhotosViewControllerProtocol, for album: Album) {
        self.viewController = viewController
        self.album = album
        model = MainModel(callBackDelegate: self)
    }
    
    // MARK: - Privte functions
    func reloadView(with photosFromModel: [Photo]?) {
        photos = photosFromModel
        DispatchQueue.main.async {
            self.viewController?.reloadTableView()
        }
    }
}

extension PhotosPresenter: MainDataModelDelegate {
    func getDataFromURLDone<T>(with data: [T]...) {
        reloadView(with: data[0] as? [Photo])
    }
}

extension PhotosPresenter: PhotosPresenterProtocol {
    func numberOfRows() -> Int? {
        if let rows = photos?.count {
            return rows
        }
        return nil
    }
    
    func getPhoto(for index: Int) -> Photo? {
        if let photo = photos?[index] {
            return photo
        }
        return nil
    }
    
    func load() {
        if let album = album, let model = model {
            viewController?.show(title: album.title)
            let albumIDRequest = String(format: "%@=%d", albumIDParam, album.id)
            guard let urlData = URL(string: jsonUrl+photosPage+albumIDRequest) else {
                viewController?.dismissView()
                return
            }
            model.getPhotos(from:urlData)
        }
    }
}
