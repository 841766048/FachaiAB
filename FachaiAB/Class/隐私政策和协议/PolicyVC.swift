//
//  PolicyVC.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/20.
//

import UIKit

class PolicyVC: BaseViewController {
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 15)
        textView.textColor = .white
        textView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.isEditable = false // 禁止编辑
        return textView
    }()
    var isPolicy = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func initWithUI() {
        super.initWithUI()
        if isPolicy {
            self.title = "隐私政策"
            self.textView.text = "在此特别提醒您(用户) 在注册成为用户之前，请认真阅读本《用户协议》 (以下简称“协议”)，确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各项条款的约束。本协议约定  脸猜App (以下简称  脸猜App”) 与用户之间关于“  脸猜App软件服务(以下简称“服务“) 的权利义务“用户”是指注册、登录、使用本服务的个人。本协议可由  脸猜App随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本APP中查阅最新版协议条款。在修改协议条款后，如果用户不接受修改后的条款，请立即停止使用  脸猜App提供的服务，用户继续使用服务将被视为接受修改后的协议。\n 一、账号注册\n1、用户在使用本服务前需要注册一个“  脸猜App”账号。“  脸猜App”账号应当使用手机号码绑定注册，请用户使用尚未与“  脸猜App”账号绑定的手机号码，以及未被服务根据本协议封禁的手机号码注册“  脸猜App账号。服务可以根据用户需求或产品需要对账号注册和绑定的方式进行变更，而无须事先通知用户。\n2、“  脸猜App”系基于“  脸猜App“的APP产品，用户注册时应当授权  脸猜App及使用其个人信息方可成功注册“  脸猜App”账号。故用户完成注册即表明用户同意服务提取、公开及使用用户的信息。"
        } else {
            self.title = "用户协议"
            self.textView.text = "在您接受  脸猜App服务之前，请务必仔细阅读本条款并同意本协议。\n用户直接或通过各类方式(如站外引用等)间接使用  脸猜App服务和数据的行为，都将被视作已无条件接受本协议所涉全部内容；若用户对本协议的任何条款有异议，请停止使用  脸猜App所提供的全部服务。\n第一条\n用户以各种方式使用  脸猜App服务和数据(包括但不限于发表、宣传介绍、转载、浏览及利用  脸猜App内容或  脸猜App用户发布内容)的过程中，必须遵循以下原则：\n1.遵守中华人民共和国相关的法律和法规，包括但不仅限于《中华人民共和国著作权法》《全国人大常委会关于维护互联网安全的决定》。\n2.不得以任何方式利用  脸猜App直接或间接从事违反中国法律、以及社会公德的行为。\n3.不得干扰、损害和侵犯  脸猜App的各种合法权利与利益\n4.不得利用  脸猜App进行任何可能对互联网的正常运转造成不利影响的行为。\n5.不得违反  脸猜App以及与之相关的网络服务的协议、指导原则、管理细则等。\n对于违反上述原则的用户，  脸猜App有权采取一切必要手段制止该等违反要求的行为，包括但不限于对违规内容予以删除、对用户限制访问、取消注册等。"
        }
        
        
        
        self.view.addSubview(self.textView)
        textView.snp.makeConstraints { make in
            make.left.bottom.right.top.equalToSuperview()
        }
    }
}
