//
//  Anagrams.swift
//  CodeCoverage
//
//  Created by Chris Grant on 26/06/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import Foundation

func checkWord(word: String, isAnagramOfWord: String) -> Bool {
    
    // Strip the whitespace and make both of the strings lowercase
    let noWhitespaceOriginalString = word.stringByReplacingOccurrencesOfString(" ", withString: "").lowercaseString
    let noWhitespaceComparisonString = isAnagramOfWord.stringByReplacingOccurrencesOfString(" ", withString: "").lowercaseString
    
    // If they have different lengths, they are definitely not anagrams
    if noWhitespaceOriginalString.characters.count != noWhitespaceComparisonString.characters.count {
        return false
    }
    
    // If they have no content, default to true.
    if noWhitespaceOriginalString.characters.count == 0 {
        return true
    }
    
    // If the strings are the same, they must be anagrams of each other!
    if noWhitespaceOriginalString == noWhitespaceComparisonString {
        return true
    }
    
    var dict = [Character: Int]()
    
    // Go through every character in the original string.
    for index in 1...noWhitespaceOriginalString.characters.count {
        
        // Find the index of the character at position i, then store the character.
        let originalWordIndex = advance(noWhitespaceOriginalString.startIndex, index - 1)
        let originalWordCharacter = noWhitespaceOriginalString[originalWordIndex]
        
        // Do the same as above for the compared word.
        let comparedWordIndex = advance(noWhitespaceComparisonString.startIndex, index - 1)
        let comparedWordCharacter = noWhitespaceComparisonString[comparedWordIndex]
        
        // Increment the value in the dictionary for the original word character. If it doesn't exist, set it to 0 first.
        dict[originalWordCharacter] = (dict[originalWordCharacter] ?? 0) + 1
        // Do the same for the compared word character, but this time decrement instead of increment.
        dict[comparedWordCharacter] = (dict[comparedWordCharacter] ?? 0) - 1
    }
    
    // Loop through the entire dictionary. If there's a value that isn't 0, the strings aren't anagrams.
    for key in dict.keys {
        if (dict[key] != 0) {
            return false
        }
    }
    
    // Everything in the dictionary must have been 0, so the strings are balanced.
    return true
}
