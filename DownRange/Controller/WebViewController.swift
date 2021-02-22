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
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
