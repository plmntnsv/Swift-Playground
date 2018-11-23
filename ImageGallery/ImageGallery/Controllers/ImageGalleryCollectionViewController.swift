//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Plamen on 19.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ImageGalleryCollectionViewController: UIViewController, UIDropInteractionDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    var picUrls = [URL(string: "https://cdn2.vectorstock.com/i/1000x1000/35/16/cartoon-nature-landscape-background-with-green-mea-vector-2603516.jpg"),
                   URL(string: "https://i.graphicmama.com/blog/wp-content/uploads/2016/12/02102626/cartoon-landscape-vector.png"),
                   URL(string: "https://image.freepik.com/free-vector/natural-landscape-cartoon_23-2147499451.jpg"),
                   URL(string: "https://images.all-free-download.com/images/graphicthumb/cartoon_natural_landscapes_beautiful_vector_585947.jpg")]
    
    var pics = [UIImage]()
    
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
    }
    
    // Private
    private func fetchImagesSync(){
        for url in picUrls {
            let urlContents = try? Data(contentsOf: url!)
            print("sync download \(self.pics.count)")
            if let imgData = urlContents {
                self.pics.append(UIImage(data: imgData)!)
            } else {
                // if no image append default img or something
            }
        }
    }
    
    private func fetchImagesAsync(){
        for index in picUrls.indices {
            DispatchQueue.global(qos: .background).async { [weak self] in
                let urlContents = try? Data(contentsOf: (self?.picUrls[index])!)
                print("async download \(index)")
                DispatchQueue.main.async {
                    if let imgData = urlContents {
                        self?.pics.append(UIImage(data: imgData)!)
                        
                    } else {
                        // if no image append default img or something
                    }
                }
            }

        }
    }
}

extension ImageGalleryCollectionViewController {
    // Collection view stuff
    // creation
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        if let imageCell = cell as? ImageCollectionViewCell {
            DispatchQueue.global(qos: .background).async { [weak self] in
                let urlContents = try? Data(contentsOf: (self?.picUrls[indexPath.item])!)
                DispatchQueue.main.async {
                    if let imgData = urlContents {
                        imageCell.imageView.image = UIImage(data: imgData)
                        imageCell.activitySpinner.isHidden = true
                    } else {
                        // if no image append default placeholder or something
                    }
                }
            }
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
            if let sourceIndexPath = item.sourceIndexPath, let imgUrl = item.dragItem.localObject as? URL {
                collectionView.performBatchUpdates({
                    picUrls.remove(at: sourceIndexPath.item)
                    picUrls.insert(imgUrl, at: destinationIndexPath.item)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                })
                
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            } else {
                let placeholderContext = coordinator.drop(item.dragItem,
                                                          to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "DropPlaceholderCell"))
                
                item.dragItem.itemProvider.loadObject(ofClass: URL.self) { (provider, error) in
                    DispatchQueue.main.async {
                        if let imgUrl = provider?.imageURL {
                            placeholderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                                self.picUrls.insert(imgUrl, at: insertionIndexPath.item)
                            })
                        } else {
                            placeholderContext.deletePlaceholder()
                        }
                    }
                }
            }
        }
    }
    
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        if let img = (imageGalleryView.cellForItem(at: indexPath) as? ImageCollectionViewCell)?.imageView.image {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: img))
            dragItem.localObject = img
            return [dragItem]
        } else {
            return []
        }
    }
}
