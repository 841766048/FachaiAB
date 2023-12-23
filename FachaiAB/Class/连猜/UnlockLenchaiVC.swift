//
//  UnlockLenchaiVC.swift
//  FachaiAB
//
//  Created by   on 2023/11/21.
//

import UIKit

class UnlockLenchaiVC: BaseViewController {
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
    lazy var unlock_btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("解锁", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: "#4272D7")
        btn.addTarget(self, action: #selector(unlock_btnClick), for: .touchUpInside)
        btn.roundCorners(radius: 10.auto())
        return btn
    }()
    lazy var end_btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("不了", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: "#191919")
        btn.addTarget(self, action: #selector(no_btnClick), for: .touchUpInside)
        btn.roundCorners(radius: 10.auto())
        return btn
    }()
    var dataModel: FachaiModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = self.dataModel {
            self.headerImageView.sd_setImage(with: URL(string: model.user_head))
            self.nickNameLabel.text = model.user_name
            self.genderLabel.text = model.user_sex
            if model.user_sex == "女" {
                self.iconImageView.image = UIImage(named: "female")
            } else {
                self.iconImageView.image = UIImage(named: "male_small")
            }
        }
    }
    override func initWithUI() {
        self.view.backgroundColor = UIColor(hex: "#619EFF")
        let bgView = UIView()
        bgView.backgroundColor = .black
        bgView.roundCorners(radius: 16.auto())
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18.auto())
            make.right.equalToSuperview().offset(-18.auto())
            make.centerY.equalToSuperview()
            make.height.equalTo(566.auto())
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.text = "恭喜你完成连猜\n是否要解锁TA"
        titleLabel.textColor = UIColor(hex: "#EC5399")
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(25.auto())
        }
        
        
        bgView.addSubview(self.unlock_btn)
        bgView.addSubview(self.end_btn)
        unlock_btn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(23.auto())
            make.right.equalTo(bgView.snp.centerX).offset(-7.5.auto())
            make.width.equalTo(112.auto())
            make.height.equalTo(34.auto())
        }
        end_btn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(23.auto())
            make.left.equalTo(bgView.snp.centerX).offset(7.5.auto())
            make.width.equalTo(112.auto())
            make.height.equalTo(34.auto())
        }
        
        bgView.addSubview(headerImageView)
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(3.auto())
            make.right.equalToSuperview().offset(-3.auto())
            make.bottom.equalToSuperview().offset(-67.auto())
            make.top.equalTo(end_btn.snp.bottom).offset(36.auto())
        }
        headerImageView.sd_setImage(with: URL(string: "https://img.keaitupian.cn/newupload/11/1700039147326498.jpg"))
        headerImageView.roundCorners(radius: 16.auto())
        
        bgView.addSubview(self.nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.top.equalTo(headerImageView.snp.bottom).offset(10.auto())
        }
        bgView.addSubview(genderView)
        genderView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.auto())
            make.centerY.equalTo(nickNameLabel.snp.centerY)
            make.height.equalTo(14.auto())
        }
        
    }
    
    @objc func unlock_btnClick() {
        let vc = FachaiDetailsVC()
        vc.dataModel = self.dataModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func no_btnClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
