//
//  MoreShowView.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit

class MoreShowView: UIView {
    lazy var blackBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("拉黑", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.backgroundColor = UIColor(hex: "#4272D7", alpha: 1.0)
        btn.roundCorners(radius: 22.auto())
        btn.addTarget(self, action: #selector(blackClick), for: .touchUpInside)
        return btn
    }()
    lazy var reportBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("举报", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.backgroundColor = UIColor(hex: "#4272D7", alpha: 1.0)
        btn.roundCorners(radius: 22.auto())
        btn.addTarget(self, action: #selector(reportClick), for: .touchUpInside)
        return btn
    }()
    lazy var canceBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor(hex: "#999990"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.backgroundColor = UIColor(hex: "#191919", alpha: 1.0)
        btn.addTarget(self, action: #selector(dismissAnimated), for: .touchUpInside)
        btn.roundCorners(radius: 22.auto())
        return btn
    }()
    var reportBlock: (()->())?
    var blackBlock: (()->())?
    static func showMoreView(reportBlock: @escaping ()->(), blackBlock:@escaping ()->()) {
        let view = MoreShowView()
        view.reportBlock = reportBlock
        view.blackBlock = blackBlock
        view.showAnimated()
    }
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .black
        initWithUI()
    }
    func initWithUI() {
        self.addSubview(self.blackBtn)
        blackBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(49.auto())
            make.left.equalToSuperview().offset(36.auto())
            make.right.equalToSuperview().offset(-36.auto())
            make.height.equalTo(44.auto())
        }
        
        self.addSubview(self.reportBtn)
        reportBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36.auto())
            make.right.equalToSuperview().offset(-36.auto())
            make.height.equalTo(44.auto())
            make.top.equalTo(blackBtn.snp.bottom).offset(20.auto())
        }
        
        self.addSubview(self.canceBtn)
        canceBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36.auto())
            make.right.equalToSuperview().offset(-36.auto())
            make.height.equalTo(44.auto())
            make.top.equalTo(reportBtn.snp.bottom).offset(20.auto())
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func showAnimated() {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        
        let maskBtn = UIButton()
        maskBtn.backgroundColor = UIColor.clear
        maskBtn.addTarget(self, action: #selector(dismissAnimated), for: .touchUpInside)
        backgroundView.addSubview(maskBtn)
        maskBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(self)
        self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: 261.auto())
        self.roundCorners([.topLeft, .topRight], radius: 12.auto())
        if let mainWindow = keyWindow {
            mainWindow.addSubview(backgroundView)
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1.0
                self.transform = CGAffineTransform(translationX: 0, y: -self.bounds.height)
                
            }
        }
    }
    @objc func dismissAnimated() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
            self.transform = .identity
        }) { finished in
            self.superview?.removeFromSuperview()
        }
    }
    @objc func reportClick() {
        self.reportBlock?()
        dismissAnimated()
    }
    @objc func blackClick() {
        self.blackBlock?()
        dismissAnimated()
    }
}
