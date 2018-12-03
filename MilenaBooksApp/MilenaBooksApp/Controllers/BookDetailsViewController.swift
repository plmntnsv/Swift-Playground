//
//  BookDetailsViewController.swift
//  MilenaBooksApp
//
//  Created by Plamen on 26.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class BookDetailsViewController: UIViewController {
    private lazy var url = ApiEndPoints.BookEndPoint.get(book: book!).fullUrl
    var book: Book?
    var isEditted = false
    var shouldRemovePreviousVC = false
    private var deleteBtnPressed = false
    
    //var shouldDeletePrevViewController = false
    
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBookDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            if isEditted, let navController = self.navigationController {
                if let returnViewController = navController.viewControllers[1] as? AllBooksTableViewController {
                    returnViewController.bookToManipulate = self.book
                    returnViewController.isAnEdit = isEditted
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shouldRemovePreviousVC {
            if let navController = self.navigationController {
                let indexOfPrevVC = navController.viewControllers.endIndex - 2
                
                if navController.viewControllers[indexOfPrevVC] is UploadBookViewController {
                    navController.viewControllers[indexOfPrevVC].removeFromParent()
                }
            }
            
            shouldRemovePreviousVC = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayBookDetails()
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        if let activityButton = sender as? ActivityButtonView {
            activityButton.showLoading()
            delete(url: ApiEndPoints.BookEndPoint.delete(book: book!).fullUrl, sender: activityButton)
        }
    }
    
    private func displayBookDetails() {
        self.bookDetailsView.titleLabel.text = book?.title ?? "No title."
        self.bookDetailsView.authorNameLabel.text = book?.author ?? "No author."
        self.bookDetailsView.priceLabel.text = "Price: $\(Double((book?.price ?? 0.0)!))"
        self.bookDetailsView.ratingLabel.text = "Rating: \(Int((book?.rating ?? 0)!))"
        
        if book?.description != nil {
            self.bookDetailsView.descriptionTextView.text = book?.description
        } else {
            get(from: url)
        }
        
        if let coverImage = self.book?.coverImage {
            self.bookDetailsView.bookCoverImageView.image = UIImage(data: Data(coverImage))
        } else {
            if let url = self.book?.coverImageUrl {
                self.bookDetailsView.bookCoverImageView.downloadImageFromUrl(urlString: url) { data in
                    self.bookDetailsView.bookCoverImageView.image = UIImage(data: data!)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsToEditUploadSegue" {
            if let destination = segue.destination as? UploadBookViewController {
                destination.book = book
            }
        }
    }
}

extension BookDetailsViewController {
    private func get(from bookUrl: String) {
        Alamofire.request(bookUrl)
            .responseObject {(response: DataResponse<Book>) in
                let bookResponse = response.result.value
                self.bookDetailsView.descriptionTextView.text = bookResponse?.description ?? "No description."
                self.book?.description = bookResponse?.description
        }
    }
    
    private func delete(url: String, sender: ActivityButtonView) {
        Alamofire.request(url, method: .delete)
            .responseObject { (response: DataResponse<Book>) in
                
                sender.hideLoading()
                
                if response.error == nil, let navController = self.navigationController {
                        // we are coming from AllBooksViewController
                        if let returnViewController = navController.viewControllers[1] as? AllBooksTableViewController {
                            self.isEditted = false
                            returnViewController.bookToManipulate = self.book
                            navController.popToViewController(returnViewController, animated: false)
                        } else { // we are comming from 
                            navController.popToRootViewController(animated: false)
                        }
                } else {
                    print(response.error!)
                }
        }
    }
}
