//
//  ViewControllerTableViewController.swift
//  TableView2
//
//  Created by Wonji Ha on 2023/11/22.
//

import UIKit

class TableViewController: UITableViewController {
    private let semaphore = DispatchSemaphore(value: 1)
    private var count = 0
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()
    
    private var images = [UIImage?]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url1 = URL(string: "https://wallpaperaccess.com/download/europe-4k-1369012")!
        let url2 = URL(string: "https://wallpaperaccess.com/download/europe-4k-1318341")!
        let url3 = URL(string: "https://wallpaperaccess.com/download/europe-4k-1379801")!
        session.dataTask(with: url1).resume()
        session.dataTask(with: url2).resume()
        session.dataTask(with: url3).resume()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 9
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section + 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = "\(indexPath.section), \(indexPath.row)"
            if indexPath.row == 2 {
                cell.backgroundColor = .red
            }
            return cell
        }
        cell.backgroundColor = indexPath.row == 2 ? .red : .systemBackground
        cell.textLabel?.text = "\(indexPath.section), \(indexPath.row)"
        cell.imageView?.image = nil
        
        if (0..<images.count).contains(indexPath.row - 1) {
            cell.imageView?.image = images[indexPath.row - 1]
            
        }
        
        return cell
    }
    
}

extension TableViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            completionHandler(.cancel)
            return
        }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if data.count == 0 {
            return
        }
        let image = UIImage(data: data)
        images.append(image)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        semaphore.wait()
        DispatchQueue.main.async {
            if let error = error {
                fatalError(error.localizedDescription)
            }
            self.count += 1
            print(self.count)
            if self.count == 3 {
                self.tableView.reloadData()
            }
            self.semaphore.signal()
        }
    }
}
