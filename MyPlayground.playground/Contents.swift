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
    
    var description: String {
        return "\(self.string): \(self.frequency)"
    }
}

func words() -> [String] {
    let input = "I am already far north of London and as I walk in the streets of Petersburgh I feel a cold northern breeze play upon my cheeks which braces my nerves and fills me with delight Do you understand this feeling This breeze which has travelled from the regions towards which I am advancing gives me a foretaste of those icy climes Inspirited by this wind of promise my daydreams become more fervent and vivid I try in vain to be persuaded that the pole is the seat of frost and desolation it ever presents itself to my imagination as the region of beauty and delight There Margaret the sun is forever visible its broad disk just skirting the horizon and diffusing a perpetual splendour Therefore with your leave my sister I will put some trust in preceding navigators there snow and frost are banished and sailing over a calm sea we may be wafted to a land surpassing in wonders and in beauty every region hitherto discovered on the habitable globe Its productions and features may be without example as the phenomena of the heavenly bodies undoubtedly are in those undiscovered solitudes What may not be expected in a country of eternal light I may there discover the wondrous power which attracts the needle and may regulate a thousand celestial observations that require only this voyage to render their seeming eccentricities consistent forever I shall satiate my ardent curiosity with the sight of a part of the world never before visited and may tread a land never before imprinted by the foot of man These are my enticements and they are sufficient to conquer all fear of danger or death and to induce me to commence this laborious voyage with the joy a child feels when he embarks in a little boat with his holiday mates on an expedition of discovery up his native river But supposing all these conjectures to be false you cannot contest the inestimable benefit which I shall confer on all mankind to the last generation by discovering a passage near the pole to those countries to reach which at present so many months are requisite or by ascertaining the secret of the magnet which if at all possible can only be effected by an undertaking such as mine"
    return input.lowercased().components(separatedBy: .whitespacesAndNewlines)
}

print("Hello world")