//
//  TitleValueView.swift
//  FachaiAB
//
//  Created by   on 2023/11/21.
//

import UIKit

class TitleValueView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.8)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
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
        self.addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13.auto())
            make.top.bottom.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-13.auto())
            make.top.bottom.equalToSuperview()
        }
        
    }
}
