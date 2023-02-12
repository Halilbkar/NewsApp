//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Halil Bakar on 9.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableSetup(news: Articles) {
        
        newsImage.layer.cornerRadius = 10
        
        titleLabel.text = news.source.name!
        descriptionLabel.text = news.title!
        
        if let url = URL(string: news.urlToImage ?? "") {
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                       
                DispatchQueue.main.async {
                    if let data = data {
                        self.newsImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
