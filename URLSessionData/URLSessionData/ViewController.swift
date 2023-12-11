//
//  ViewController.swift
//  URLSessionData
//
//  Created by Wonji Ha on 2023/11/22.
//

import UIKit

class ImageCache {
    private init() {}
}

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btn: UIButton!
    
    var dataImage : Data?
    let cachedImages = NSCache<NSURL, UIImage>()
    
    //    private lazy var session: URLSession = {
    //        let configuration = URLSessionConfiguration.default
    //        configuration.waitsForConnectivity = true
    //        return URLSession(configuration: configuration,
    //                          delegate: self, delegateQueue: nil)
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnTapped(_ sender: Any) {
        //        dataImage = Data()
        guard let url = URL(string: "https://wallpaperaccess.com/download/europe-4k-1318341") else {return}
        if cachedImages.object(forKey: NSURL(string: url.formatted())!) == nil {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                
                DispatchQueue.main.async { [weak self] in
                    let uiImage = UIImage(data: data)!
                    self?.image.image = uiImage
                    self?.cachedImages.setObject(uiImage, forKey: NSURL(string: url.formatted())!)
                    print("캐시 저장")
                    return
                }
            }.resume()
            //            session.dataTask(with: url).resume()
        } else {
            DispatchQueue.main.async {
                self.image.image = self.cachedImages.object(forKey: NSURL(string: url.formatted())!)!
                print("노 다운")
            }
        }
    }
}

extension ViewController:URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.dataImage?.append(data)
        DispatchQueue.main.async { [self] in
            guard let data = dataImage else { return }
            image.image = UIImage(data: data)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        guard error != nil else {
            print(error?.localizedDescription ?? "error")
            return
        }
    }
}
