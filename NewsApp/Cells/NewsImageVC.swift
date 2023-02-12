//
//  NewsImageVC.swift
//  NewsApp
//
//  Created by Meltem Baysal on 9.02.2023.
//

import UIKit

class NewsImageVC: UICollectionViewCell {
    
    @IBOutlet weak var sliderImageView: UIImageView!
    
    func collectSetup(imageCell: Articles) {
        
        sliderImageView.layer.cornerRadius = 10
        
        if let url = URL(string: imageCell.urlToImage ?? "") {
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                       
                DispatchQueue.main.async {
                    if let data = data {
                        self.sliderImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
