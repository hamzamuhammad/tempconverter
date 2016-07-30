//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Hamza Muhammad on 7/29/16.
//  Copyright © 2016 Hamza Muhammad. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        // Create a web view
        webView = WKWebView()
        
        // Set it as *the* view of this controller
        view = webView
        
        let site = "https://www.bignerdranch.com"
        let url = NSURL(string: site)
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("webView has loaded.")
    }
    
}
