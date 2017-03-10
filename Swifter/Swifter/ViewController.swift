//
//  ViewController.swift
//  Swifter
//
//  Created by QianTuFD on 2017/3/2.
//  Copyright © 2017年 fandy. All rights reserved.
//

//
//  ViewController.swift
//  Swift
//
//  Created by QianTuFD on 2017/2/21.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    var refreshControl: UIRefreshControl {
        let refresh = UIRefreshControl()
        refresh.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        refresh.backgroundColor = UIColor.red
        return refresh
    }
    
    var dataArray: [Int] = [Int]()
    
    var tableView: UITableView {
        let view = UITableView()
        view.frame = self.view.bounds
        view.dataSource = self
        view.delegate = self
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        refreshControl.attributedTitle = NSAttributedString(string: "刷新")
        tableView.addSubview(refreshControl)
        refreshData()
        
    }
    
    
    func refreshData() {
        self.dataArray.append(contentsOf: [1,2,3,4,5,6,7,8,9,0])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ViewController.identifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: ViewController.identifier)
        }
        cell?.textLabel?.text = String(self.dataArray[indexPath.row])
        return cell!;
    }
    
    
}



