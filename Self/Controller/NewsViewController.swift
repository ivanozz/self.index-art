//
//  NewsViewController.swift
//  Self
//
//  Created by admin on 24.05.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var userId : String = ""
    var token : String = ""
    var newsData : News?
    
    @IBOutlet var date: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var head: UILabel!
    @IBOutlet var commentButton: UIButton!
    
    @IBOutlet var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        date.text = newsData?.date
        author.text = newsData?.autor
        head.text = newsData?.name
        text.text = newsData?.text
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        text.setContentOffset(CGPoint.zero, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToComments2" {
            if let commentsVC = segue.destination as? CommentsViewController {
                commentsVC.userId = self.userId
                commentsVC.token = self.token
                commentsVC.newsId = (self.newsData?.id)!
            }
        }
        
    }
    
    
    @IBAction func goToComments2(_ sender: Any) {
        
        performSegue(withIdentifier: "goToComments2", sender: self)
        
    }
    
}
