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
    var page = 1
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(numberPage: page)
    }
    
    func getData(numberPage:Int) {
        loadingView.isHidden = false
        let api = ApiService()
        api.getApi(page: numberPage) { [weak self ] result in
            switch result {
            case .success(let data):
                self?.dataList.append(contentsOf: data.photos) 
                self?.loadingView.isHidden = true
                self?.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .destructive)
                alert.addAction(action)
                self?.loadingView.isHidden = true
                self?.present(alert, animated: true)
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
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataList.count - 1 && loadingView.isHidden {
            let countPage = page + 1
            getData(numberPage: countPage)
        }
    }
}
