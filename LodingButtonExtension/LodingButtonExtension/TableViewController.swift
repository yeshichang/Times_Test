//
//  TableViewController.swift
//  LodingButtonExtension
//
//  Created by 叶世昌 on 2018/12/6.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView.init()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 27
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        cell?.textLabel?.text = "字号\(indexPath.row + 14)"
        cell?.label1.font = UIFont.systemFont(ofSize: (CGFloat(14 + indexPath.row)))
        cell?.label2.font = UIFont.boldSystemFont(ofSize: (CGFloat(14 + indexPath.row)))
        return cell!
    }

}
