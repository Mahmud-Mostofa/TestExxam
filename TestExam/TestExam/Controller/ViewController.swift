//
//  ViewController.swift
//  TestExam
//
//  Created by Mahmud Mostofa on 17/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    let parser = Parser()
    var result = [Result]()
    var searchData = [Result]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        parser.parse {
            data in
            self.result = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }

}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    private func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieTableViewCell
          
        cell.titleLbl.text = result[indexPath.row].originalTitle
        cell.descriptionLbl.text = result[indexPath.row].overview
        let image = URL(string: "https://image.tmdb.org/t/p/w500" + result[indexPath.row].posterPath)
        let data = try? Data(contentsOf: image!)
        
        if let imageData = data {
            cell.posterImg.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

         searchData = []
        tableView.scrollsToTop = true
        
        for search in result {
            if searchBar.text == "" {
                searchData = result
            } else {
                if search.originalTitle.lowercased().contains(searchBar.text!.lowercased())
                {
                    searchData.append(search)
                }
            }
        }
        tableView.reloadData()
    }
    
}
