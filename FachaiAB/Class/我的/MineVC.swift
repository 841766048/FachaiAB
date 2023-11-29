//
//  MineVC.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit
import StoreKit

class MineVC: BaseViewController {
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "my_top_touxiang")
        return imageView
    }()
    lazy var nickName: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.text = "独角兽"
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        return nameLabel
    }()
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#999999")
        label.font = .systemFont(ofSize: 13)
        label.text = LocalStorage.getPhoneNumber() ?? ""
        return label
    }()
    lazy var gender_icon_imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "male")
        return imageView
    }()
    lazy var headView: UIView = {
        let view = UIView()
        view.addSubview(self.headImageView)
        headImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.auto())
            make.width.height.equalTo(60.auto())
        }
        headImageView.layer.cornerRadius = 30.auto()
        headImageView.layer.masksToBounds = true
        view.addSubview(self.nickName)
        nickName.snp.makeConstraints { make in
            make.left.equalTo(headImageView.snp.right).offset(17.auto())
            make.top.equalTo(headImageView.snp.top).offset(6.auto())
        }
        view.addSubview(self.gender_icon_imageView)
        gender_icon_imageView.snp.makeConstraints { make in
            make.centerY.equalTo(nickName.snp.centerY)
            make.left.equalTo(nickName.snp.right).offset(8.auto())
            make.width.height.equalTo(17.auto())
        }
        view.addSubview(self.phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(headImageView.snp.right).offset(17.auto())
            make.top.equalTo(nickName.snp.bottom).offset(3.auto())
        }
        
        let right_icon = UIImageView(image: UIImage(named: "right_icon"))
        view.addSubview(right_icon)
        right_icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14.auto())
        }
        
        let headBtn = UIButton()
        headBtn.backgroundColor = .clear
        headBtn.addTarget(self, action: #selector(headBtnClick), for: .touchUpInside)
        view.addSubview(headBtn)
        headBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    lazy var desLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#AFAFAF")
        label.font = .systemFont(ofSize: 13)
        label.text = "千山万水，无数黑夜，等一轮明月"
        return label
    }()
    lazy var desView: UIView = {
        let view = UIView()
        view.addSubview(desLabel)
        desLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21.auto())
            make.right.equalToSuperview().offset(-57.auto())
            make.centerY.equalToSuperview()
        }
        let right_icon = UIImageView(image: UIImage(named: "right_icon"))
//        view.addSubview(right_icon)
//        right_icon.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-34.auto())
//        }
        return view
    }()
    /// 脸猜
    lazy var fachai_result_view: DataResultView = {
        let view = DataResultView()
        view.titleLabel.text = "脸猜"
        view.success_numberView.valueLabel.text = "6次"
        view.success_rate_numberView.valueLabel.text = "69%"
//        view.ranking_numberView.valueLabel.text = "234"
        view.backgroundColor = UIColor(hex: "#3F6CCB")
        return view
    }()
    /// 连猜
    lazy var even_guess_view: DataResultView = {
        let view = DataResultView()
        view.titleLabel.text = "连猜"
        view.success_numberView.valueLabel.text = "6次"
        view.success_rate_numberView.valueLabel.text = "69%"
//        view.ranking_numberView.valueLabel.text = "234"
        view.backgroundColor = UIColor(hex: "#EC5399")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let des_arr = [
        "学贵信，信在诚。诚则信矣，信则诚矣。",
        "天见其明，地见其光，君子贵其全也。",
        "谬论从门缝钻进，真理立于门前。",
        "滚滚黄河，冲破冰山，切开雪野，艰难曲折而又一往无前地一泻千里",
        "识尽了喧嚣红尘，拥堵繁盛，那一片空山却以沈稳而清新的寂寥，让归隐者顿悟宇宙的深义",
        "夏天的晚风，轻轻吹动窗帘，暮色朦胧，打会瞌睡，差点决定这样过一生。",
        "想想光头强，想想灰太狼，你有什么理由不坚强。"
        ]
        let index = Int.random(in: 0..<des_arr.count)
        self.desLabel.text = des_arr[index]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let img = loadImageFromDocumentsDirectory(forKey: LocalStorage.getDeviceToken()) {
            self.headImageView.image = img
        }
        if let nickName = LocalStorage.getUserName() {
            self.nickName.text = nickName
        }
        
        var liancai_total_count = LocalStorage.getTotalLianCaiCount()
        var liancai_success_count = LocalStorage.getSuccessLianCaiCount()
        
        var total_count = LocalStorage.getTotalFachaiCount()
        var success_count = LocalStorage.getSuccessFachaiCount()
        
        
        fachai_result_view.success_numberView.valueLabel.text = "\(success_count)次"
        
        if success_count != 0,total_count != 0  {
            let accuracy = Double(success_count) / Double(total_count) * 100
            let formattedAccuracy = String(format: "%.2f", accuracy)
            fachai_result_view.success_rate_numberView.valueLabel.text = "\(formattedAccuracy)%"
        } else {
            fachai_result_view.success_rate_numberView.valueLabel.text = "0%"
        }
        
        
        even_guess_view.success_numberView.valueLabel.text = "\(liancai_success_count)次"
        
        if liancai_success_count != 0,liancai_total_count != 0
        {
            var even = Double(liancai_success_count) / Double(liancai_total_count)
            let formattedAccuracy = String(format: "%.2f", even)
            even_guess_view.success_rate_numberView.valueLabel.text = "\(formattedAccuracy)%"
        } else {
            even_guess_view.success_rate_numberView.valueLabel.text = "0%"
        }
        
        
//        MineViewModel.getSetPermiss { model in
//            if model.rank == 1 {
//                SKStoreReviewController.requestReview()
//            }
//        }
    }
    override func initWithUI() {
        super.initWithUI()
        self.view.addSubview(self.headView)
        headView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(navigationBarTotalHeight + 26.auto())
            make.left.right.equalToSuperview()
            make.height.equalTo(60.auto())
        }
        
        self.view.addSubview(self.desView)
        desView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(23.auto())
            make.height.equalTo(43.auto())
        }
        
        self.view.addSubview(self.fachai_result_view)
        self.view.addSubview(self.even_guess_view)
        fachai_result_view.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.top.equalTo(desView.snp.bottom).offset(22.auto())
            make.width.equalTo(168.auto())
            make.height.equalTo(160.auto())
        }
        fachai_result_view.roundCorners(radius: 10.auto())
        even_guess_view.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.auto())
            make.top.equalTo(desView.snp.bottom).offset(22.auto())
            make.width.equalTo(168.auto())
            make.height.equalTo(160.auto())
        }
        even_guess_view.roundCorners(radius: 10.auto())
        
        let btn_bg_view = UIView()
        btn_bg_view.backgroundColor = UIColor(hex: "#191919")
        self.view.addSubview(btn_bg_view)
        btn_bg_view.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.right.equalToSuperview().offset(-15.auto())
            make.height.equalTo(103.auto())
            make.top.equalTo(even_guess_view.snp.bottom).offset(22.auto())
        }
        btn_bg_view.roundCorners(radius: 10.auto())
        
        let dataSource = [
            ["title": "用户协议", "icon": "user"],
            ["title": "隐私协议", "icon": "privacy"],
            ["title": "应用评分", "icon": "collect"],
            ["title": "系统设置", "icon": "set"]
        ]
        let btnWidth = (screenWidth - 30.auto())/4
        for index in 0..<dataSource.count {
            let item = dataSource[index]
            let btn = UIButton()
            btn.tag = index
            btn.setTitle(item["title"]!, for: .normal)
            btn.setTitleColor(UIColor(hex: "#666666"), for: .normal)
            btn.setImage(UIImage(named: item["icon"]!), for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 12)
            btn_bg_view.addSubview(btn)
            btn.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat(index)*btnWidth)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(btnWidth)
            }
            btn.addTarget(self, action: #selector(btnClick(_ :)), for: .touchUpInside)
            btn.layoutIfNeeded()
            btn.adjustImagePosition(position: .top, space: 7.auto())
        }
        
        let label = UILabel()
        label.text = "官方客服"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn_bg_view.snp.bottom).offset(20.auto())
        }
        
        let contacts_btn = UIButton()
        contacts_btn.setTitle("010-05938843", for: .normal)
        contacts_btn.setTitleColor(UIColor(hex: "#3F6CCB"), for: .normal)
        contacts_btn.addTarget(self, action: #selector(contacts_btnClick), for: .touchUpInside)
        contacts_btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        self.view.addSubview(contacts_btn)
        contacts_btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(5.auto())
        }
    }
    
    @objc func btnClick(_ send: UIButton) {
        if send.tag == 0 {
            let vc = PolicyVC()
            vc.isPolicy = false
            self.navigationController?.pushViewController(vc, animated: true)
        } else if send.tag == 1 {
            let vc = PolicyVC()
            vc.isPolicy = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if send.tag == 2 {
            SKStoreReviewController.requestReview()
        } else if send.tag == 3 {
            self.navigationController?.pushViewController(SetUpVC(), animated: true)
        }
    }
    @objc func contacts_btnClick() {
        
    }
    @objc func headBtnClick() {
        self.navigationController?.pushViewController(PersonalInforVC(), animated: true)
    }
}
