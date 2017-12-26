//
//  SwiftRandom.swift
//
//  Created by Furkan Yilmaz on 7/10/15.
//  Copyright (c) 2015 Furkan Yilmaz. All rights reserved.
//

// each type has its own random

#if os(Linux)
	import Glibc
#else
	import Darwin
#endif

import Foundation

extension Int {
	static func random() -> Int {
		#if os(Linux)
			return Int(random())
		#else
			return Int(arc4random())
		#endif
	}

	static func random(_ max: UInt32) -> Int {
		#if os(Linux)
			return Int(UInt32(random()) % max)
		#else
			return Int(arc4random_uniform(UInt32(max)))
		#endif
	}
}

public extension Bool {
    /// SwiftRandom extension
    public static func random() -> Bool {
        return Int.random() % 2 == 0
    }
}

public extension Int {
    /// SwiftRandom extension
    public static func random(_ range: Range<Int>) -> Int {
        #if swift(>=3)
            return random(range.lowerBound, range.upperBound - 1)
        #else
            return random(range.upperBound, range.lowerBound)
        #endif
    }

    /// SwiftRandom extension
    public static func random(_ range: ClosedRange<Int>) -> Int {
        return random(range.lowerBound, range.upperBound)
    }

    /// SwiftRandom extension
    public static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int {
		return lower + Int.random(UInt32(upper - lower + 1))
    }
}

public extension Int32 {
    /// SwiftRandom extension
    public static func random(_ range: Range<Int>) -> Int32 {
        return random(range.upperBound, range.lowerBound)
    }

    /// SwiftRandom extension
    ///
    /// - note: Using `Int` as parameter type as we usually just want to write `Int32.random(13, 37)` and not `Int32.random(Int32(13), Int32(37))`
    public static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
		let r = Int.random(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}

public extension String {
    /// SwiftRandom extension
    public static func random(ofLength length: Int) -> String {
        return random(minimumLength: length, maximumLength: length)
    }

    /// SwiftRandom extension
    public static func random(minimumLength min: Int, maximumLength max: Int) -> String {
        return random(
            withCharactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
            minimumLength: min,
            maximumLength: max
        )
    }

    /// SwiftRandom extension
    public static func random(withCharactersInString string: String, ofLength length: Int) -> String {
        return random(
            withCharactersInString: string,
            minimumLength: length,
            maximumLength: length
        )
    }

    /// SwiftRandom extension
    public static func random(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        guard min > 0 && max >= min else {
            return ""
        }

        let length: Int = (min < max) ? .random(min...max) : max
        var randomString = ""

        (1...length).forEach { _ in
            let randomIndex: Int = .random(0..<string.count)
            let c = string.index(string.startIndex, offsetBy: randomIndex)
            randomString += String(string[c])
        }

        return randomString
    }
}

public extension Double {
    /// SwiftRandom extension
    public static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(Int.random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Float {
    /// SwiftRandom extension
    public static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(Int.random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Date {
    /// SwiftRandom extension
    public static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)

		let r1 = Int.random(UInt32(days))
        let r2 = Int.random(UInt32(23))
        let r3 = Int.random(UInt32(59))
        let r4 = Int.random(UInt32(59))

        var offsetComponents = DateComponents()
        offsetComponents.day = Int(r1) * -1
        offsetComponents.hour = Int(r2)
        offsetComponents.minute = Int(r3)
        offsetComponents.second = Int(r4)

        guard let rndDate1 = gregorian.date(byAdding: offsetComponents, to: today) else {
            print("randoming failed")
            return today
        }
        return rndDate1
    }

    /// SwiftRandom extension
    public static func random() -> Date {
        let randomTime = TimeInterval(Int.random(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }

}

public extension Array {
    /// SwiftRandom extension
    public func randomItem() -> Element? {
        guard self.count > 0 else {
            return nil
        }

        let index = Int(Int.random(UInt32(self.count)))
        return self[index]
    }
}

public extension ArraySlice {
    /// SwiftRandom extension
    public func randomItem() -> Element? {
        guard self.count > 0 else {
            return nil
        }

        #if swift(>=3)
            let index = Int.random(self.startIndex, self.count - 1)
        #else
            let index = Int.random(self.startIndex, self.endIndex)
        #endif

        return self[index]
    }
}

public extension URL {
    /// SwiftRandom extension
    public static func random() -> URL {
        let urlList = ["http://www.google.com", "http://leagueoflegends.com/", "https://github.com/", "http://stackoverflow.com/", "https://medium.com/", "http://9gag.com/gag/6715049", "http://imgur.com/gallery/s9zoqs9", "https://www.youtube.com/watch?v=uelHwf8o7_U"]
        return URL(string: urlList.randomItem()!)!
    }
}


public struct Randoms {

    //==========================================================================================================
    // MARK: - Object randoms
    //==========================================================================================================

    public static func randomBool() -> Bool {
        return Bool.random()
    }

    public static func randomInt(_ range: Range<Int>) -> Int {
        return Int.random(range)
    }

    public static func randomInt(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return Int.random(lower, upper)
    }

    public static func randomInt32(_ range: Range<Int>) -> Int32 {
        return Int32.random(range)
    }

    public static func randomInt32(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        return Int32.random(lower, upper)
    }

    public static func randomString(ofLength length: Int) -> String {
        return String.random(ofLength: length)
    }

    public static func randomString(minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(minimumLength: min, maximumLength: max)
    }

    public static func randomString(withCharactersInString string: String, ofLength length: Int) -> String {
        return String.random(withCharactersInString: string, ofLength: length)
    }

    public static func randomString(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(withCharactersInString: string, minimumLength: min, maximumLength: max)
    }

    public static func randomPercentageisOver(_ percentage: Int) -> Bool {
        return Int.random() >= percentage
    }

    public static func randomDouble(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return Double.random(lower, upper)
    }

    public static func randomFloat(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return Float.random(lower, upper)
    }

    public static func randomDateWithinDaysBeforeToday(_ days: Int) -> Date {
        return Date.randomWithinDaysBeforeToday(days)
    }

    public static func randomDate() -> Date {
        return Date.random()
    }

    public static func randomNSURL() -> URL {
        return URL.random()
    }

    //==========================================================================================================
    // MARK: - Fake random data generators
    //==========================================================================================================

    public static func randomFakeName() -> String {
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross", "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
        return firstNameList.randomItem()! + " " + lastNameList.randomItem()!
    }

    public static func randomFakeGender() -> String {
        return Bool.random() ? "Male" : "Female"
    }

    public static func randomFakeConversation() -> String {
        let convoList = ["You embarrassed me this evening.", "You don't think that was just lemonade in your glass, do you?", "Do you ever think we should just stop doing this?", "Why didn't he come and talk to me himself?", "Promise me you'll look after your mother.", "If you get me his phone, I might reconsider.", "I think the room is bugged.", "No! I'm tired of doing what you say.", "For some reason, I'm attracted to you."]
        return convoList.randomItem()!
    }

    public static func randomFakeTitle() -> String {
        let titleList = ["CEO of Google", "CEO of Facebook", "VP of Marketing @Uber", "Business Developer at IBM", "Jungler @ Fanatic", "B2 Pilot @ USAF", "Student at Stanford", "Student at Harvard", "Mayor of Raccoon City", "CTO @ Umbrella Corporation", "Professor at Pallet Town University"]
        return titleList.randomItem()!
    }

    public static func randomFakeTag() -> String {
        let tagList = ["meta", "forum", "troll", "meme", "question", "important", "like4like", "f4f"]
        return tagList.randomItem()!
    }

    fileprivate static func randomEnglishHonorific() -> String {
        let englishHonorificsList = ["Mr.", "Ms.", "Dr.", "Mrs.", "Mz.", "Mx.", "Prof."]
        return englishHonorificsList.randomItem()!
    }

    public static func randomFakeNameAndEnglishHonorific() -> String {
        let englishHonorific = randomEnglishHonorific()
        let name = randomFakeName()
        return englishHonorific + " " + name
    }

    public static func randomFakeCity() -> String {
        let cityPrefixes = ["North", "East", "West", "South", "New", "Lake", "Port"]
        let citySuffixes = ["town", "ton", "land", "ville", "berg", "burgh", "borough", "bury", "view", "port", "mouth", "stad", "furt", "chester", "mouth", "fort", "haven", "side", "shire"]
        return cityPrefixes.randomItem()! + citySuffixes.randomItem()!
    }

    public static func randomCurrency() -> String {
        let currencyList = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "ZAR", "NZD", "INR", "BRP", "CNY", "EGP", "KRW", "MXN", "SAR", "SGD",]

        return currencyList.randomItem()!
    }
}
