//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Halil Bakar on 9.02.2023.
//

import UIKit
import SafariServices

class NewsDetailVC: UIViewController {
    
    var news: Articles?

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailConcent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailSetup()
    }
    
    @IBAction func openLink(_ sender: Any) {
        
        guard let url = URL(string: news!.url ?? "") else { return }
        
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    
    
    func DetailSetup() {
        
        if let response = news {
            detailLabel.text = response.title
            detailConcent.text = response.content
            
            if let url = URL(string: news?.urlToImage ?? "") {
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                           
                    DispatchQueue.main.async {
                        if let data = data {
                            self.detailImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
}
