import Foundation

/*
 Given an array of words, count the unique words in it.
 Sort the words by descending frequency.
 Then display the result to standard out.
 
 Example Input:
 The quick brown fox jumps over the lazy brown dog.
 
 Example Output:
 the : 2
 brown: 2
 quick: 1
 fox: 1
 jumps: 1
 over: 1
 lazy: 1
 dog: 1
 
 Proper error checking/exception handling is not required.
 
 */

struct Word: Comparable, CustomStringConvertible
{
    var string: String
    var frequency: Int
    
    init(string: String, frequency: Int) {
        self.string = string
        self.frequency = frequency
    }
    
    static func < (lhs: Word, rhs: Word) -> Bool {
        return lhs.frequency < rhs.frequency
    }
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.frequency == lhs.frequency
    }

    func alphabet(lhs: Word, rhs: Word) -> Bool {
        if lhs.frequency == rhs.frequency {
            return lhs.string > lhs.string
        } else {
            return lhs.frequency > rhs.frequency
        }
    }
    
    var description: String {
        return "\(self.string): \(self.frequency)"
    }

}

func words() -> [String] {
    let input = "I am already far north of London and as I walk in the streets of Petersburgh I feel a cold northern breeze play upon my cheeks which braces my nerves and fills me with delight Do you understand this feeling This breeze which has travelled from the regions towards which I am advancing gives me a foretaste of those icy climes Inspirited by this wind of promise my daydreams become more fervent and vivid I try in vain to be persuaded that the pole is the seat of frost and desolation it ever presents itself to my imagination as the region of beauty and delight There Margaret the sun is forever visible its broad disk just skirting the horizon and diffusing a perpetual splendour Therefore with your leave my sister I will put some trust in preceding navigators there snow and frost are banished and sailing over a calm sea we may be wafted to a land surpassing in wonders and in beauty every region hitherto discovered on the habitable globe Its productions and features may be without example as the phenomena of the heavenly bodies undoubtedly are in those undiscovered solitudes What may not be expected in a country of eternal light I may there discover the wondrous power which attracts the needle and may regulate a thousand celestial observations that require only this voyage to render their seeming eccentricities consistent forever I shall satiate my ardent curiosity with the sight of a part of the world never before visited and may tread a land never before imprinted by the foot of man These are my enticements and they are sufficient to conquer all fear of danger or death and to induce me to commence this laborious voyage with the joy a child feels when he embarks in a little boat with his holiday mates on an expedition of discovery up his native river But supposing all these conjectures to be false you cannot contest the inestimable benefit which I shall confer on all mankind to the last generation by discovering a passage near the pole to those countries to reach which at present so many months are requisite or by ascertaining the secret of the magnet which if at all possible can only be effected by an undertaking such as mine"
    return input.lowercased().components(separatedBy: .whitespacesAndNewlines)
}

let inputWords = words()
var outputObjects = [Word]()

func searchMatched(for word: String) -> Bool{
    for (index,object) in outputObjects.enumerated() {
        if object.string == word{
            outputObjects[index].frequency += 1
            return true
        }
    }
    return false
}

for word in inputWords{
    if searchMatched(for: word){
    } else {
        outputObjects.append(Word(string: word, frequency: 1))
    }
}

func sortByAlphabet(_ lhs: Word, _ rhs: Word) -> Bool {
    if lhs.frequency == rhs.frequency {
        if lhs.string < rhs.string {
            return true
        } else {
            return false
        }
    } else if lhs.frequency > rhs.frequency {
        return true
    } else {
        return false
    }
}
// 1. Count the unique words in array.
outputObjects.count
// 2. Sort the words by descending frequency. && Sort alphabetically.
outputObjects.sort(by: {sortByAlphabet($0, $1)})
// 3. Then display the result to standard out.
outputObjects.forEach({print($0)})


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 1) variant
let testString = "Hit the road Jack, Jack on road back jach jach jack jack"
let smallTestString = testString.replacingOccurrences(of: ",", with: "")
// create array from string
var wordsArray = smallTestString.lowercased().split(separator: " ")
var keyValueStore = [String: Int]()
// from array to dictionary
for word in wordsArray {
    keyValueStore.updateValue(0, forKey: String(word))
}
// compared word of array to dictionary key(String), if it equal - value(Int) incremented.
for word in wordsArray {
    for (key, value) in keyValueStore {
        if key == word {
            keyValueStore.updateValue(value + 1, forKey: key)
        }
    }
}
// sorted dictionary by descending values
var newDictStore = keyValueStore.sorted { $0.value > $1.value }
// output to std_out
for (dictKeyWord, equals) in newDictStore
{
    for wordFromArray in wordsArray
    {
        if dictKeyWord == wordFromArray{
            print(dictKeyWord + ":", equals)
            wordsArray.removeAll(where: { $0 == wordFromArray })

            //wordsArray.filter({$0 != wordFromArray})
            //wordsArray.removeAtIndex(wordsArray.indexOf(wordFromArray))
        }
    }
}




