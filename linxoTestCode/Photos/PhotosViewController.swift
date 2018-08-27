//
//  PhotosViewController.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 25/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {
    
    var presenter: PhotosPresenterProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var photosTableView: UITableView!
    @IBOutlet weak var albumTitle: UILabel!
    
    @IBAction func navigationBack(_ sender: Any) {
        dismissView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosTableView.reloadData()
        photosTableView.showLoader()
        presenter?.load()
    }
    
}

extension PhotosViewController: PhotosViewControllerProtocol {
    
    func show(title: String) {
        albumTitle.text = "from_album".loalized()+title
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    func reloadTableView() {
        photosTableView.hideLoader()
        photosTableView.reloadData()
    }
}

extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loaderRowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellID", for: indexPath) as! PhotoCell
        guard let presenter = presenter, let photo = presenter.getPhoto(for: indexPath.row) else {
            return cell
        }
        cell.photoTitle.text = photo.title
        cell.photoImage.loadImageLazy(from: photo.thumbnailUrl)
        return cell
    }
}
