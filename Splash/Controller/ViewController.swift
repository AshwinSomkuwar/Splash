//
//  ViewController.swift
//  Splash
//
//  Created by Ashwin Somkuwar on 28/04/23.
//
/*
 Create an application with following specifications

 1. A Splash screen with white background and desired image in centre

 2. After 5 secs , from splash screen user has to be navigated to a page which has a Tableview

 3. In Tableview page , each row will have a image , Title, description and checkbox (checkbox should be clickable by user and checkbox data should handled when table view scroll)

 4. Each row should be the right height to display its own content and no taller. No content should be clipped. This means some rows will be larger than others.

 5. Don't download all images at once, only as needed .

 6. Refresh function, either a refresh button or use pull down to refresh.

 7. On click of each cell, if checkbox is enabled display a dialog which shows the description else if checkbox is disabled display a alert.

  

  Guidelines

 1. Use Git to manage the source code. A clear Git history showing your process is required.

 2. Structure your code according to industry best practice design patterns.

 3. Scrolling the Tableview should be smooth, even as images are downloading and getting added to the cells.

 4. Comment your code when necessary.

 5. Commit your changes to git in small chunks with meaningful comments.

  

 iOS:

 1. Support should be from iOS 12.0 to latest

 2.You can use any tags from api to display title and description . Ex: Author and url

 3.Pull to refresh will refresh the tableview. It means same data. Add pagination if possible by changing the page no in api which gives next set of data.

  

 API:

 https://picsum.photos/v2/list?page=2&limit=20
 */

import UIKit

protocol CellButtonTapped: AnyObject {
    func buttonTapped(indexPath: IndexPath, isSelected: Bool)
}

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var imageTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    let cellIdentifier = "imageCell"
    let urlString = "https://picsum.photos/v2/list?page=2&limit=20"
    var dataSource: [ResponseModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.imageTableView.reloadData()
            }
        }
    }
    
    var currentPage = 0

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchData()
    }
    
    func initialSetup() {
        self.imageTableView.delegate = self
        self.imageTableView.dataSource = self
        self.refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        self.imageTableView.addSubview(refreshControl)
    }
    
    // MARK: Actions
    @objc func refreshTableView(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.imageTableView.reloadData()
            print("TableView refreshed...")
            self.refreshControl.endRefreshing()
        }
    }
    
    func fetchData() {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let safeData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([ResponseModel].self, from: safeData)
                print("RESPONSE: ----------------------")
                print(decodedData)

                self.dataSource = decodedData
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

