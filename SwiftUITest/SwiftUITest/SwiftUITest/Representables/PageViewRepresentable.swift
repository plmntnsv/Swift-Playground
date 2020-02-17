//
//  PageViewRepresentable.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 17.02.20.
//  Copyright © 2020 Plamen Atanasov. All rights reserved.
//

import SwiftUI

struct PageViewRepresentable: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.backgroundColor = .blue
        pageControl.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        
        return pageControl
    }
    
    func updateUIView(_ pageControl: UIPageControl, context: Context) {
        pageControl.currentPage = currentPage
        print(currentPage)
    }
    
    class Coordinator: NSObject {
        var pageControl: PageViewRepresentable
        
        init(_ pageControl: PageViewRepresentable) {
            self.pageControl = pageControl
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            pageControl.currentPage = sender.currentPage
        }
    }
}
