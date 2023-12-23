//
//  LoginVC.swift
//  FachaiAB
//
//  Created by   on 2023/11/20.
//

import UIKit
import CL_ShanYanSDK
import YYText

class LoginVC: BaseViewController, UITextFieldDelegate {
    var isShow = true
    var isSelect = false
    lazy var photoNumber: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = UIColor.white
        // 创建一个空的 UIView 来模拟内容边距
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40.auto(), height:46.auto()))
        
        let imageV = UIImageView()
        imageV.image = UIImage(named: "icon_header")
        imageV.frame = CGRect(x: 16.auto(), y: 14.auto(), width: 18.auto(), height: 18.auto())
        paddingView.addSubview(imageV)
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor(hex: "#191919")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 29.auto()
        textField.placeholder = "请输入手机号"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor(hex: "#A2A2A2")
        ]
        let attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.roundCorners(radius: 20.auto())
        return textField
    }()
    
    lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor(hex: "#191919")
        // 创建一个空的 UIView 来模拟内容边距
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40.auto(), height:46.auto()))
        
        let imageV = UIImageView()
        imageV.image = UIImage(named: "icon_suo")
        imageV.frame = CGRect(x: 16.auto(), y: 14.auto(), width: 18.auto(), height: 18.auto())
        paddingView.addSubview(imageV)
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor(hex: "#191919")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 29.auto()
        textField.placeholder = "输入验证码"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor(hex: "#A2A2A2")
        ]
        let attributedPlaceholder = NSAttributedString(string: "输入验证码", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.roundCorners(radius: 20.auto())
        return textField
    }()
    lazy var codeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("获取验证码", for: .normal)
        button.setTitleColor(UIColor(hex: "#4272D7"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 16.auto()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#4272D7").cgColor
        button.addTarget(self, action: #selector(getVerificationCode), for: .touchUpInside)
        return button
    }()
    lazy var codeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#191919")
        view.addSubview(self.codeTextField)
        
        view.addSubview(self.codeBtn)
        codeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.auto())
            make.centerY.equalToSuperview()
            make.width.equalTo(91.auto())
            make.height.equalTo(32.auto())
        }
        self.codeTextField.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.right.equalTo(codeBtn.snp.left)
        }
        view.roundCorners(radius: 20.auto())
        return view
    }()
    
    lazy var policyView: UIView = {
        let view = UIView()
        let select_btn = UIButton()
        select_btn.setImage(UIImage(named: "check-circle"), for: .normal)
        select_btn.setImage(UIImage(named: "select"), for: UIControl.State.selected)
        select_btn.addTarget(self, action: #selector(self.selectClick(_ :)), for: UIControl.Event.touchUpInside)
        view.addSubview(select_btn)
        select_btn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.height.equalTo(16.auto())
            make.centerY.equalToSuperview()
        }
        let content_text = YYLabel()
        content_text.textColor = UIColor(hex: "#9D9D9D")
        content_text.font = .systemFont(ofSize: 12)
        let textStr = "同意《用户协议》和《隐私政策》"
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
            CLShanYanSDKManager.finishAuthController(animated: true)
            let vc = PolicyVC()
            vc.isPolicy = false
            self.navigationController?.pushViewController(vc, animated: true)
            self.isShow = true
        }
        let highlight02 = YYTextHighlight()
        highlight02.tapAction = { _, _, _, _ in
            print("隐私政策")
            CLShanYanSDKManager.finishAuthController(animated: true)
            let vc = PolicyVC()
            vc.isPolicy = true
            self.navigationController?.pushViewController(vc, animated: true)
            self.isShow = true
        }
        attriStr.yy_setTextHighlight(highlight01, range: range01)
        attriStr.yy_setTextHighlight(highlight02, range: range02)
        content_text.numberOfLines = 0
        content_text.attributedText = attriStr
        view.addSubview(content_text)
        content_text.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(select_btn.snp.right).offset(6.auto())
            make.right.equalToSuperview()
        }
        return view
    }()
    lazy var login_btn: UIButton = {
        let login_btn = UIButton()
        login_btn.setTitle("登录", for: .normal)
        login_btn.setBackgroundImage(UIColor(hex: "#4272D7", alpha: 0.58).toImage(size: CGSize(width: 315.auto(), height: 54.auto())), for: .normal)
        login_btn.setBackgroundImage(UIColor(hex: "#4272D7", alpha: 1.0).toImage(size: CGSize(width: 315.auto(), height: 54.auto())), for: .selected)
        login_btn.addTarget(self, action: #selector(login_btnClick), for: UIControl.Event.touchUpInside)
        login_btn.isEnabled = false
        return login_btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        oneClickLogin()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isShow {
            oneClickLogin()
            isShow = false
        }
        // 显示导航
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func initWithUI() {
        super.initWithUI()
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = "手机号注册/登录"
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30.auto())
            make.top.equalToSuperview().offset(navigationBarTotalHeight + 33.auto())
        }
        self.view.addSubview(self.photoNumber)
        photoNumber.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30.auto())
            make.right.equalToSuperview().offset(-30.auto())
            make.top.equalTo(titleLabel.snp.bottom).offset(50.auto())
            make.height.equalTo(46.auto())
        }
        self.view.addSubview(self.codeView)
        self.codeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30.auto())
            make.right.equalToSuperview().offset(-30.auto())
            make.height.equalTo(46.auto())
            make.top.equalTo(self.photoNumber.snp.bottom).offset(16.auto())
        }
        
        self.view.addSubview(self.policyView)
        policyView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(38.auto())
            make.top.equalTo(self.codeView.snp.bottom).offset(36.auto())
            make.height.equalTo(18.auto())
        }
        
        self.view.addSubview(self.login_btn)
        login_btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(315.auto())
            make.height.equalTo(46.auto())
            make.top.equalTo(self.policyView.snp.bottom).offset(20.auto())
        }
        login_btn.roundCorners(radius: 23.auto())
        
        
        
    }
    @objc func getVerificationCode() {
        // TODO: 在这里实现获取验证码逻辑
        guard let phone = self.photoNumber.text else {
            toast("请填写手机号", state: .info)
            return
        }
        if phone.count == 0 {
            toast("请填写手机号", state: .info)
            return
        }
        startCountdown()
        requestVerificationCode()
    }
    // 一键登录
    func oneClickLogin() {
        let baseUIConfigure = CLUIConfigure()
        baseUIConfigure.viewController = self
        baseUIConfigure.clAppPrivacyColor = [UIColor(hex: "#4272D7"), UIColor(hex: "#4272D7")]
        baseUIConfigure.clBackgroundColor = .black
        baseUIConfigure.clNavigationBarStyle = NSNumber(integerLiteral: Int(UIBarStyle.black.rawValue))
        baseUIConfigure.clNavigationBackgroundClear = NSNumber(booleanLiteral: true)
        baseUIConfigure.clNavigationBottomLineHidden = NSNumber(booleanLiteral: true)
        baseUIConfigure.clNavigationBackBtnImage = UIImage(named: "back")!
        baseUIConfigure.clPhoneNumberColor = .white
        baseUIConfigure.clSloganTextHidden = NSNumber(booleanLiteral: true)
        baseUIConfigure.clAppPrivacyColor = [UIColor .black]
        
        baseUIConfigure.clLoginBtnText = "一键登录"
        baseUIConfigure.clLoginBtnTextFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        baseUIConfigure.clLoginBtnBgColor = UIColor(hex: "#4272D7")
        baseUIConfigure.clLoginBtnCornerRadius = NSNumber(floatLiteral: Double(14))
        baseUIConfigure.clLoginBtnTextColor = UIColor.white
        
        
        baseUIConfigure.clCheckBoxHidden = NSNumber(booleanLiteral: true)
        baseUIConfigure.clCheckBoxValue = NSNumber(booleanLiteral: true)
        baseUIConfigure.clCheckBoxImageEdgeInsets = NSValue(uiEdgeInsets: UIEdgeInsets(top: 8, left: 14, bottom: 6, right: 0))
        
        let clOrientationLayOutPortrait = CLOrientationLayOut()
        
        /// 窗口大小
        clOrientationLayOutPortrait.clAuthWindowOrientationOrigin = NSValue(cgPoint: CGPoint.zero)
        clOrientationLayOutPortrait.clAuthWindowOrientationWidth = NSNumber(floatLiteral: Double(UIScreen.main.bounds.width))
        clOrientationLayOutPortrait.clAuthWindowOrientationHeight = NSNumber(floatLiteral: Double(UIScreen.main.bounds.height))
        /// 手机号
        clOrientationLayOutPortrait.clLayoutPhoneCenterX = NSNumber(floatLiteral: 0)
        clOrientationLayOutPortrait.clLayoutPhoneHeight = NSNumber(floatLiteral: 33)
        clOrientationLayOutPortrait.clLayoutPhoneTop = NSNumber(floatLiteral: 194)
        
        // 一键登录按钮
        clOrientationLayOutPortrait.clLayoutLoginBtnTop = NSNumber(floatLiteral: 272)
        clOrientationLayOutPortrait.clLayoutLoginBtnLeft = NSNumber(floatLiteral: 28.auto())
        clOrientationLayOutPortrait.clLayoutLoginBtnRight = NSNumber(floatLiteral: -160.auto())
        
        clOrientationLayOutPortrait.clLayoutLoginBtnHeight = NSNumber(floatLiteral: 47)
        
        baseUIConfigure.clOrientationLayOutPortrait = clOrientationLayOutPortrait;
        //        baseUIConfigure.del
        CLShanYanSDKManager.setCLShanYanSDKManagerDelegate(self)
        baseUIConfigure.customAreaView =  { customAreaView in
            let code_btn = UIButton()
            code_btn.setTitle("验证码登录", for: .normal)
            code_btn.backgroundColor = UIColor(hex: "#191919")
            code_btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            code_btn.addTarget(self, action: #selector(self.code_btnClick), for: .touchUpInside)
            customAreaView.addSubview(code_btn)
            code_btn.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(272)
                make.left.equalToSuperview().offset(225.auto())
                make.right.equalToSuperview().offset(-28.auto())
                make.height.equalTo(47)
            }
            code_btn.layoutIfNeeded()
            code_btn.roundCorners(radius: 14)
            
            let view = UIView()
            let select_btn = UIButton()
            select_btn.setImage(UIImage(named: "check-circle"), for: .normal)
            select_btn.setImage(UIImage(named: "select"), for: UIControl.State.selected)
            select_btn.addTarget(self, action: #selector(self.selectClick(_ :)), for: UIControl.Event.touchUpInside)
            view.addSubview(select_btn)
            select_btn.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.width.height.equalTo(16.auto())
                make.centerY.equalToSuperview()
            }
            let content_text = YYLabel()
            content_text.textColor = UIColor(hex: "#9D9D9D")
            content_text.font = .systemFont(ofSize: 12)
            let textStr = "同意《用户协议》和《隐私政策》"
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
                CLShanYanSDKManager.finishAuthController(animated: true)
                let vc = PolicyVC()
                vc.isPolicy = false
                self.navigationController?.pushViewController(vc, animated: true)
                self.isShow = true
            }
            let highlight02 = YYTextHighlight()
            highlight02.tapAction = { _, _, _, _ in
                print("隐私政策")
                CLShanYanSDKManager.finishAuthController(animated: true)
                let vc = PolicyVC()
                vc.isPolicy = true
                self.navigationController?.pushViewController(vc, animated: true)
                self.isShow = true
            }
            attriStr.yy_setTextHighlight(highlight01, range: range01)
            attriStr.yy_setTextHighlight(highlight02, range: range02)
            content_text.numberOfLines = 0
            content_text.attributedText = attriStr
            view.addSubview(content_text)
            content_text.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(select_btn.snp.right).offset(6.auto())
                make.right.equalToSuperview()
            }
            customAreaView.addSubview(view)
            view.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(code_btn.snp.bottom).offset(23.auto())
                make.height.equalTo(17.auto())
            }
        }
        
        CLShanYanSDKManager.quickAuthLogin(with: baseUIConfigure) { result in
            if (result.error != nil) {
                print("授权页拉起失败")
            } else {
                print("授权页拉起成功")
                if let vc = NSObject.topViewController() {
                    for view in vc.view.subviews {
                        if let btn = view as? UIButton, btn.titleLabel?.text == "一键登录"  {
                            btn.removeTarget(nil, action: nil, for: .allEvents)
                            btn.addTarget(self, action: #selector(self.oneLoginClick), for: .touchUpInside)
                        }
                    }
                }
                
            }
        } oneKeyLoginListener: { result in
            if let error = result.error {
                if result.code == 1011 {
                    print("error = \(error)")
                } else {
                    CLShanYanSDKManager.finishAuthControllerCompletion()
                }
            } else {
                print("成功 = \(String(describing: result.data))")
                if let token = result.data?["token"] as? String {
                    LoginViewModel.oneClickLogin(token) { model in
                        LocalStorage.savePhoneNumber(LocalStorage.phoneNumber)
                        LocalStorage.saveDefaultTab(model.tab)
                        LocalStorage.saveKefu(model.kefu)
                        LocalStorage.saveIsLogin(true)
                        LocalStorage.saveUserKey(model.key)
                        MineViewModel.getSetPermiss { model in
                            LocalStorage.saveFull(model.full)
                            LocalStorage.saveDefaultTab(Int(model.tab) ?? 0)
                        }
                        TabBarController.instance.tab = BaseTabBarController()
                        let notification = Notification(name: .switchRootViewController)
                        NotificationCenter.default.post(notification)
//                        self.navigationController?.popViewController(animated: true)
//                        let notification = Notification(name: .switchRootViewController)
//                        NotificationCenter.default.post(notification)
                        
                    }
                }
            }
        }
        
    }
    
    func startCountdown() {
        // 在这里实现倒计时逻辑
        // 可以使用 Timer 进行倒计时，具体实现可根据需求进行
        // 示例：每秒减少按钮标题上的倒计时数字
        var seconds = 60
        self.codeBtn.isEnabled = false
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if seconds == 0 {
                timer.invalidate()
                self.codeBtn.isEnabled = true
                self.codeBtn.setTitle("获取验证码", for: .normal)
            } else {
                seconds -= 1
                self.codeBtn.setTitle("(\(seconds)s)", for: .disabled)
            }
        }
        timer.fire()
    }
    
    func requestVerificationCode() {
        LoginViewModel.sendVerificationCode(self.photoNumber.text!)
    }

    @objc func login_btnClick() {
        if self.isSelect {
            guard let phone = self.photoNumber.text else {
                toast("请填写手机号", state: .info)
                return
            }
            if phone.count == 0 {
                toast("请填写手机号", state: .info)
                return
            }
            guard let code = codeTextField.text else {
                toast("请填写验证码", state: .info)
                return
            }
            if code.count == 0 {
                toast("请填写验证码", state: .info)
                return
            }
            LoginViewModel.codeLogin(phone, code: code) { model in
                if phone.count == 11 {
                    let str = self.hidePhoneNumber(phone)
                    LocalStorage.savePhoneNumber(str)
                }
                LocalStorage.saveDefaultTab(model.tab)
                LocalStorage.saveKefu(model.kefu)
                LocalStorage.saveIsLogin(true)
                LocalStorage.saveUserKey(model.key)
                MineViewModel.getSetPermiss { model in
                    LocalStorage.saveFull(model.full)
                    LocalStorage.saveDefaultTab(Int(model.tab) ?? 0)
                }
                TabBarController.instance.tab = BaseTabBarController()
                let notification = Notification(name: .switchRootViewController)
                NotificationCenter.default.post(notification)
//                self.navigationController?.popViewController(animated: true)
//                let notification = Notification(name: .switchRootViewController)
//                NotificationCenter.default.post(notification)
            }
        } else {
            toast("请同意“用户协议”和“隐私政策”", state: .info)
        }
        
    }
    func hidePhoneNumber(_ phoneNumber: String) -> String {
        guard phoneNumber.count >= 7 else {
            return phoneNumber
        }

        let prefix = String(phoneNumber.prefix(3)) // 保留前三位数字
        let suffix = String(phoneNumber.suffix(4)) // 保留后四位数字
        let hidden = String(repeating: "*", count: phoneNumber.count - 7) // 将中间部分替换为 "*"

        let hiddenPhoneNumber = prefix + hidden + suffix
        return hiddenPhoneNumber
    }
    @objc func selectClick(_ send: UIButton) {
        send.isSelected = !send.isSelected
        self.isSelect = send.isSelected
        
    }
    
    @objc func oneLoginClick() {
        print("一键登录")
        if self.isSelect {
            CLShanYanSDKManager.loginBtnClick()
        } else {
            toast("请同意“用户协议”和“隐私政策”", state: .info)
        }
        
    }
    
    @objc func code_btnClick() {
        print("验证码登录")
        CLShanYanSDKManager.finishAuthControllerCompletion()
    }
}

extension LoginVC: CLShanYanSDKManagerDelegate {
    func clShanYanActionListener(_ type: Int, code: Int, message: String?) {
        if type == 3 {
            return
        }
    }
}

extension LoginVC {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard let code = self.codeTextField.text else { return  }
        guard let phone = self.photoNumber.text else { return }
        if code.count > 0 && phone.count > 0 {
            self.login_btn.isEnabled = true
            self.login_btn.isSelected =  true
        } else {
            self.login_btn.isEnabled = false
            self.login_btn.isSelected =  false
        }
    }
}
