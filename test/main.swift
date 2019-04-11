//
//  main.swift
//  test
//
//  Created by David Linhares on 11/04/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation

func askName() -> String {
    print("Comment t'appel tu ?")
    return readLine() ?? "poulet"
}

func askPlayerItems(playerName: String, items: [(String, Int)], iaChoice: Int? = nil) -> (String, Int) {
    if let choice = iaChoice {
        return choice < items.count ? items[choice] : items[1]
    }

    print("\(player) quel items choisis-tu")

    var count = 0
    items.forEach { (name: String, stat: Int) in
        print("\(count + 1) - \(name) (stat: \(stat)")
        count += 1
    }

    let itemChoice =  Int(readLine() ?? "1") ?? 1

    return items[itemChoice - 1]
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

var player = ""
var playerWeapon: (name: String, pa: Int)
var playerShield: (name: String, pd: Int)
var weapons = [
    ("Cuillère", 175),
    ("Pistolet", 185),
    ("Poulet en caoutchou", 200),
    ("Samsung 💩", 180)]
var shields = [
    ("bouclier de bronze", 140),
    ("bouclier de fer", 170),
    ("bouclier de CaptainAmerica", 115)]
var players = [String: (weapon: (name: String, pa: Int), shield: (name: String, pd: Int), pv: Int)]()


player = askName()
playerWeapon = askPlayerItems(playerName: player, items: weapons)
playerShield = askPlayerItems(playerName: player, items: shields)
print("\(player) has choosed : \(playerWeapon.name) damage is : \(playerWeapon.pa)")
print("\(player) has choosed : \(playerShield.name) damage is : \(playerShield.pd)")

print("Combien de joueurs participent ? ")
var nbPlayer = Int(readLine() ?? "3") ?? 3

for _ in 0 ..< nbPlayer {
    let name = randomString(length: 5)
    players[name] = (
        weapon: askPlayerItems(playerName: name, items: weapons, iaChoice: Int.random(in: 0 ..< weapons.count)),
         shield: askPlayerItems(playerName: name, items: shields, iaChoice: Int.random(in: 0 ..< shields.count)),
         pv: Int.random(in: 1 ..< 300)
    )
}

players[player] = (playerWeapon, playerShield, 130)
while players.count > 1 {
    let hit = players.randomElement()!
    var target = players.randomElement()!

    players[target.key]?.pv -= (hit.value.weapon.pa - target.value.shield.pd)

    print("\(hit.key) attaque \(target.key) avec \(target.value.weapon.name), \(target.key) se defend avec \(target.value.shield.name), il lui reste \(target.value.pv > 0 ? target.value.pv : 0)")

    if target.value.pv < 1 {
        players.removeValue(forKey: hit.key)
        print("\(target.key) est mort")
    }
}


print("\(players.first?.key) à gagner")
