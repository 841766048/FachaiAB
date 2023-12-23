//
//  PrivacyPolicyVC.swift
//  FachaiAB
//
//  Created by   on 2023/11/20.
//

import UIKit
import AutoInch
import SnapKit
import YYText


class PrivacyPolicyVC: BaseViewController {
    let bgView = UIView()
    let maskView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initWithUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func initWithUI() {
        super.initWithUI()
        self.bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(self.bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        maskView.backgroundColor = .black
        bgView.addSubview(maskView)
        maskView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
        }
        
        
        let titleLabel = UILabel();
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "服务协议和隐私政策"
        maskView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24.auto())
        }
        
        let content_text = YYLabel()
        content_text.textColor = .white
        content_text.font = .systemFont(ofSize: 15)
        content_text.preferredMaxLayoutWidth = screenWidth - 48.auto()
        let textStr = "请你务必审慎阅读、充分理解“隐私政策”各条款，包括但不限于：为了更好的向你提供服务，我们需要收集你的设备标识、操作日志等信息用于分析、优化应用性能。\n\n 你可阅读《用户协议》《隐私政策》了解详细信息。如果你同意，请点击下面按钮开始接受我们的服务。"
        let range01 = (textStr as NSString).range(of: "《用户协议》", options: .caseInsensitive)
        let range02 = (textStr as NSString).range(of: "《隐私政策》", options: .caseInsensitive)
        let attriStr = NSMutableAttributedString(string: textStr)
        attriStr.yy_color = .white
        attriStr.yy_font = .systemFont(ofSize: 15)
        attriStr.yy_setColor(UIColor(hex: "#4272D7"), range: range01)
        attriStr.yy_setColor(UIColor(hex: "#4272D7"), range: range02)
        let highlight01 = YYTextHighlight()
        highlight01.tapAction = { _, _, _, _ in
            print("用户协议")
            let vc = PolicyVC()
            vc.isPolicy = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let highlight02 = YYTextHighlight()
        highlight02.tapAction = { _, _, _, _ in
            print("隐私政策")
            let vc = PolicyVC()
            vc.isPolicy = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        attriStr.yy_setTextHighlight(highlight01, range: range01)
        attriStr.yy_setTextHighlight(highlight02, range: range02)
        content_text.numberOfLines = 0
        content_text.attributedText = attriStr
        maskView.addSubview(content_text)
        content_text.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.auto())
            make.right.equalToSuperview().offset(-24.auto())
            make.top.equalTo(titleLabel.snp.bottom).offset(20.auto())
        }
        
        let button01 = UIButton()
        button01.setTitle("同意", for: .normal)
        button01.titleLabel?.font = .systemFont(ofSize: 17)
        button01.setTitleColor(.white, for: UIControl.State.normal)
        button01.backgroundColor = UIColor(hex: "#4272D7")
        button01.tag = 10
        button01.addTarget(self, action: #selector(buttonClick(_ :)), for: .touchUpInside)
        maskView.addSubview(button01)
        button01.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36.auto())
            make.right.equalToSuperview().offset(-36.auto())
            make.height.equalTo(44.auto())
            make.top.equalTo(content_text.snp.bottom).offset(24.auto())
        }
        button01.roundCorners(radius: 22.auto())
        
        let button02 = UIButton()
        button02.setTitle("拒绝", for: .normal)
        button02.titleLabel?.font = .systemFont(ofSize: 17)
        button02.setTitleColor(UIColor(hex: "#999990"), for: UIControl.State.normal)
        button02.backgroundColor = UIColor(hex: "#191919")
        button02.tag = 20
        button02.addTarget(self, action: #selector(buttonClick(_ :)), for: .touchUpInside)
        button02.roundCorners(radius: 22.auto())
        maskView.addSubview(button02)
        button02.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36.auto())
            make.right.equalToSuperview().offset(-36.auto())
            make.height.equalTo(44.auto())
            make.top.equalTo(button01.snp.bottom).offset(20.auto())
            make.bottom.equalToSuperview().offset(-(16.auto()+bottomSafeAreaHeight))
        }
        
        maskView.layoutIfNeeded()
        maskView.roundCorners(radius: 12.auto())
    }
    @objc func buttonClick(_ send: UIButton) {
        if send.tag == 10 {
            // 同意
            LocalStorage.savePrivacyPolicy(true)
            let notification = Notification(name: .switchRootViewController)
            NotificationCenter.default.post(notification)
        } else {
            // 拒绝
            toast("您需要同意隐私协议和政策才能正常使用App", state: .info)
        }
    }
}


