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
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    
    func getData(){
        let api = ApiService()
        api.getApi { [weak self ] result in
            switch result {
            case .success(let data):
                self?.dataList = data.photos
                self?.tableView.reloadData()
            case .failure(_):
                print(Error.self)
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
