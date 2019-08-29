//
//  LMLocationController.swift
//  Anonymous_friends
//
//  Created by 叶世昌 on 2019/1/4.
//  Copyright © 2019 Luomi. All rights reserved.
//

import UIKit

/// 屏幕高
let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
/// 屏幕宽
let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
/// iPhone X底部加 尺寸
let IphoneXBottomMargin: CGFloat = 34
/// iPhone X顶部加 尺寸
let IphoneXTopMargin: CGFloat = 24
/// 导航栏高度
let NavigationBarHeight: CGFloat = IsiphoneX ? 88 : 64
/// tabBar高度
let TabBarHeight: CGFloat = IsiphoneX ? 83 : 49
/// 状态栏高度
let StatusHeight: CGFloat = IsiphoneX ? 44 : 20
/// 是否是iPhoneX距离底部
let iphoneXBottom = IsiphoneX ? IphoneXBottomMargin : 0

/// 判断iPhoneX
let IsiphoneX: Bool = kScreenHeight == 812 ? true : false


class LMLocationController: UITableViewController {
  
    
    lazy var headerView: LMLocationControllerHeaderView = {
        let headerView = LMLocationControllerHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: LMLocationControllerHeaderViewHeight))
        return headerView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController.init(searchResultsController: nil)
        
        //        searchController.hidesNavigationBarDuringPresentation = false
        
        //        let searchField = searchController.searchBar.value(forKeyPath: "_searchField") as? UITextField
        //        searchField?.borderStyle = .none
        //        searchField?.font = UIFont.systemFont(ofSize: 14)
        //        searchField?.placeholder = "搜索您附近位置"
        //        searchController.searchBar.setSearchFieldBackgroundImage(#imageLiteral(resourceName: "qz_searbg"), for: .normal)
        
        searchController.searchBar.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: LMLocationControllerHeaderViewHeight)
        searchController.searchBar.sizeToFit()
        return searchController
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        automaticallyAdjustsScrollViewInsets = true
//        extendedLayoutIncludesOpaqueBars = true

        title = "我在哪"
        
        
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
//        view.addSubview(tableview)
//
//        tableview.frame = CGRect.init(x: 0, y: NavigationBarHeight + LMLocationControllerHeaderViewHeight, width: kScreenWidth, height: kScreenHeight - NavigationBarHeight - LMLocationControllerHeaderViewHeight)
        
    }

    
}

extension LMLocationController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        cell.textLabel?.text = "11111111111111111111"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

/// headerview
let LMLocationControllerHeaderViewHeight: CGFloat = 63
class LMLocationControllerHeaderView: UIView {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController.init(searchResultsController: nil)
        
//        searchController.hidesNavigationBarDuringPresentation = false
        
//        let searchField = searchController.searchBar.value(forKeyPath: "_searchField") as? UITextField
//        searchField?.borderStyle = .none
//        searchField?.font = UIFont.systemFont(ofSize: 14)
//        searchField?.placeholder = "搜索您附近位置"
//        searchController.searchBar.setSearchFieldBackgroundImage(#imageLiteral(resourceName: "qz_searbg"), for: .normal)
        
        searchController.searchBar.sizeToFit()
        return searchController
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubview(searchController.searchBar)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        
        searchController.searchBar.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
