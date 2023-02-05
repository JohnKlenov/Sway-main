//
//  MSection.swift
//  Sway
//
//  Created by Evgenyi on 30.01.23.
//

import Foundation
import UIKit

struct MSectionImage: Decodable, Hashable {
    let section: String
    let items: [MImage]
}

extension MSectionImage {
    
    static func getData() -> [MSectionImage] {
        
        let mallsImage1 = MImage(image: "ic_food_banner1")
        let mallsImage2 = MImage(image: "ic_food_banner2")
        let mallsImage3 = MImage(image: "ic_food_banner3")
        let mallsImage4 = MImage(image: "ic_food_banner4")
        
        let mallsSection = MSectionImage(section: "Malls", items: [mallsImage1, mallsImage2, mallsImage3, mallsImage4])
        
        let categoryImage1 = MImage(image: "ic_bestseller")
        let categoryImage2 = MImage(image: "ic_express")
        let categoryImage3 = MImage(image: "ic_food_seleted")
        let categoryImage4 = MImage(image: "ic_newlaunch")
        let categoryImage5 = MImage(image: "ic_pocket")
        let categoryImage6 = MImage(image: "ic_premium")
        
        let categorySection = MSectionImage(section: "Category", items: [categoryImage1, categoryImage2, categoryImage3, categoryImage4, categoryImage5, categoryImage6])
        
        let productImage1 = MImage(image: "ic_search_img1")
        let productImage2 = MImage(image: "ic_search_img2")
        let productImage3 = MImage(image: "ic_search_img3")
        let productImage4 = MImage(image: "ic_search_img4")
        let productImage5 = MImage(image: "ic_search_img5")
        let productImage6 = MImage(image: "ic_search_img6")
        let productImage7 = MImage(image: "curated_img1")
        let productImage8 = MImage(image: "curated_img2")
        let productImage9 = MImage(image: "curated_img3")
        let productImage10 = MImage(image: "curated_img4")
        let productImage11 = MImage(image: "curated_img5")
        let productImage12 = MImage(image: "curated_img6")
        let productSection = MSectionImage(section: "Product", items: [productImage1, productImage2, productImage3, productImage4, productImage5, productImage6, productImage7, productImage8, productImage9, productImage10, productImage11, productImage12])

        return [mallsSection, categorySection, productSection]
    }
}

