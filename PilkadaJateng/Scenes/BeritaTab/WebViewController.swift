//
//  WebViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import WebKit
import PKHUD

class WebViewController: UIViewController {
    var webView: WKWebView!
    var urlString: String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let urlString = urlString, let url = URL(string: urlString) {
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        }
    }
    
    @IBAction func cancelBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        HUD.show(.labeledProgress(title: "Memuat halaman...", subtitle: nil))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HUD.show(.labeledSuccess(title: "Sukses", subtitle: nil))
        HUD.hide()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        HUD.show(.labeledError(title: "Error", subtitle: "\(error.localizedDescription)"))
        HUD.hide()
    }
}
