//
//  DataResultView.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit

class DataResultView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    lazy var success_numberView: TitleValueView = {
        let view = TitleValueView()
        view.titleLabel.text = "成功次数"
        return view
    }()
    lazy var success_rate_numberView: TitleValueView = {
        let view = TitleValueView()
        view.titleLabel.text = "成功率"
        return view
    }()
    lazy var ranking_numberView: TitleValueView = {
        let view = TitleValueView()
        view.titleLabel.text = "目前排名"
        return view
    }()
    init() {
        super.init(frame: .zero)
        initWithUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWithUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(15.auto())
        }
        self.addSubview(self.success_numberView)
        self.addSubview(self.success_rate_numberView)
        self.addSubview(self.ranking_numberView)
        
        success_numberView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(13.auto())
            make.height.equalTo(20.auto())
        }
        
        success_rate_numberView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(success_numberView.snp.bottom).offset(15.auto())
            make.height.equalTo(20.auto())
        }
        
        ranking_numberView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(success_rate_numberView.snp.bottom).offset(15.auto())
            make.height.equalTo(20.auto())
        }
        
        
    }
}
