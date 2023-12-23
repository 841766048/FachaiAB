//
//  PolicyVC.swift
//  FachaiAB
//
//  Created by   on 2023/11/20.
//

import UIKit
import WebKit

class PolicyVC: BaseViewController, WKNavigationDelegate {
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 15)
        textView.textColor = .white
        textView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.isEditable = false // 禁止编辑
        return textView
    }()
    var webView: WKWebView!
    var isPolicy = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func initWithUI() {
        super.initWithUI()
        // 初始化 WKWebView
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        // 添加 WKWebView 到视图中
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(navigationBarTotalHeight)
        }
        if isPolicy {
            self.title = "隐私政策"
            if let url = URL(string: "https://bai.tongchengjianzhi.cn/ba/ab/yszc.html") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        } else {
            self.title = "用户协议"
            if let url = URL(string: "https://bai.tongchengjianzhi.cn/ba/ab/yhxy.html") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    // WKNavigationDelegate 方法，可选
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // WebView 开始加载网页
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // WebView 加载完成
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // WebView 加载失败
        print("WebView error: \(error.localizedDescription)")
    }
}
