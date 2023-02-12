//
//  NewsData.swift
//  NewsApp
//
//  Created by Halil Bakar on 9.02.2023.
//

import Foundation

class NewsData {
    
    let categorys = ["Top","Business","Entertainment","General","Health","Science","Sports","Technology"]
    
    let apiUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=543436efe10648cc9867bf9bb7c1bc95"
    
    func getResultsData(completion: @escaping ([Articles]?) -> ()) {
        
        if isSelect == "" || isSelect == "Top" {
            
            urlParse(apiUrl)
            
        } else {
            
            let stringUrl = "\(apiUrl)&category=\(isSelect.lowercased())"
            
            urlParse(stringUrl)
        }
        
        func urlParse(_ url: String) {
            
            guard let url = URL(string: url ) else { return }
            
            URLSession.shared.dataTask(with: url ) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                }
                
                else if let data = data {
                    
                    do {
                        
                        let news = try? JSONDecoder().decode(NewsResponse.self, from: data)
                        
                        if let news = news {
                            completion(news.articles)
                        }
                        print(news?.articles ?? "")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}

