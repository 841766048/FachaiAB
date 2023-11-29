//
//  LenchaiVC.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit

class LenchaiVC: BaseViewController {
    lazy var simple_btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("简单模式", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: "#4272D7", alpha: 1.0)
        btn.setBackgroundImage(UIColor(hex: "#4272D7", alpha: 1.0).toImage(size: CGSize(width: 112.auto(), height: 34.auto())), for: .selected)
        btn.setBackgroundImage(UIColor(hex: "#191919", alpha: 1.0).toImage(size: CGSize(width: 112.auto(), height: 34.auto())), for: .normal)
        btn.addTarget(self, action: #selector(selectTypeClick), for: .touchUpInside)
        btn.roundCorners(radius: 10.auto())
        return btn
    }()
    lazy var difficulty_btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("困难模式", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: "#4272D7", alpha: 1.0)
        btn.setBackgroundImage(UIColor(hex: "#4272D7", alpha: 1.0).toImage(size: CGSize(width: 112.auto(), height: 34.auto())), for: .selected)
        btn.setBackgroundImage(UIColor(hex: "#191919", alpha: 1.0).toImage(size: CGSize(width: 112.auto(), height: 34.auto())), for: .normal)
        btn.addTarget(self, action: #selector(selectTypeClick), for: .touchUpInside)
        btn.roundCorners(radius: 10.auto())
        return btn
    }()
    var select_btn: UIButton?
    lazy var blue_numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.auto(), weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#4272D7")
        return label
    }()
    lazy var red_numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.auto(), weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#EC5399")
        return label
    }()
    lazy var blue_btn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "blue"), for: .normal)
        btn.addTarget(self, action: #selector(blueClick), for: .touchUpInside)
        btn.isHidden = true
        btn.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        return btn
    }()
    lazy var red_btn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "red"), for: .normal)
        btn.addTarget(self, action: #selector(redClick), for: .touchUpInside)
        btn.isHidden = true
        btn.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        return btn
    }()
    let bgView = UIView()
    var blue_number: Int = 0
    var red_number: Int = 0
    
    var currentButton: UIButton?
    var timer: Timer?
    var isPaused: Bool = false
    var duration = 0.8
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func initWithUI() {
        super.initWithUI()
        self.view.addSubview(simple_btn)
        simple_btn.snp.makeConstraints { make in
            make.right.equalTo(self.view.snp.centerX).offset(-7.5.auto())
            make.top.equalToSuperview().offset(statusBarHeight+27.auto())
            make.width.equalTo(112.auto())
            make.height.equalTo(34.auto())
        }
        self.view.addSubview(difficulty_btn)
        difficulty_btn.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.centerX).offset(7.5.auto())
            make.top.equalToSuperview().offset(statusBarHeight+27.auto())
            make.width.equalTo(112.auto())
            make.height.equalTo(34.auto())
        }
        
        self.view.addSubview(self.blue_numberLabel)
        self.view.addSubview(self.red_numberLabel)
        blue_numberLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-95.auto()-bottomSafeAreaHeight-58)
            make.height.equalTo(33.auto())
        }
        red_numberLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-95.auto()-58-bottomSafeAreaHeight)
            make.height.equalTo(33.auto())
        }
        
        let des_label = UILabel()
        des_label.text = "连续点中5个相同颜色的脸谱，遇见TA"
        des_label.textColor = .white
        des_label.textAlignment = .center
        des_label.font = .systemFont(ofSize: 13, weight: .medium)
        self.view.addSubview(des_label)
        des_label.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-43.auto()-58-bottomSafeAreaHeight)
        }
        
        
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(blue_numberLabel.snp.top)
            make.top.equalTo(simple_btn.snp.bottom)
        }
        bgView.layoutIfNeeded()
        bgView.addSubview(blue_btn)
        bgView.addSubview(red_btn)
        // 添加手势识别器
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        bgView.addGestureRecognizer(tapGesture)
        selectTypeClick(self.simple_btn)
    }
    
    @objc func selectTypeClick(_ send: UIButton) {
        if select_btn != send {
            select_btn?.isSelected = false
            send.isSelected = true
            select_btn = send
            if select_btn == simple_btn {
                duration = 0.8
                stopButtonDisplay()
                startButtonDisplay()
            } else {
                duration = 0.5
                stopButtonDisplay()
                startButtonDisplay()
            }
        }
    }
    
    @objc func blueClick() {
        if !LocalStorage.getIsLogin() {
            topViewController()?.navigationController?.pushViewController(LoginVC(), animated: true)
            return
        }
        var total_count = LocalStorage.getTotalLianCaiCount()
        var success_count = LocalStorage.getSuccessLianCaiCount()
        total_count += 1
        LocalStorage.saveTotalLianCaiCount(number: total_count)
        
        
        let full = LocalStorage.getFull()
        if full.count > 0 {
            let alertController = UIAlertController(title: "", message: full, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "好的", style: .cancel) { _ in
                
            }
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        
        blue_number += 1
        red_number = 0
        
        blue_numberLabel.isHidden = false
        red_numberLabel.isHidden = true
        blue_numberLabel.text = "蓝色+\(blue_number)"
        // 延迟隐藏按钮
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.blue_numberLabel.isHidden = true
        }
        if blue_number == 5 {
            success_count += 1
            LocalStorage.saveSuccessLianCaiCount(number: success_count)
            LenchaiViewModel.getLianCaiData { model in
                let vc = UnlockLenchaiVC()
                vc.dataModel = model
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @objc func redClick() {
        if !LocalStorage.getIsLogin() {
            topViewController()?.navigationController?.pushViewController(LoginVC(), animated: true)
            return
        }
        
        var total_count = LocalStorage.getTotalLianCaiCount()
        var success_count = LocalStorage.getSuccessLianCaiCount()
        total_count += 1
        LocalStorage.saveTotalLianCaiCount(number: total_count)
        
        
        
        
        let full = LocalStorage.getFull()
        if full.count > 0 {
            let alertController = UIAlertController(title: "", message: full, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "好的", style: .cancel) { _ in
                
            }
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        blue_number = 0
        red_number += 1
        
        blue_numberLabel.isHidden = true
        red_numberLabel.isHidden = false
        red_numberLabel.text = "红色+\(red_number)"
        // 延迟隐藏按钮
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.red_numberLabel.isHidden = true
        }
        if red_number == 5 {
            success_count += 1
            LocalStorage.saveSuccessLianCaiCount(number: success_count)
            
            LenchaiViewModel.getLianCaiData { model in
                let vc = UnlockLenchaiVC()
                vc.dataModel = model
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // 每隔一段时间展示一个按钮（0.8秒或者0.5秒）
    func startButtonDisplay() {
        // 每隔一段时间展示一个按钮（0.8秒或者0.5秒）
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(showRandomButton), userInfo: nil, repeats: true)
    }
    @objc func showRandomButton() {
        self.blue_btn.isHidden = true
        self.red_btn.isHidden = true
        guard !isPaused else { return } // 如果暂停状态，不展示按钮
        
        // 随机选择一个按钮展示
        let buttons = [self.blue_btn, self.red_btn]
        let randomIndex = Int(arc4random_uniform(UInt32(buttons.count)))
        let randomButton = buttons[randomIndex]
        
        // 随机设置按钮的位置
        let randomX = CGFloat(arc4random_uniform(UInt32(bgView.frame.width - randomButton.frame.width)))
        let randomY = CGFloat(arc4random_uniform(UInt32(bgView.frame.height - randomButton.frame.height)))
        randomButton.frame.origin = CGPoint(x: randomX, y: randomY)
        
        // 显示按钮
        randomButton.isHidden = false
        
//        // 延迟隐藏按钮
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//            randomButton.isHidden = true
//        }
    }
    func stopButtonDisplay() {
        timer?.invalidate()
        blue_btn.isHidden = true
        red_btn.isHidden = true
        isPaused = false
    }
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.bgView)
        
        // 检查触摸点是否在按钮1和按钮2的区域以外
        if !red_btn.frame.contains(location) && !blue_btn.frame.contains(location) {
            // 执行视图的点击事件
            print("View was tapped")
            blue_number = 0
            red_number = 0
            // 在这里执行你想要的操作
        }
    }
}
