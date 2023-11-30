//
//  ViewController.swift
//  CollectionView
//
//  Created by Wonji Ha on 11/30/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = collectionView.collectionViewLayout as! MyCollectionViewLayout
        layout.delegate = self
    }
    
    
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50 // 커스텀 뷰 셀 갯수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath)
        
        return cell
    }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    // MARK: - 같은 크기로 셀크기 주기.
//    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    //        return CGSize(width: 70, height: 70)
//    //    }
//    
//    
//    // MARK: - 랜덤한 크기로 셀크기 주기
//    //        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    //            return CGSize(width: Int.random(in: 10...50), height: Int.random(in: 10...50))
//    //        }
//    
//    // MARK: - 셀크기 조건 주기
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.item % 4 == 0 { // 테일뷰 셀은 row를 사용했는데 컬렉션뷰 셀은 item 을 사용한다.
//            return CGSize(width: 100, height: 100)
//        } else {
//            return CGSize(width: Int.random(in: 10...50), height: Int.random(in: 10...50))
//        }
//    }
//}

protocol MyCollectionViewLayoutDelegate {
    func cellHeight() -> Double
}

class MyCollectionViewLayout: UICollectionViewLayout {
    var cache: [UICollectionViewLayoutAttributes] = []
    var totalHeight: Double = 0
    var delegate: MyCollectionViewLayoutDelegate?
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 3000, height: totalHeight)
        
    }
    override func prepare() {
        let numberOfItems = collectionView!.numberOfItems(inSection: 0)
        var yOffset: Int = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attr.frame = CGRect(x: 0, y: yOffset, width: 50, height: Int(delegate!.cellHeight()))
            cache.append(attr)
            yOffset += Int(delegate!.cellHeight()) + 10
            totalHeight += 60
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? { // rect는 보여지는 화면보다 더 큰 사이즈
        
        let attrs = cache.filter { attr in
            rect.intersects(attr.frame) // 겹치는것
        }
        return attrs
    }
}

extension ViewController: MyCollectionViewLayoutDelegate {
    func cellHeight() -> Double {
        return 200
    }

}
