//
//  SetUpVC.swift
//  FachaiAB
//
//  Created by   on 2023/11/21.
//

import UIKit

class SetUpVC: BaseViewController {
    var cancellationCopy: String = "您确认要注销这个账号吗？"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "系统设置"
        // Do any additional setup after loading the view.
        MineViewModel.getCancellationCopy { model in
            if model.tip.count > 0 {
                self.cancellationCopy = model.tip
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func initWithUI() {
        super.initWithUI()
        let logOff_btn = UIButton()
        logOff_btn.backgroundColor = UIColor(hex: "#4272D7")
        logOff_btn.setTitle("注销", for: .normal)
        logOff_btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        logOff_btn.addTarget(self, action: #selector(logOff_btnClick), for: .touchUpInside)
        self.view.addSubview(logOff_btn)
        logOff_btn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36.auto())
            make.right.equalToSuperview().offset(-36.auto())
            make.top.equalToSuperview().offset(navigationBarTotalHeight + 148.auto())
            make.height.equalTo(44.auto())
        }
        logOff_btn.roundCorners(radius: 7.auto())
        
        
        let log_out_btn  = UIButton()
        log_out_btn.backgroundColor = UIColor(hex: "#4272D7")
        log_out_btn.setTitle("退出登录", for: .normal)
        log_out_btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        log_out_btn.addTarget(self, action: #selector(log_out_btnClick), for: .touchUpInside)
        self.view.addSubview(log_out_btn)
        log_out_btn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36.auto())
            make.right.equalToSuperview().offset(-36.auto())
            make.top.equalTo(logOff_btn.snp.bottom).offset(40.auto())
            make.height.equalTo(44.auto())
        }
        log_out_btn.roundCorners(radius: 7.auto())
    }
    
    @objc func logOff_btnClick() {
        print("注销")
        let alertController = UIAlertController(title: "", message: self.cancellationCopy, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "确认", style: .cancel) { _ in
            LoginViewModel.logoff()
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "取消", style: .default) { _ in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func log_out_btnClick() {
        print("退出登录")
        let alertController = UIAlertController(title: "", message: "您确认要退出登录吗？", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "确认", style: .cancel) { _ in
            LoginViewModel.logOutLogin()
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "取消", style: .default) { _ in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
