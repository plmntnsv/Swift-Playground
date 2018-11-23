//
//  AllBooksTableViewController.swift
//  MilenaBooksApp
//
//  Created by Plamen on 23.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit
import Alamofire

class AllBooksTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadData()
    }

    func loadData() {
        print("loading")
        Alamofire.request("http://milenabooks.azurewebsites.net/api/books").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AllBooksTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookMockData.books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableCell", for: indexPath)
        
        if let bookCell = cell as? BookTableViewCell {
            bookCell.bookTitleLabel.text = BookMockData.books[indexPath.row]?.title
            bookCell.bookAuthorLabel.text = BookMockData.books[indexPath.row]?.author
            
            DispatchQueue.global(qos: .background).async {
                if let url = BookMockData.books[indexPath.row]?.coverImageUrl {
                    let urlContents = try? Data(contentsOf: (URL(string: url))!)
                    DispatchQueue.main.async {
                        if let imgData = urlContents {
                            bookCell.bookCoverImageView.image = UIImage(data: imgData)
                        } else {
                            print("failed to load book cover image")
                        }
                        bookCell.activitySpinner.isHidden = true
                    }
                }
            }
        }
        
        return cell
    }
}
