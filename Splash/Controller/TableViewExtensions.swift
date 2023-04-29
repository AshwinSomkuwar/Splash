//
//  TableViewExtensions.swift
//  Splash
//
//  Created by Ashwin Somkuwar on 28/04/23.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource, CellButtonTapped {
    
    func buttonTapped(indexPath: IndexPath, isSelected: Bool) {
        dataSource[indexPath.row].isSelected = isSelected
        imageTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ImageTableViewCell
        
        let object = dataSource[indexPath.row]
        cell.object = object
        cell.indexPath = indexPath
        cell.delegate = self
        cell.authorLabel.text = object.author
        cell.urlLabel.text = object.url
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let object = dataSource[indexPath.row]
        
        // If the tick button is disabled, we show an alert
        if object.isSelected == false {
            let alert = UIAlertController(title: "Alert !!!", message: "Please select the image.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)

        } else {
            // If the tick button is enabled, we show a dialog which shows a description i.e. image URL
            
            let actionSheet = UIAlertController(title: "Image URL", message: object.url, preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "OK", style: .default)
            actionSheet.addAction(okAction)
            self.present(actionSheet, animated: true)
        }
    }
}

