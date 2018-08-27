//
//  MainViewController.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 23/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var albumTableView: UITableView!
    
    var presenter: MainPresenterProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = MainPresenter.init(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        albumTableView.reloadData()
        albumTableView.showLoader()
        presenter?.load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        presenter?.prepare(for: segue)
    }
}

extension MainViewController: MainViewControllerProtocol {
    
    func performSegue(with identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    func reloadTableView() {
        albumTableView.hideLoader()
        albumTableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectCell(at: indexPath)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? loaderRowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCellID", for: indexPath) as! AlbumCell
        
        guard let presenter = presenter, let album = presenter.getAlbum(for: indexPath.row) else {
            return cell
        }
        cell.albumTitle.text = album.title
        if let author = presenter.getAuthor(for: album.userId) {
            cell.albumDescription.text = author.name
        } else {
            cell.albumDescription.text = ""
        }

        return cell
    }    
}
