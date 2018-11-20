//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Plamen on 19.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, UIDropInteractionDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var picUrls = [URL(string: "https://cdn2.vectorstock.com/i/1000x1000/35/16/cartoon-nature-landscape-background-with-green-mea-vector-2603516.jpg"),
                   URL(string: "https://i.graphicmama.com/blog/wp-content/uploads/2016/12/02102626/cartoon-landscape-vector.png")]
    
    var pics = [UIImage]()
    
    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    @IBOutlet weak var imageGalleryView: UICollectionView!{
        didSet {
            imageGalleryView.dataSource = self
            imageGalleryView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    // Table view stuff
    // what type of files are permitted to be dropped
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    var imageFetcher: ImageFetcher!
    
    // copy or move
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    // after drop
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url, image) in 
            DispatchQueue.main.async {
                //self.imageGalleryView.backgroundImage = image
            }
        }
        
        session.loadObjects(ofClass: NSURL.self) { nsurls in
            if let url = nsurls.first as? URL {
                //self.imageFetcher.fetch(url)
            }
        }
        
        session.loadObjects(ofClass: UIImage.self) { (images) in
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
    }
    
    // Collection view stuff
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.imageView.image = pics[indexPath.item]
        }
        
        return cell
    }
    
    // Private
    private func fetchImage(){
        for url in picUrls {
            let urlContents = try? Data(contentsOf: url!)
            if let imgData = urlContents {
                self.pics.append(UIImage(data: imgData)!)
            } else {
                // if no image append default img or something
            }
        }
    }
    
//    private func fetchImage(){
//        for url in picUrls {
//            DispatchQueue.global(qos: .background).async { [weak self] in
//                let urlContents = try? Data(contentsOf: url!)
//                DispatchQueue.main.async {
//                    if let imgData = urlContents {
//                        self?.pics.append(UIImage(data: imgData)!)
//                    } else {
//                        // if no image append default img or something
//                    }
//                }
//            }
//
//        }
//    }
}
