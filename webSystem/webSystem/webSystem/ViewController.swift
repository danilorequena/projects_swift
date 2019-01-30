//
//  ViewController.swift
//  webSystem
//
//  Created by Danilo Requena on 30/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

 
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var internalButton: UIButton!
    @IBOutlet weak var externalButton: UIButton!
                   var urlString: String = "https://www.google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

    @IBAction func InternalPage(_ sender: UIButton) {
        
        urlString = "https://www.apple.com"
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        sender.resignFirstResponder()
    }
    
    @IBAction func ExternalPage(_ sender: UIButton) {
        urlString = "https://www.amazon.com"
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        sender.resignFirstResponder()
    }
}

