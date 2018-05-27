//
//  CommentsViewController.swift
//  Self
//
//  Created by admin on 24.05.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SVProgressHUD

class CommentsViewController: UITableViewController, CommentsProtocol {

    var userId : String = ""
    var token : String = ""
    var newsId : String = ""
    
    @IBOutlet var table: UITableView!
    var commentsList : [Comment] = []
    
    let selfApi = SelfApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show(withStatus: "Загрузка комментариев")
        selfApi.delegateComments = self
        selfApi.getCommentsByNews(userId: userId, token: token, newsId: newsId)
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CustomCommentCell

        // Configure the cell...
        cell.author.text = commentsList[indexPath.row].name
        cell.date.text = commentsList[indexPath.row].date
        cell.comment.text = commentsList[indexPath.row].comment
        
        let nestConstant = 20
        let maxNestComment = 3
        let maxNestWidth = nestConstant * maxNestComment
        let nestValue = commentsList[indexPath.row].nest * nestConstant
        
        cell.nest.constant = CGFloat(nestValue > maxNestWidth ? maxNestWidth : nestValue);
        
        return cell
    }

    func commentsLoaded(list: [Comment]) {
        commentsList = list
        table.reloadData()
        SVProgressHUD.dismiss()
    }
    
    func commentAdded(status: Bool, message: String) {
        table.reloadData()
        SVProgressHUD.dismiss()
        
        if(!status && message != "") {
            SVProgressHUD.showError(withStatus: message)
        }
    }
    
    func configureTableView() {
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.estimatedRowHeight = 44
        table.rowHeight = UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    @IBAction func addCommentButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Новый комментарий", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Отправить", style: .default) { (action) in

            if textField.text != "" {
                self.selfApi.delegateComments = self
                self.selfApi.addCommentByNews(userId: self.userId, token: self.token, newsId: self.newsId, comment: textField.text!)
                
                SVProgressHUD.show()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Текст"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
