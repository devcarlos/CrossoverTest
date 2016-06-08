//
//  HomeViewController.swift
//  CrossoverTest
//
//  Created by Carlos Alcala on 6/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    var request: Request?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let url = BaseRouter().baseUrl {
        
            NSLog("URL: \(url)")
            loadData()
        }
    }
    
    deinit {
        request?.cancel()
    }
    
    func loadData() {
        request = APIManager.sharedInstance.getArticles { [unowned self] articles in
            self.request = nil
            print("articles found: \(articles.count)")
            
            for article in articles {
                print("ID: \(article.articleID)")
                print("TITLE: \(article.title)")
                print("BODY: \(article.body)")
            }
            
        }
    }

}
