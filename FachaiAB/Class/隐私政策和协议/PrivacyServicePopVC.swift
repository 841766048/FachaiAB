//
//  PrivacyServicePopVC.swift
//  FachaiAB
//
//  Created by 张海彬 on 2024/1/12.
//

import UIKit
import YYText

class PrivacyServicePopVC: UIViewController {
    lazy var maskBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    lazy var popView: UIView = {
        let popView = UIView()
        popView.backgroundColor = .black
        return popView
    }()
    lazy var content_text: YYLabel = {
        let content_text = YYLabel()
        content_text.preferredMaxLayoutWidth = screenWidth - 24.auto()*2
        content_text.textColor = UIColor(hex: "#9D9D9D")
        content_text.font = .systemFont(ofSize: 15)
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
        attriStr.yy_lineSpacing = 10
        attriStr.yy_setTextHighlight(highlight01, range: range01)
        attriStr.yy_setTextHighlight(highlight02, range: range02)
        content_text.numberOfLines = 0
        content_text.attributedText = attriStr
        return content_text
    }()
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "服务协议和隐私政策"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        return titleLabel
    }()
    
    lazy var agreeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("同意", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.backgroundColor = UIColor(hex: "#4272D7")
        button.roundCorners(radius: 22)
        button.addTarget(self, action: #selector(agreeBtnClick), for: .touchUpInside)
        return button
    }()
    lazy var refuseBtn: UIButton = {
        let button = UIButton()
        button.setTitle("拒绝", for: .normal)
        button.setTitleColor(UIColor(hex: "#999990"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.backgroundColor = UIColor(hex: "#191919")
        button.roundCorners(radius: 22)
        
        button.addTarget(self, action: #selector(refuseBtnClick), for: .touchUpInside)
        return button
    }()
    var agreeBlock: (() -> ())? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initWithUI()
    }
    
    func initWithUI() {
        self.view.addSubview(self.maskBgView)
        self.maskBgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(self.popView)
        self.popView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        self.popView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24.auto())
        }
        self.popView.addSubview(self.content_text)
        self.content_text.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.auto())
            make.right.equalToSuperview().offset(-24.auto())
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20.auto())
        }
        self.popView.addSubview(self.agreeBtn)
        self.popView.addSubview(self.refuseBtn)
        self.agreeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.auto())
            make.right.equalToSuperview().offset(-24.auto())
            make.top.equalTo(self.content_text.snp.bottom).offset(24.auto())
            make.height.equalTo(44.auto())
        }
        self.refuseBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.auto())
            make.right.equalToSuperview().offset(-24.auto())
            make.top.equalTo(self.agreeBtn.snp.bottom).offset(20.auto())
            make.height.equalTo(44.auto())
            make.bottom.equalToSuperview().offset(-(16.auto()+bottomSafeAreaHeight))
        }
        
        self.popView.layoutIfNeeded()
        self.popView.roundCorners([.topLeft,.topRight], radius: 12)
    }
    @objc func agreeBtnClick() {
        self.agreeBlock?()
    }
    
    @objc func refuseBtnClick() {
        // 退出应用
        exit(0)
    }
}
