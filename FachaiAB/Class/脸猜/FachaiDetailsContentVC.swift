//
//  FachaiDetailsContentVC.swift
//  FachaiAB
//
//  Created by   on 2023/11/21.
//

import UIKit

class FachaiDetailsContentVC: BaseViewController {
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
    lazy var checkBtb: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(checkClcik), for: .touchUpInside)
        btn.setTitle("查看微信号", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.backgroundColor = UIColor(hex: "#04B029")
        btn.roundCorners(radius: 10.auto())
        return btn
    }()
    lazy var desLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: "#AFAFAF")
        return label
    }()
    var dataModel: FachaiModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "用户详情"
        
        if let model = self.dataModel {
            self.headerImageView.sd_setImage(with: URL(string: model.user_head))
            self.addressLabel.text = model.user_city
            self.nickNameLabel.text = model.user_name
            self.genderLabel.text = model.user_sex
            if model.user_sex == "女" {
                self.iconImageView.image = UIImage(named: "female")
            } else {
                self.iconImageView.image = UIImage(named: "male_small")
            }
            let contentView = UIView()
            scrollView.addSubview(contentView)
            
            var lastView: UIView?
            for label in model.user_label {
                let paddedLabel = PaddedLabel()
                paddedLabel.text = label
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
            self.desLabel.text = "交友宣言\n\(model.user_declaration)"
        }
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
        bgView.backgroundColor = .black
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(navigationBarTotalHeight+23)
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
        
        
        self.view.addSubview(self.desLabel)
        desLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.right.equalToSuperview().offset(-15.auto())
            make.top.equalTo(bgView.snp.bottom).offset(18.auto())
        }
        desLabel.text = "交友宣言\n千山万水，无数黑夜，等一轮明月"
        
        if LocalStorage.loadBlackList().contains(self.dataModel?.id ?? "") {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 12)
            label.textColor = UIColor(hex: "#AFAFAF")
            label.text = "您已经拉黑对方";
            self.view.addSubview(label)
            label.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(60.auto())
                make.right.equalToSuperview().offset(-60.auto())
                make.top.equalTo(desLabel.snp.bottom).offset(20.auto())
                make.height.equalTo(44.auto())
            }
        } else {
            self.view.addSubview(self.checkBtb)
            checkBtb.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(60.auto())
                make.right.equalToSuperview().offset(-60.auto())
                make.top.equalTo(desLabel.snp.bottom).offset(20.auto())
                make.height.equalTo(44.auto())
            }
        }
    }
    
    @objc func moreClick() {
        MoreShowView.showMoreView {
            print("举报")
        } blackBlock: {
            print("黑名单")
            let alertController = UIAlertController(title: "", message: "拉黑后，双方无法查看对方微信号", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "拉黑", style: .default) { _ in
                FachaiViewModel.submitBlack {
                    LocalStorage.saveBlackList(self.dataModel?.id ?? "")
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            alertController.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "取消", style: .cancel) { _ in
                
            }
            alertController.addAction(okAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func checkClcik() {
        let msg = "对方的微信号是\n\(dataModel?.id ?? "")"
        let alertController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "关闭", style: .cancel) { _ in
            
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "复制", style: .default) { _ in
            
        }
        alertController.addAction(okAction)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
}
