//
//  String+Image.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit

extension String {

    func loadImage(into imageView: UIImageView) {
        
        
        let session = URLSession.shared
        if let url = URL(string: self) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                OperationQueue.main.addOperation {
                    if error == nil {
                        imageView.image = UIImage(data: data!)
                    } else {
                        let image = UIImage.init(contentsOfFile: "logoTienda.png")
                        imageView.image = image
                    }
                }
            }
            task.resume()
        }
        
    }
}
