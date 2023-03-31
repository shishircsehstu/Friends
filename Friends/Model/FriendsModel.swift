
//  FriendsModel.swift
//  Friends
//  Created by Saddam on 30/3/23.

import Foundation

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable {
    let offset: String
    let description: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct AllFrinds: Codable{
    let results: [FriendsInfo]
    
}
struct FriendsInfo: Codable{
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
}


/*
 • Portrait
 • Full Name
 • Address
 • City, State, and Country
 • Email
 • Cell phone
 */
