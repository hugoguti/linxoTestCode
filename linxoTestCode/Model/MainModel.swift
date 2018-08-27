//
//  MainModel.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 25/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation

class MainModel {
    
    private var callbackDelegate: MainDataModelDelegate!
    private var albums: [Album]?
    
    init(callBackDelegate: MainDataModelDelegate) {
        self.callbackDelegate = callBackDelegate
    }

    // MARK: - Private functions
    private func getData(from url: URL, for requestType: RequestType) {
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                switch requestType {
                case .Albums :
                    self.albums = try JSONDecoder().decode([Album].self, from: data)
                    if let authorsUrl = URL(string: jsonUrl+authorsPage) {
                        self.getAuthors(from: authorsUrl)
                    }
                case .Authors:
                    if let albums = self.albums, let authors = try JSONDecoder().decode([Author]?.self, from: data) {
                        self.callbackDelegate.getDataFromURLDone(with: [albums, authors])
                    } else {
                        self.finishedWithError()
                    }
                case .Photos:
                    if let photos = try JSONDecoder().decode([Photo]?.self, from: data) {
                        self.callbackDelegate.getDataFromURLDone(with: photos)
                    }
                    break
                }
            } catch let jsonErr {
                self.finishedWithError()
                print("Error serializing json : ", jsonErr)
            }
            }.resume()
    }

    private func getAuthors(from url: URL) {
        getData(from: url, for: .Authors)
    }
    
    private func finishedWithError() {
        // TODO : renvoyer les bonnes informations
    }
    
    // MARK: - Public functions
    func getAlbums(from url: URL) {
        getData(from: url, for: .Albums)
    }
    
    func getPhotos(from url: URL) {
        getData(from: url, for: .Photos)
    }
}
