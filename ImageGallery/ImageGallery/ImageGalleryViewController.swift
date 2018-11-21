//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Plamen on 19.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, UIDropInteractionDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    var picUrls = [URL(string: "https://cdn2.vectorstock.com/i/1000x1000/35/16/cartoon-nature-landscape-background-with-green-mea-vector-2603516.jpg"),
                   URL(string: "https://i.graphicmama.com/blog/wp-content/uploads/2016/12/02102626/cartoon-landscape-vector.png"),
                   URL(string: "https://image.freepik.com/free-vector/natural-landscape-cartoon_23-2147499451.jpg"),
                   URL(string: "https://images.all-free-download.com/images/graphicthumb/cartoon_natural_landscapes_beautiful_vector_585947.jpg")]
    
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
            imageGalleryView.dragDelegate = self
            imageGalleryView.dropDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    // Generic view drop stuff
    // what type of files are permitted to be dropped
//    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
//    }
//
//    var imageFetcher: ImageFetcher!
//
//    // copy or move
//    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
//        return UIDropProposal(operation: .copy)
//    }
//
//    // after drop
//    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
//        imageFetcher = ImageFetcher() { (url, image) in
//            DispatchQueue.main.async {
//                //self.imageGalleryView.backgroundImage = image
//            }
//        }
//
//        session.loadObjects(ofClass: NSURL.self) { nsurls in
//            if let url = nsurls.first as? URL {
//                //self.imageFetcher.fetch(url)
//                self.picUrls.append(url)
//            }
//        }
//
////        session.loadObjects(ofClass: UIImage.self) { images in
////            if let image = images.first as? UIImage {
////                self.imageFetcher.backup = image
////            }
////        }
//    }
    
    // Collection view stuff
    // creation
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.imageView.image = pics[indexPath.item]
        }
        
        return cell
    }
    
    // drag beginning
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }
    
    // what the drag is accepting
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        
        return isSelf ? session.canLoadObjects(ofClass: UIImage.self) : session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: URL.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                if let img = item.dragItem.localObject as? UIImage {
                    collectionView.performBatchUpdates({
                        pics.remove(at: sourceIndexPath.item)
                        pics.insert(img, at: destinationIndexPath.item)
                        collectionView.deleteItems(at: [sourceIndexPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                    })
                    
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            } else {
                let placeholderContext = coordinator.drop(
                    item.dragItem,
                    to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "DropPlaceholderCell"))
                item.dragItem.itemProvider.loadObject(ofClass: UIImage.self) { (provider, error) in
                    DispatchQueue.main.async {
                        if let img = provider as? UIImage {
                                placeholderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                                    self.pics.insert(img, at: insertionIndexPath.item)
                                })
                        } else {
                            placeholderContext.deletePlaceholder()
                        }
                    }
                }
            }
        }
    }
    
    // Private
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        if let img = (imageGalleryView.cellForItem(at: indexPath) as? ImageCollectionViewCell)?.imageView.image {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: img))
            dragItem.localObject = img
            return [dragItem]
        } else {
            return []
        }
    }
    
    // make async
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
