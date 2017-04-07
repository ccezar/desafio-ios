//
//  UIImageView.swift
//  JavaPop
//
//  Created by Caio on 07/04/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import AFNetworking

extension UIImageView {
    func downloadedFrom(url: URL?, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = url else { return }
        self.image = nil
        
        let imageRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        if let dataImage = AFImageDownloader.defaultURLCache().cachedResponse(for: imageRequest)?.data {
            let image = UIImage.init(data: dataImage)
            self.image = image
        } else {
            AFImageDownloader.defaultInstance().downloadImage(for: imageRequest, success: { (request: URLRequest, response: HTTPURLResponse?, image: UIImage) in
                self.image = image
            }, failure: { (request: URLRequest, response: HTTPURLResponse?, error: Error) in
                // TODO: Set default image
            })
        }
    }
}
