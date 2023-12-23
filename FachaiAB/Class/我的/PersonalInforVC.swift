//
//  PersonalInforVC.swift
//  FachaiAB
//
//  Created by   on 2023/11/21.
//

import UIKit

class PersonalInforVC: BaseViewController {
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "my_top_touxiang")
        return imageView
    }()
    
    lazy var headView: UIView = {
        let headView = UIView()
        headView.backgroundColor = .clear
        let headTitleView = UILabel()
        headTitleView.text = "头像"
        headTitleView.font = .systemFont(ofSize: 15)
        headTitleView.textColor = .white
        headView.addSubview(headTitleView)
        headTitleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.centerY.equalToSuperview()
        }
        
        headView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-27.auto())
            make.width.height.equalTo(30.auto())
        }
        headImageView.roundCorners(radius: 15.auto())
        
        
        let right_icon = UIImageView(image: UIImage(named: "right_icon"))
        headView.addSubview(right_icon)
        right_icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14.auto())
        }
        
        let headBtn = UIButton()
        headBtn.backgroundColor = .clear
        headBtn.addTarget(self, action: #selector(headBtnClick), for: .touchUpInside)
        headView.addSubview(headBtn)
        headBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return headView
    }()
    lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "独角兽"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    lazy var nickNameView: UIView = {
        let view = UIView()
        let headTitleView = UILabel()
        headTitleView.text = "昵称"
        headTitleView.font = .systemFont(ofSize: 15)
        headTitleView.textColor = .white
        view.addSubview(headTitleView)
        headTitleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.auto())
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-27.auto())
            make.centerY.equalToSuperview()
        }
        
        let right_icon = UIImageView(image: UIImage(named: "right_icon"))
        view.addSubview(right_icon)
        right_icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14.auto())
        }
        
        let headBtn = UIButton()
        headBtn.backgroundColor = .clear
        headBtn.addTarget(self, action: #selector(nickNameClick), for: .touchUpInside)
        view.addSubview(headBtn)
        headBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人设置"
        // Do any additional setup after loading the view.
    }
    override func initWithUI() {
        super.initWithUI()
        self.view.backgroundColor = .black
        self.view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.height.equalTo(40.auto())
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(navigationBarTotalHeight+10.auto())
        }
        
        self.view.addSubview(nickNameView)
        nickNameView.snp.makeConstraints { make in
            make.height.equalTo(40.auto())
            make.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(10.auto())
        }
        if let img = loadImageFromDocumentsDirectory(forKey: LocalStorage.getDeviceToken()) {
            self.headImageView.image = img
        }
        if let nickName = LocalStorage.getUserName() {
            self.nickNameLabel.text = nickName
        }
    }
    
    @objc func headBtnClick() {
        CameraUtil.capturePhoto { image in
            if let img = image {
                self.headImageView.image = img
                _ = saveImageToDocumentsDirectory(image: img, forKey: LocalStorage.getDeviceToken())
            }
        }
    }
    @objc func nickNameClick() {
        let alertController = UIAlertController(title: "修改昵称", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入昵称"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            print("Cancelled")
        }
        
        let addAction = UIAlertAction(title: "保存", style: .default) { (_) in
            if let textField = alertController.textFields?.first, let enteredText = textField.text {
                // Do something with enteredText
                print("Entered text: \(enteredText)")
                LocalStorage.saveUserName(enteredText)
                self.nickNameLabel.text = enteredText
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

typealias CaptureCompletionBlock = (UIImage?) -> Void

class CameraUtil: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private var captureCompletionBlock: CaptureCompletionBlock?
    private static let sharedInstance = CameraUtil()
    
    class func capturePhoto(completion: @escaping CaptureCompletionBlock) {
        sharedInstance.captureCompletionBlock = completion
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = sharedInstance
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private override init() {
        super.init()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            captureCompletionBlock?(capturedImage)
        } else {
            captureCompletionBlock?(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
func saveImageToDocumentsDirectory(image: UIImage, forKey key: String) -> URL? {
    // 获取 Documents 目录路径
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    if let documentsDirectory = documentsDirectory {
        // 创建保存图片的 URL
        let fileURL = documentsDirectory.appendingPathComponent("\(key).jpg")
        
        do {
            // 将图片转换为 Data
            if let data = image.jpegData(compressionQuality: 1.0) {
                // 将图片 Data 保存到指定路径
                try data.write(to: fileURL)
                return fileURL // 返回保存图片的 URL
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    return nil
}

func loadImageFromDocumentsDirectory(forKey key: String) -> UIImage? {
    // 获取 Documents 目录路径
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    if let documentsDirectory = documentsDirectory {
        // 创建指定图片路径
        let fileURL = documentsDirectory.appendingPathComponent("\(key).jpg")
        
        do {
            // 从路径加载图片 Data
            let imageData = try Data(contentsOf: fileURL)
            // 将 Data 转换为 UIImage
            let image = UIImage(data: imageData)
            return image // 返回获取到的图片
        } catch {
            print(error.localizedDescription)
        }
    }
    
    return nil
}

//// 保存图片到沙盒路径下
//if let image = UIImage(named: "yourImage") {
//    if let imageURL = saveImageToDocumentsDirectory(image: image, forKey: "yourKey") {
//        print("Image saved at: \(imageURL)")
//    }
//}
//
//// 从沙盒路径下获取图片
//if let loadedImage = loadImageFromDocumentsDirectory(forKey: "yourKey") {
//    print("Loaded Image: \(loadedImage)")
//}
