//
//  LeaderboardWebView.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/23.
//

import Foundation
import WebKit

class LeaderboardWebView: BaseViewController, WKNavigationDelegate, WKScriptMessageHandler {
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
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    lazy var back_btn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame.size = CGSize(width: 22, height: 22)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return  button
    }()
    var urlStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func initWithUI() {
        self.view.addSubview(self.webView)
        if let url = URL(string: urlStr) {
            var request = URLRequest(url: url)
            // 根据需要添加不同的 Accept 头部信息
            // 支持 webp 图片格式
            request.addValue("image/webp", forHTTPHeaderField: "Accept")
            // 加载网页
            self.webView.load(request)
        }
        
        let navigationBarView = UIView()
        navigationBarView.backgroundColor = UIColor(hex: "#191919")
        
        let navigationBar_bottom_View = UIView()
        navigationBarView.addSubview(navigationBar_bottom_View)
        navigationBar_bottom_View.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(navigationBarHeight)
        }
        
        self.view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(navigationBarTotalHeight)
        }
        navigationBarView.backgroundColor = UIColor(hex: "#191919")
        navigationBar_bottom_View.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        navigationBar_bottom_View.addSubview(self.back_btn)
        back_btn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14.auto())
            make.centerY.equalToSuperview()
        }
    }
    // 可选：处理网页加载过程中的事件
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载网页")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("网页加载完成")
        self.back_btn.isHidden = isWebViewAtHome()
        if let title = webView.title {
            self.titleLabel.text = title.count > 0 ? title: "榜单"
        }
    }
    // 检查当前页面是否为首页
    func isWebViewAtHome() -> Bool {
        let history = webView.backForwardList
        return !webView.canGoBack && history.backList.count == 0
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message.body = \(message.body)")
        print("message.name = \(message.name)")
        print("message.frameInfo.request = \(message.frameInfo.request)")
        if message.name == "startFunction" {
            if let dict = message.body as? [String: Any] {
                let type = dict["type"] as? Int ?? 0
                if type == 5 {
                    let url_str = dict["url"] as? String ?? ""
                    if let url = URL(string: url_str), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            }
        }
    }
    @objc func backButtonClick() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
