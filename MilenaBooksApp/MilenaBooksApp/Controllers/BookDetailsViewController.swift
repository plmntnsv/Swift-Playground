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
    private var deleteBtnPressed = false
    var shouldDeletePrevViewController = false
    
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBookDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shouldDeletePrevViewController {
            if let navController = self.navigationController {
                let positionOfPreviousVC = navController.viewControllers.endIndex - 2
                print(navController.viewControllers[positionOfPreviousVC])
                navController.viewControllers[positionOfPreviousVC].removeFromParent()
                shouldDeletePrevViewController = false
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("will disappear")
        
        if self.isMovingFromParent {
            //moveBack(deleteBtnPressed)
        }
    }
    
    // the back button is pressed or book is being deleted
    private func moveBack(_ deleteBtnPressed: Bool){
        print("moving from parent")
        if let navController = self.navigationController {
            if deleteBtnPressed {
                
                let positionOfPreviousVC = navController.viewControllers.endIndex - 1
                
                if let allBooksVC = (self.navigationController?.viewControllers[positionOfPreviousVC] as? AllBooksTableViewController) {
                    print("prev view controller is allbooks")
                    allBooksVC.shouldReloadData = true
                    allBooksVC.bookToRemove = self.book
                }
            }
            
            if let returnViewController = navController.viewControllers[1] as? AllBooksTableViewController {
                print("returning to all books vc")
                navController.popToViewController(returnViewController, animated: false)
            } else {
                print("returning to home")
                navController.popToRootViewController(animated: false)
            }
        }
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
                self.bookDetailsView.bookCoverImageView.downloadImageFromUrl(urlString: url) { _ in print("successfully fetched image")}
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
                
                if response.error == nil {
                    if let navController = self.navigationController {
//                        self.deleteBtnPressed = true
//                        navController.viewControllers.removeLast()
                        if let returnViewController = navController.viewControllers[1] as? AllBooksTableViewController {
                            print("returning to all books vc")
                            returnViewController.shouldReloadData = true
                            returnViewController.bookToRemove = self.book
                            navController.popToViewController(returnViewController, animated: false)
                        } else {
                            print("returning to home")
                            navController.popToRootViewController(animated: false)
                        }
                    }
                } else {
                    print(response.error!)
                }
        }
    }
}
