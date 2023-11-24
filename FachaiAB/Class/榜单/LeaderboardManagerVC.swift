//
//  LeaderboardManagerVC.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit
import WebKit

class LeaderboardManagerVC: BaseViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    
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
    init() {
        super.init(nibName: nil, bundle: nil)
        withUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.backgroundColor = UIColor(hex: "#191919")
        self.tabBarController?.tabBar.barTintColor = UIColor(hex: "#191919")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        // 刷新WkWeview
        webView.reload()
    }
    func withUI() {
        DispatchQueue.main.async {
            self.view.addSubview(self.webView)
            let urlString = Network.instance.getH5()
//            let urlString = "https://n.3km.biz/uploads/yuedanios/user/album/a6/73b/a673b4b24dc4f105410b8ac4c0891c55.webp/m"
            if let url = URL(string: urlString) {
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
            self.titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            navigationBar_bottom_View.addSubview(self.back_btn)
            self.back_btn.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(14.auto())
                make.centerY.equalToSuperview()
            }
        }
        
    }
    override func initWithUI() {
        super.initWithUI()
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
//    // 检查当前页面是否为首页
    func isWebViewAtHome() -> Bool {
        let history = webView.backForwardList
        return !webView.canGoBack && history.backList.count == 0
    }
    func configureTransparentNavigationBar() {
        if #available(iOS 15.0, *) {
            let var_appearance = UINavigationBarAppearance()
            var_appearance.configureWithDefaultBackground()
            var_appearance.shadowColor = nil
            var_appearance.backgroundEffect = nil
            var_appearance.backgroundColor = UIColor.clear
            var_appearance.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.white
            ]
            self.navigationController?.navigationBar.backgroundColor = UIColor.black
            self.navigationController?.navigationBar.barTintColor = UIColor.black
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.standardAppearance = var_appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = var_appearance
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.black
            self.navigationController?.navigationBar.barTintColor = UIColor.black
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.white
            ]
        }
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "startFunction" {
            if let dict = message.body as? [String: Any] {
                let type = dict["type"] as? Int ?? 0
                if type == 5 {
                    let url_str = dict["url"] as? String ?? ""
                    if let url = URL(string: url_str), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else if type == 15 {
                    let url_str = dict["url"] as? String ?? ""
                    let web = LeaderboardWebView()
                    web.urlStr = url_str
                    self.navigationController?.pushViewController(web, animated: true)
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
