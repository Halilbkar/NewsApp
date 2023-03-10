//
//  ViewController.swift
//  NewsApp
//
//  Created by Halil Bakar on 9.02.2023.
//

import UIKit

var isSelect = ""

class NewsMainVC: UIViewController {
    
    @IBOutlet weak var ─▒mageCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
        
    var newsData = NewsData()
    var dataName = [Articles]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ─▒mageCollectionView.delegate = self
        ─▒mageCollectionView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateData()
    }
    
    func updateData() {
        
        newsData.getResultsData { [weak self] articles in
            
            guard let self = self else { return }
            
            if let answer = articles{
                self.dataName = answer
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.─▒mageCollectionView.reloadData()
            }
        }
    }
    
    func updateView() {
        
        newsData.getResultsData { [weak self] articles in
            
            guard let self = self else { return }
            
            if let answer = articles{
                self.dataName = answer
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as? Int
        
        let destVC = segue.destination as! NewsDetailVC
        destVC.news = dataName[index!]
    }
}

// MARK: CollectionView

extension NewsMainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ─▒mageCollectionView {
            return dataName.count
        }
        
        return newsData.categorys.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        if collectionView == self.collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionVC
            
            cell.collectionLabel.text = newsData.categorys[indexPath.row]
            
            return cell
            
        }
        
        if collectionView == self.─▒mageCollectionView {
            
            let index = dataName[indexPath.row]
            
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "─▒mageCell", for: indexPath) as! NewsImageVC
            
            cellB.collectSetup(imageCell: index)
                        
            return cellB
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        isSelect = newsData.categorys[indexPath.row]
        
        if collectionView == ─▒mageCollectionView {
            
            performSegue(withIdentifier: "toDetail", sender: indexPath.row)
            
        } else {
            updateView()
        }
        
    }
}

// MARK: TableView

extension NewsMainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let indexNews = dataName[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! NewsTableViewCell
        
        cell.tableSetup(news: indexNews)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
}
