//
//  FachaiDetailsVC.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit

class FachaiDetailsVC: BaseViewController {
    let bgView = UIView()
    let headerImageView = UIImageView()
    lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textColor = UIColor(hex: "#E6E6E6")
        label.text = "柳青青"
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "female")
        return imageView
    }()
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.text = "女"
        label.textColor = .white
        return label
    }()
    lazy var genderView: UIView = {
        let gender = UIView()
        gender.backgroundColor = UIColor(hex: "#EC5399")
        gender.addSubview(self.iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5.auto())
        }
        gender.addSubview(self.genderLabel)
        genderLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(2.auto())
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5.auto())
        }
        gender.roundCorners(radius: 6.5.auto())
        return gender
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "北京 · 朝阳区"
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(hex: "#D7D7D7")
        return label
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    lazy var closeBtb: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        btn.backgroundColor = UIColor(hex: "#191919")
        btn.roundCorners(radius: 15.auto())
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func initWithUI() {
        super.initWithUI()
        view.backgroundColor = UIColor(hex: "#619EFF")
        bgView.backgroundColor = .black
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(18.auto())
            make.right.equalToSuperview().offset(-18.auto())
            make.height.equalTo(454.auto())
        }
        bgView.roundCorners(radius: 16.auto())
        
        bgView.addSubview(self.headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4.auto())
            make.left.equalToSuperview().offset(3.auto())
            make.right.equalToSuperview().offset(-3.auto())
            make.height.equalTo(331.auto())
        }
        headerImageView.roundCorners(radius: 16.auto())
        
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        bgView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.edges.equalTo(headerImageView)
        }
        
        
        
        
        bgView.addSubview(self.nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.top.equalTo(headerImageView.snp.bottom).offset(10.auto())
        }
        
        bgView.addSubview(self.genderView)
        genderView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.auto())
            make.centerY.equalTo(nickNameLabel.snp.centerY)
            make.height.equalTo(13.auto())
        }
        bgView.addSubview(self.addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.top.equalTo(nickNameLabel.snp.bottom).offset(4.auto())
        }
        
        let moreBtn = UIButton()
        moreBtn.setImage(UIImage(named: "more"), for: .normal)
        moreBtn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        bgView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.auto())
            make.centerY.equalTo(addressLabel.snp.centerY)
        }
        
        bgView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(addressLabel.snp.bottom).offset(15.auto())
            make.height.equalTo(18.auto())
        }
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        var lastView: UIView?
        for index in 0...5 {
            let paddedLabel = PaddedLabel()
            paddedLabel.text = "Hello, World!"
            paddedLabel.textColor = .white
            paddedLabel.font = .systemFont(ofSize: 10)
            paddedLabel.backgroundColor = UIColor(hex: "#4272D7")
            
            paddedLabel.leftPadding = 8.auto()
            paddedLabel.rightPadding = 8.auto()
            contentView.addSubview(paddedLabel)
            paddedLabel.snp.makeConstraints { make in
                if let vi = lastView {
                    make.left.equalTo(vi.snp.right).offset(5.auto())
                } else {
                    make.left.equalToSuperview().offset(15.auto())
                }
                make.centerY.equalToSuperview()
                make.height.equalTo(18.auto())
            }
            paddedLabel.roundCorners(radius: 7.auto())
            lastView = paddedLabel
        }
        contentView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(18.auto())
            if let vi = lastView {
                make.right.equalTo(vi.snp.right).offset(15.auto())
            } else {
                make.right.equalToSuperview()
            }
        }
        scrollView.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).priority(.low)
            make.right.greaterThanOrEqualTo(bgView)
        }
        
        self.view.addSubview(self.closeBtb)
        closeBtb.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.top).offset(-15.auto())
            make.right.equalTo(bgView.snp.right).offset(15.auto())
            make.width.height.equalTo(30.auto())
        }
    }
    
    @objc func moreClick() {
        MoreShowView.showMoreView {
            print("举报")
        } blackBlock: {
            print("黑名单")
            let alertController = UIAlertController(title: "", message: "拉黑后，双方无法查看对方微信号", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "拉黑", style: .default) { _ in
                
            }
            alertController.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "取消", style: .cancel) { _ in
                
            }
            alertController.addAction(okAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func closeClick() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func buttonClick() {
        self.navigationController?.pushViewController(FachaiDetailsContentVC(), animated: true)
    }
    
}

class PaddedLabel: UILabel {
    // 左边距
    var leftPadding: CGFloat = 8.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // 右边距
    var rightPadding: CGFloat = 8.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftPadding + rightPadding, height: size.height)
    }
}
