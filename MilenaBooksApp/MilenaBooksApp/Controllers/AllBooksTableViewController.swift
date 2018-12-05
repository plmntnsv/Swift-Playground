//
//  AllBooksTableViewController.swift
//  MilenaBooksApp
//
//  Created by Plamen on 23.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class AllBooksTableViewController: UITableViewController {
    private var allBooks = [Book]()
    var newBook: Book?
    var isAnEdit = false
    private var booksFetched = false
    private var shouldScrollToTop = false
    var deleteBook = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBtn()
        addRefreshControl()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let bookToEditOrRemove = newBook, let indexOfBook = allBooks.firstIndex(where: { $0.id == bookToEditOrRemove.id }) {
            if deleteBook {
                allBooks.remove(at: indexOfBook)
            }
            
            if isAnEdit {
                allBooks.remove(at: indexOfBook)
                allBooks.insert(bookToEditOrRemove, at: indexOfBook)
            }
        } else if let bookToAdd = newBook, !deleteBook {
            self.allBooks.insert(bookToAdd, at: 0)
            shouldScrollToTop = true
        }
        
        self.deleteBook = false
        self.newBook = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
        if shouldScrollToTop {
            self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            shouldScrollToTop = false
        }
    }

    @objc private func getData() {
        Alamofire.request(ApiEndPoints.BookEndPoint.getAll.fullUrl)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseArray { (response: DataResponse<[Book]>) in
                let booksArray = response.result.value
                
                if let booksArray = booksArray {
                    self.allBooks = booksArray
                }
                
                self.booksFetched = true;
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
    }
}

// Additional setup of views
extension AllBooksTableViewController {
    private func addNavBtn(){
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(uploadBookBtnClicked))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    private func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        ]
        
        refreshControl.attributedTitle = NSAttributedString(string: "Getting books...", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(getData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
}

// Navigation stuff
extension AllBooksTableViewController {
    @objc private func uploadBookBtnClicked(){
        performSegue(withIdentifier: "AllBooksTableViewToUploadBook", sender: self.navigationItem.rightBarButtonItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookSelectSegue", let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedBook = allBooks[indexPath.row]
            if let destination = segue.destination as? BookDetailsViewController {
                destination.book = selectedBook
            }
        }
    }
}

// TableView stuff
extension AllBooksTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksFetched ? allBooks.count : 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if booksFetched {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "BookTableCell", for: indexPath)
            
            if let bookCell = cell as? BookTableViewCell {
                bookCell.bookTitleLabel.text = allBooks[indexPath.row].title ?? "No title."
                bookCell.bookAuthorLabel.text = allBooks[indexPath.row].author ?? "No author."
                
                if let imgData = allBooks[indexPath.row].coverImage {
                    bookCell.bookCoverImageView.image = UIImage(data: imgData)
                } else {
                    if let url = self.allBooks[indexPath.row].coverImageUrl {
                        bookCell.bookCoverImageView.imageUrl = url
                        bookCell.bookCoverImageView.downloadImageFromUrl(urlString: url) { data in
                            self.allBooks[indexPath.row].coverImage = data
                            if let bookCell = tableView.cellForRow(at: indexPath) as? BookTableViewCell{
                                bookCell.bookCoverImageView.image = UIImage(data: data!)
                            }
                        }
                    }
                }
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "LoadingBookCell", for: indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if booksFetched || allBooks.count > 0 {
            let cell = tableView.cellForRow(at: indexPath)
            performSegue(withIdentifier: "BookSelectSegue", sender: cell)
        }
    }
}
