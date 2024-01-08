//
//  ConcurrencySample - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private var imageViews: [UIImageView]!
    @IBOutlet private var progressViews: [UIProgressView]!
}

extension ViewController {
    @IBAction func touchUpLoadImageButton(_ sender: UIButton) {
        let index = sender.tag
        
        resetImageView(at: index)
        /// MARK : - 기존의 GCD 방식
//        fetchThumbnail(for: index) { image, error in
//            if let error {
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self.imageViews[index].image = image
//            }
//        }
        Task {
            let image = await withCheckedContinuation({ continuation in
                return fetchThumbnail(for: index) { image, error in
                    continuation.resume(with: .success(image))
                }
            })
            imageViews[index].image = image
            print(index)
        }
    }
    
    @IBAction func touchUpLoadAllImagesButton(_ sender: UIButton) {
        
        Task {
//            for index in 0...4 {
//                async let thumb0 = fetchThumbnail(for: index)
//                async let thumb1 = fetchThumbnail(for: index)
//                async let thumb2 = fetchThumbnail(for: index)
//                async let thumb3 = fetchThumbnail(for: index)
//                async let thumb4 = fetchThumbnail(for: index)
//                let thumbs = try await [thumb0, thumb1, thumb2, thumb3, thumb4]
//
//                imageViews[index].image = thumbs[index]
//            }
            
                async let thumb0 = fetchThumbnail(for: 0)
                async let thumb1 = fetchThumbnail(for: 1)
                async let thumb2 = fetchThumbnail(for: 2)
                async let thumb3 = fetchThumbnail(for: 3)
                async let thumb4 = fetchThumbnail(for: 4)
                let thumbs = try await [thumb0, thumb1, thumb2, thumb3, thumb4]
            for index in 0..<thumbs.count {
                imageViews[index].image = thumbs[index]
            }
        }
        resetAllImageViews()
    }
}

extension ViewController {
    private func resetImageView(at index: Int) {
        imageViews[index].image = UIImage(systemName: "photo")
    }
    
    private func resetAllImageViews() {
        for index in 0...4 {
            resetImageView(at: index)
        }
    }
    
    private func resetProgress(at index: Int) {
        progressViews[index].progress = 0
    }
    
    private func resetAllProgress() {
        for index in 0...4 {
            resetProgress(at: index)
        }
    }
}
