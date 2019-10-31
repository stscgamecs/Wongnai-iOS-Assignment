//
//  ViewController.swift
//  Wongnai-iOS-Assignment
//
//  Created by Z94me on 30/10/2562 BE.
//  Copyright © 2562 Z94me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataList: [Photo] = []
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        loadingView.isHidden = false
        let api = ApiService()
        api.getApi { [weak self ] result in
            switch result {
            case .success(let data):
                self?.dataList = data.photos
                self?.loadingView.isHidden = true
                self?.tableView.reloadData()
                api.page += 1
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .destructive)
                alert.addAction(action)
            }
        }
    } 
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewMenuListCell else {
            return UITableViewCell()
        }
        cell.setUi(Model: dataList[indexPath.row])
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       if indexPath.row == dataList.count - 1 && loadingView.isHidden {
         getData()
       }
     }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.size.width / 2.0
    let height = width * 1.5
    return CGSize(width: width, height: height)
  }
}
