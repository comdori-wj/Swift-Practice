//
//  ViewController.swift
//  OAuthApp
//
//  Created by Wonji Ha on 1/22/24.
//

import UIKit
protocol LoginManagerDelegate: AnyObject { // 1. 저장할 정보를 담을 프로토콜을 만든다.
    func loadData(_ manager: LoginManager, name: String, imageURL: String)
}

class ViewController: UIViewController {
    
    let loginManager = LoginManager()
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    var dataImg : Data?
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoginManager.shared.delegate = self // 5. 델리게이트를 실행시켜준다.
    }
    
    @IBAction func loginBtnDidTap(_ sender: Any, forEvent event: UIEvent) {
        LoginManager.shared.requestCodeToGithub()
    }
}


extension ViewController:URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        DispatchQueue.main.async { [self] in
            image.image = UIImage(data: data)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        guard error != nil else {
//            print(error.localizedDescription)
//            return
//        }
        
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
    }
}

extension ViewController: LoginManagerDelegate { // 4. 넘겨받은 데이터를 어떻게 처리할지 구현해준다.
    func loadData(_ manager: LoginManager, name: String, imageURL: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
            guard let url = URL(string:imageURL) else { return }
            self.session.dataTask(with: url).resume()
        }
        
    }
}
