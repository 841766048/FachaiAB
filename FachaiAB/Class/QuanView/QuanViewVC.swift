//
//  QuanViewVC.swift
//  FachaiAB
//
//  Created by   on 2024/1/18.
//

import UIKit
import WebKit

class QuanViewVC: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        configuration.userContentController = userContentController
        configuration.userContentController.add(self, name: "startFunction")
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        return webView
    }()
    var urlStr: String = ""
    lazy var locateInfoView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor(hex: "#191919")
        let label = UILabel()
        label.text = "开启定位权限，享受周边服务"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        topView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.centerY.equalToSuperview()
        }
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#4272D7")
        button.setTitle("去开启", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(openClick), for: .touchUpInside)
        topView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.auto())
            make.centerY.equalToSuperview()
            make.width.equalTo(68.auto())
            make.height.equalTo(28.auto())
        }
        button.roundCorners(radius: 12.auto())
        return topView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initWithUI()
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    func initWithUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        if let url = URL(string: urlStr) {
            var request = URLRequest(url: url)
            // 根据需要添加不同的 Accept 头部信息
            // 支持 webp 图片格式
            request.addValue("image/webp", forHTTPHeaderField: "Accept")
            // 加载网页
            self.webView.load(request)
        }
        
        self.view.addSubview(self.locateInfoView)
        self.locateInfoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(statusBarHeight+33.auto())
            make.height.equalTo(43.auto())
        }
        self.locateInfoView.isHidden = LocationManager.shared.isLocationPermissionGranted
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @objc func openClick() {
        LocationManager.shared.openAppSettings()
    }
    // 通知触发的方法
    @objc func appWillEnterForeground() {
        self.locateInfoView.isHidden = LocationManager.shared.isLocationPermissionGranted
    }
    // 可选：处理网页加载过程中的事件
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载网页")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("网页加载完成")
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("接收到服务器跳转请求即服务重定向时之后调用")
    }
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转")
        decisionHandler(.allow)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message.body = \(message.body)")
        print("message.name = \(message.name)")
        print("message.frameInfo.request = \(message.frameInfo.request)")
        if message.name == "startFunction" {
            if let dict = message.body as? [String: Any] {
                let type = "\(dict["type"]!)"
                if type == "5" {
                    let url_str = dict["url"] as? String ?? ""
                    if let url = URL(string: url_str), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            }
        }
    }
}
