//
//  StaticData.swift
//  BooQs
//
//  Created by Leonardo Domingues on 6/11/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit

class StaticData {
    
    let postsToSell: Array<BQPost> = {
        var sellList = Array<BQPost>()
        
        // Users
        
        let user1 = BQUser(
            name: "José da Silva", phone: "9876-5432",
            address: BQAddress(
                street: "Rua dois", number: 225,
                district: "Centro",
                city: "João Pessoa",
                state: "PB", zipCode: "58012-345"), posts: Array<BQPost>())
        
        let user2 = BQUser(
            name: "Maria de Oliveira", phone: "9988-7766",
            address: BQAddress(
                street: "Rua três", number: 1772,
                district: "Jardim",
                city: "João Pessoa",
                state: "PB", zipCode: "58011-222"), posts: Array<BQPost>())
        
        let user3 = BQUser(
            name: "Marcos de Souza", phone: "9871-5111",
            address: BQAddress(
                street: "Rua quatro", number: 23,
                district: "Bessa",
                city: "João Pessoa",
                state: "PB", zipCode: "58088-385"), posts: Array<BQPost>())
        
        let user4 = BQUser(
            name: "Júlia Fernandes", phone: "99778-5257",
            address: BQAddress(
                street: "Rua vinte e três", number: 44,
                district: "Oceania",
                city: "João Pessoa",
                state: "PB", zipCode: "58013-321"), posts: Array<BQPost>())
        
        // Images
        
        var imagesBook1 = Array<UIImage>()
        imagesBook1.append(UIImage(named: "coding")!)
        
        var imagesBook2 = Array<UIImage>()
        imagesBook2.append(UIImage(named: "algorithms")!)
        
        var imagesBook3 = Array<UIImage>()
        imagesBook3.append(UIImage(named: "pragmatic")!)
        
        var imagesBook4 = Array<UIImage>()
        imagesBook4.append(UIImage(named: "cosmos")!)
        
        // Books
        
        let book1 = BQBook(
            title: "Cracking the Coding Interview",
            isbn: "817-6-817263-8-7", images: imagesBook1)
        
        let book2 = BQBook(
            title: "Algorihtms",
            isbn: "123-4-567890-1-2", images: imagesBook2)
        
        let book3 = BQBook(
            title: "The Pragmatic Programmer",
            isbn: "999-6-1010101-8-6", images: imagesBook3)
        
        let book4 = BQBook(
            title: "Cosmos",
            isbn: "369-3-3693693-6-9", images: imagesBook4)
        
        // Posts
        
        let post1 = BQPost(
            id: "1", user: user1, book: book1,
            category: BQPost.Category.sell)
        
        let post2 = BQPost(
            id: "2", user: user2, book: book2,
            category: BQPost.Category.sell)
        
        let post3 = BQPost(
            id: "3", user: user3, book: book3,
            category: BQPost.Category.sell)
        
        let post4 = BQPost(
            id: "4", user: user4, book: book4,
            category: BQPost.Category.sell)
        
        sellList.append(post1)
        sellList.append(post2)
        sellList.append(post3)
        sellList.append(post4)
        
        return sellList
    }()
    
    
    
    let postsToBorrow: Array<BQPost> = {
        var borrowList = Array<BQPost>()
        
        // Users
        
        let user1 = BQUser(
            name: "José da Silva", phone: "9876-5432",
            address: BQAddress(
                street: "Rua dois", number: 225,
                district: "Centro",
                city: "João Pessoa",
                state: "PB", zipCode: "58012-345"), posts: Array<BQPost>())
        
        let user2 = BQUser(
            name: "Maria de Oliveira", phone: "9988-7766",
            address: BQAddress(
                street: "Rua três", number: 1772,
                district: "Jardim",
                city: "João Pessoa",
                state: "PB", zipCode: "58011-222"), posts: Array<BQPost>())
        
        let user3 = BQUser(
            name: "Marcos de Souza", phone: "9871-5111",
            address: BQAddress(
                street: "Rua quatro", number: 23,
                district: "Bessa",
                city: "João Pessoa",
                state: "PB", zipCode: "58088-385"), posts: Array<BQPost>())
        
        let user4 = BQUser(
            name: "Júlia Fernandes", phone: "99778-5257",
            address: BQAddress(
                street: "Rua vinte e três", number: 44,
                district: "Oceania",
                city: "João Pessoa",
                state: "PB", zipCode: "58013-321"), posts: Array<BQPost>())
        
        // Images
        
        var imagesBook1 = Array<UIImage>()
        imagesBook1.append(UIImage(named: "algebra")!)
        
        var imagesBook2 = Array<UIImage>()
        imagesBook2.append(UIImage(named: "statistics")!)
        
        var imagesBook3 = Array<UIImage>()
        imagesBook3.append(UIImage(named: "oasis")!)
        
        var imagesBook4 = Array<UIImage>()
        imagesBook4.append(UIImage(named: "lightning")!)
        
        // Books
        
        let book1 = BQBook(
            title: "Algebra 2",
            isbn: "817-6-817263-8-7", images: imagesBook1)
        
        let book2 = BQBook(
            title: "Statistics 2",
            isbn: "123-4-567890-1-2", images: imagesBook2)
        
        let book3 = BQBook(
            title: "Gerring High the Adventures of Oasis",
            isbn: "999-6-1010101-8-6", images: imagesBook3)
        
        let book4 = BQBook(
            title: "Lightning",
            isbn: "369-3-3693693-6-9", images: imagesBook4)
        
        // Posts
        
        let post5 = BQPost(
            id: "5", user: user1, book: book1,
            category: BQPost.Category.borrow)
        
        let post6 = BQPost(
            id: "6", user: user2, book: book2,
            category: BQPost.Category.borrow)
        
        let post7 = BQPost(
            id: "7", user: user3, book: book3,
            category: BQPost.Category.borrow)
        
        let post8 = BQPost(
            id: "8", user: user4, book: book4,
            category: BQPost.Category.borrow)
        
        borrowList.append(post5)
        borrowList.append(post6)
        borrowList.append(post7)
        borrowList.append(post8)
        
        return borrowList
    }()
    
    
    
    let postsToDonate: Array<BQPost> = {
        var donateList = Array<BQPost>()
        
        // Users
        
        let user1 = BQUser(
            name: "José da Silva", phone: "9876-5432",
            address: BQAddress(
                street: "Rua dois", number: 225,
                district: "Centro",
                city: "João Pessoa",
                state: "PB", zipCode: "58012-345"), posts: Array<BQPost>())
        
        let user2 = BQUser(
            name: "Maria de Oliveira", phone: "9988-7766",
            address: BQAddress(
                street: "Rua três", number: 1772,
                district: "Jardim",
                city: "João Pessoa",
                state: "PB", zipCode: "58011-222"), posts: Array<BQPost>())
        
        let user3 = BQUser(
            name: "Marcos de Souza", phone: "9871-5111",
            address: BQAddress(
                street: "Rua quatro", number: 23,
                district: "Bessa",
                city: "João Pessoa",
                state: "PB", zipCode: "58088-385"), posts: Array<BQPost>())
        
        let user4 = BQUser(
            name: "Júlia Fernandes", phone: "99778-5257",
            address: BQAddress(
                street: "Rua vinte e três", number: 44,
                district: "Oceania",
                city: "João Pessoa",
                state: "PB", zipCode: "58013-321"), posts: Array<BQPost>())
        
        // Images
        
        var imagesBook1 = Array<UIImage>()
        imagesBook1.append(UIImage(named: "delivery")!)
        
        var imagesBook2 = Array<UIImage>()
        imagesBook2.append(UIImage(named: "midnight")!)
        
        var imagesBook3 = Array<UIImage>()
        imagesBook3.append(UIImage(named: "help")!)
        
        var imagesBook4 = Array<UIImage>()
        imagesBook4.append(UIImage(named: "odyssey")!)
        
        // Books
        
        let book1 = BQBook(
            title: "Special Delivery",
            isbn: "817-6-817263-8-7", images: imagesBook1)
        
        let book2 = BQBook(
            title: "Long After Midnight",
            isbn: "123-4-567890-1-2", images: imagesBook2)
        
        let book3 = BQBook(
            title: "The Help",
            isbn: "999-6-1010101-8-6", images: imagesBook3)
        
        let book4 = BQBook(
            title: "Trojan Odyssey",
            isbn: "369-3-3693693-6-9", images: imagesBook4)
        
        // Posts
        
        let post9 = BQPost(
            id: "9", user: user1, book: book1,
            category: BQPost.Category.donate)
        
        let post10 = BQPost(
            id: "10", user: user2, book: book2,
            category: BQPost.Category.donate)
        
        let post11 = BQPost(
            id: "11", user: user3, book: book3,
            category: BQPost.Category.donate)
        
        let post12 = BQPost(
            id: "12", user: user4, book: book4,
            category: BQPost.Category.donate)
        
        donateList.append(post9)
        donateList.append(post10)
        donateList.append(post11)
        donateList.append(post12)
        
        return donateList
    }()
    
}
