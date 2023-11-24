//
//  FachaiVC.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit
import SDWebImage

class FachaiVC: BaseViewController {
    lazy var showImageView: GuessImageView = {
        let imageView = GuessImageView()
        imageView.tag = 0
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    /// 第一张模糊照片
    lazy var oneImageView: GuessImageView = {
        let imageView = GuessImageView()
        imageView.tag = 1
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    /// 第二张模糊照片
    lazy var twoImageView: GuessImageView = {
        let imageView = GuessImageView()
        imageView.tag = 2
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    /// 第三张模糊照片
    lazy var threeImageView: GuessImageView = {
        let imageView = GuessImageView()
        imageView.tag = 3
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    lazy var images: [GuessImageView] = {
        let ims = [self.showImageView, self.oneImageView, self.twoImageView, self.threeImageView]
        return ims
    }()
    let image_urls: [String] = [
        "https://img.keaitupian.cn/newupload/11/1700039147326498.jpg",
        "https://img.keaitupian.cn/newupload/11/1700039147188099.jpg",
        "https://img.keaitupian.cn/newupload/11/1700039152467686.jpg",
        "https://img.keaitupian.cn/newupload/11/1700039153858200.jpg"
    ]
    let bgView = UIView()
    lazy var locateInfoView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor(hex: "#191919")
        let label = UILabel()
        label.text = "开启定位权限，享受周边服务"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        topView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.centerY.equalToSuperview()
        }
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#4272D7")
        button.setTitle("去开启", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(openClick), for: .touchUpInside)
        topView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.auto())
            make.centerY.equalToSuperview()
            make.width.equalTo(68.auto())
            make.height.equalTo(28.auto())
        }
        button.roundCorners(radius: 12.auto())
        return topView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initWithShowImageView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        LocationManager.shared.fetchUserLocation { location in
            if let loc = location {
                print("Latitude: \(loc.coordinate.latitude), Longitude: \(loc.coordinate.longitude)")
            } else {
                self.locateInfoView.isHidden = LocationManager.shared.isLocationPermissionGranted
            }
            // 在这里处理获取到的位置信息
            
        }
    }
    override func initWithUI() {
        super.initWithUI()
        
        self.view.addSubview(self.locateInfoView)
        self.locateInfoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(statusBarHeight+33.auto())
            make.height.equalTo(43.auto())
        }
        self.locateInfoView.isHidden = true
        
        
        self.view.addSubview(bgView)
        let imageWidth = screenWidth/2
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(2*imageWidth)
            make.centerY.equalToSuperview()
        }
        
        let label = UILabel()
        label.text = "点击你认为图片应该所在的位置 \n正确即可解"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(29.auto())
        }
    }
    
    @objc func imageClick(_ send: UIButton) {
        print("send.tag = \(send.tag )")
        let full = LocalStorage.getFull()
        if full.count > 0 {
            let alertController = UIAlertController(title: "", message: full, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "好的", style: .cancel) { _ in
                
            }
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if send.tag != 0 {
            var dataModel: ShowImageModel?
            if send.tag == 1 {
                dataModel = self.oneImageView.dataModel
            } else if send.tag == 2 {
                dataModel = self.twoImageView.dataModel
            } else if send.tag == 3 {
                dataModel = self.threeImageView.dataModel
            }
            if let model = dataModel, model.isShow {
               print("点击正确")
                self.navigationController?.pushViewController(FachaiDetailsVC(), animated: true)
            }
            updateShowImageView()
        }
    }
    func initWithShowImageView() {
        let imageWidth = screenWidth/2
        let arr: [ShowImageModel] = [
            ShowImageModel(url: "https://img.keaitupian.cn/newupload/11/1700039147188099.jpg", isShow: false),
            ShowImageModel(url: "https://img.keaitupian.cn/newupload/11/1700039152467686.jpg", isShow: false),
            ShowImageModel(url: "https://img.keaitupian.cn/newupload/11/1700039147326498.jpg", isShow: true),
        ]
        let data_arr = arr.shuffled()
        self.oneImageView.dataModel = data_arr[0]
        self.twoImageView.dataModel = data_arr[1]
        self.threeImageView.dataModel = data_arr[2]
        let dataSource = self.images.shuffled()
        let contentMode: [UIView.ContentMode] = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        for index in dataSource.indices {
            let image = dataSource[index]
            image.contentMode = contentMode[index]
            bgView.addSubview(image)
            image.snp.remakeConstraints { make in
                if index == 0 {
                    make.left.top.equalToSuperview()
                } else if index == 1 {
                    make.right.top.equalToSuperview()
                } else if index == 2 {
                    make.left.bottom.equalToSuperview()
                } else if index == 3 {
                    make.right.bottom.equalToSuperview()
                }
                make.height.width.equalTo(imageWidth)
            }
            image.layoutIfNeeded()
            if image.tag != 0 {
                // 创建模糊效果
                let blurEffect = UIBlurEffect(style: .light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = image.bounds
                // 将模糊效果视图添加到 UIImageView 上
                image.addSubview(blurEffectView)
                
                let btn = UIButton()
                btn.tag =  image.tag
                btn.backgroundColor = .clear
                btn.addTarget(self, action: #selector(imageClick(_ :)), for: .touchUpInside)
                image.addSubview(btn)
                btn.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
            image.layer.masksToBounds = true
        }
        configurationData()
    }
    func updateShowImageView() {
        let imageWidth = screenWidth/2
        let dataSource = self.images.shuffled()
        for index in dataSource.indices {
            let image = dataSource[index]
            image.snp.remakeConstraints { make in
                if index == 0 {
                    make.left.top.equalToSuperview()
                } else if index == 1 {
                    make.right.top.equalToSuperview()
                } else if index == 2 {
                    make.left.bottom.equalToSuperview()
                } else if index == 3 {
                    make.right.bottom.equalToSuperview()
                }
                make.height.width.equalTo(imageWidth)
            }
        }
        configurationData()
    }
    
    func configurationData() {
        let arr: [ShowImageModel] = [
            ShowImageModel(url: "https://img.keaitupian.cn/newupload/11/1700039147188099.jpg", isShow: false),
            ShowImageModel(url: "https://img.keaitupian.cn/newupload/11/1700039152467686.jpg", isShow: false),
            ShowImageModel(url: "https://img.keaitupian.cn/newupload/11/1700039147326498.jpg", isShow: true),
        ]
        self.showImageView.dataModel = ShowImageModel(url: "https://img.keaitupian.cn/newupload/11/1700039147326498.jpg", isShow: true)
        let data_arr = arr.shuffled()
        self.oneImageView.dataModel = data_arr[0]
        self.twoImageView.dataModel = data_arr[1]
        self.threeImageView.dataModel = data_arr[2]
    }
    
    @objc func openClick() {
        LocationManager.shared.openAppSettings()
    }
    
}

class ShowImageModel: NSObject {
    var url: String = ""
    /// 是否是展示的图片View
    var isShow: Bool = false
    init(url: String, isShow: Bool) {
        self.url = url
        self.isShow = isShow
    }
}

class GuessImageView: UIImageView {
    var dataModel: ShowImageModel? {
        didSet {
            if let model = dataModel {
                self.sd_setImage(with: URL(string: model.url))
            }
        }
    }
}
