//
//  Card.swift
//  Black Jack Saga
//
//  Created by Treinetic Macbook004 on 8/16/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import Foundation
class Card{
    var imageName : String!
    var value : Int!
    var type : String!
    static var cardList = [Card]()
    var tempCards = [Card]()
    var tempDealerCards = [Card]()
    
    init(){
        Card.initializeCards()
    }
    
    static func initializeCards(){
        Card.cardList.removeAll()
        for x in 3 ... 10 {
            self.cardList.append(Card(imageName: "\(x)C", value: x, type: "Number"))
            self.cardList.append(Card(imageName: "\(x)D", value: x, type: "Number"))
            self.cardList.append(Card(imageName: "\(x)S", value: x, type: "Number"))
            self.cardList.append(Card(imageName: "\(x)H", value: x, type: "Number"))
        }
        self.cardList.append(Card(imageName: "AC", value: 11, type: "King"))
        self.cardList.append(Card(imageName: "AD", value: 11, type: "King"))
        self.cardList.append(Card(imageName: "AS", value: 11, type: "King"))
        self.cardList.append(Card(imageName: "AH", value: 11, type: "King"))
        
        self.cardList.append(Card(imageName: "KC", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "KD", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "KS", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "KH", value: 10, type: "!Number"))
        
        self.cardList.append(Card(imageName: "QC", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "QD", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "QS", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "QH", value: 10, type: "!Number"))
        
        self.cardList.append(Card(imageName: "JC", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "JD", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "JS", value: 10, type: "!Number"))
        self.cardList.append(Card(imageName: "JH", value: 10, type: "!Number"))
    }
    
    func shuffleCards(){
        Card.cardList.shuffle()
    }
    
    func get2DeafultCards() -> [Card] {
        shuffleCards()
        tempCards.append(Card.cardList[Int.random(in: 0 ... 22)])
        tempCards.append(Card.cardList[Int.random(in: 22 ... 47)])
        return self.tempCards
    }
    
    func getDealerDeafultCards() -> [Card] {
        shuffleCards()
        tempDealerCards.append(Card.cardList[Int.random(in: 0 ... 22)])
        tempDealerCards.append(Card.cardList[Int.random(in: 22 ... 47)])
        return self.tempDealerCards
    }
    
    func getSingleCard() -> [Card] {
        let availableItems = Card.cardList.filter(
            {
                (
                    $0.getImageName() != self.tempCards[0].getImageName() && $0.getImageName() != self.tempCards[1].getImageName())
                
            })
        return availableItems.shuffled()
    }
    
    func getSingleDealerCard() -> [Card] {
        let availableItems = Card.cardList.filter(
        {
            (
                $0.getImageName() != self.tempDealerCards[0].getImageName())
            
        })
        return availableItems.shuffled()
    }
    
    init(imageName : String!, value: Int!, type: String!){
        self.imageName = imageName
        self.value = value
        self.type = type
    }
    
    func getImageName() -> String{
        return self.imageName
    }
    
    func getValue() -> Int{
        return self.value
    }
    
    func getType() -> String{
        return self.type
    }
}
