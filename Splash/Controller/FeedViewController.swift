//
//  FeedViewController.swift
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

import Alamofire
import SDWebImage

protocol CellButtonTapped: AnyObject {
    func buttonTapped(indexPath: IndexPath, isSelected: Bool)
}

class FeedViewController: UIViewController {
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadRemoteData()
    }
    
    func initialSetup() {
        self.imageTableView.delegate = self
        self.imageTableView.dataSource = self
        self.refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        self.imageTableView.addSubview(refreshControl)
    }
    
    // MARK: Actions
    @objc func refreshTableView(sender: UIRefreshControl) {
        self.refreshControl.beginRefreshing()
        loadRemoteData()
    }
    
    func loadRemoteData() {
        requestRemoteData { status, response in
            self.refreshControl.endRefreshing()
            if status {
                if self.dataSource.isEmpty {
                    self.dataSource = response ?? []
                } else {
                    self.dataSource.append(contentsOf: response ?? [])
                }
            }
        }
    }
    
    // Method to fetch remote data with page no and limit
    func requestRemoteData(_ completion: @escaping (Bool, [ResponseModel]?) -> Void) {
        let requestPage = currentPage == 0 ? 1 : (currentPage + 1)
        let requestUrl = "https://picsum.photos/v2/list?page=\(requestPage)&limit=20"
        if let url = URL(string: requestUrl) {
            AF.request(url, method: HTTPMethod.get).responseData { response in
                switch response.result {
                case let .success(value):
                    if response.data != nil {
                        self.currentPage = requestPage
                        let responseData = try? JSONDecoder().decode([ResponseModel].self, from: value)
                        completion(true, responseData)
                    } else {
                        completion(false, nil)
                    }
                case .failure(let _error):
                    print(_error.localizedDescription)
                    completion(false, nil)
                }
            }
        }
    }
}

