//
//  WebViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 2/11/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webview: WKWebView!
    override func loadView() {
        let webconfiguration = WKWebViewConfiguration()
        webview = WKWebView(frame: .zero, configuration: webconfiguration)
        webview.uiDelegate = self
        view = webview
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://lrbc.vortexoptics.com/#!/")
        let myRequest = URLRequest(url: myURL!)
        webview.load(myRequest)
    }
}
