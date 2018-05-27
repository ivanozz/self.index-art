//
//  MainViewController.swift
//  Self
//
//  Created by admin on 27.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainViewController: UITableViewController, NewsProtocol {
    
    var userId : String = ""
    var token : String = ""
    var newsList : [News] = []
    var newsSelectedId : Int = 0
    
    @IBOutlet var table: UITableView!
    
    let selfApi = SelfApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Загрузка новостей")
        selfApi.delegateNews = self
        selfApi.getNews(userId: userId, token: token)
        
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! CustomNewsCell
        
        cell.title.text = newsList[indexPath.row].name
        cell.date.text = newsList[indexPath.row].date
        cell.announce.text = newsList[indexPath.row].short_text + "..."
        cell.author.text = newsList[indexPath.row].autor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsSelectedId = indexPath.row
        performSegue(withIdentifier: "showOneNews", sender: self)
    }
    
    func newsLoaded(list: [News]) {
        newsList = list
        tableView.reloadData()
        configureTableView()
        SVProgressHUD.dismiss()
    }
    
    func configureTableView() {
        table.estimatedRowHeight = 44
        table.rowHeight = UITableViewAutomaticDimension
        table.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showOneNews" {
            if let newsVC = segue.destination as? NewsViewController {
                newsVC.userId = self.userId
                newsVC.token = self.token
                newsVC.newsData = newsList[self.newsSelectedId]
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
