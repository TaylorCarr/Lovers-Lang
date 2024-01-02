//
//  LoveLanguageQuizView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 11/7/23.
//

import SwiftUI

class UserInfo: ObservableObject {
    @Published var QuizQuestions: [QuizQuestion] = []
    @Published var QuizScore: QuizScore
    @Published var QuizAnswers = [QuizAnswer?](repeating: nil, count: Constants().MAX_INDEX + 1)
    
    init() {
        self.QuizScore = Lovers_Lang.QuizScore().fetchUserData() ?? Lovers_Lang.QuizScore()
        self.QuizAnswers.reserveCapacity(Constants().MAX_INDEX)
    }
}

struct LoveLanguageQuizView: View {
    @ObservedObject var userInfo: UserInfo
    @Binding var isShowingQuiz: Bool
    @State var questionNum: Int = 0
    @State var quizIndex: Int = 0

    var body: some View {
        NavigationStack {
            HStack {
                Button {
                    if(questionNum > 0) {
                        questionNum-=1
                    }
                } label: {
                    Image("backArrow").disabled(quizIndex == 0)
                }
                VStack {
                    Spacer()
                    Text("It's more meaningful to me when...")
                    Button(userInfo.QuizQuestions[questionNum].answerA.answer, action: {
                        userInfo.QuizAnswers[questionNum] = userInfo.QuizQuestions[questionNum].answerA
                    }).accessibilityIdentifier("buttonA")
                    .padding()
                    .frame(width: 300, height: 125, alignment: .center)
                    .background(userInfo.QuizQuestions[questionNum].answerA.type.backgroundColor)
                    .foregroundStyle(Color.white)
                    .clipShape(.capsule)
                    .opacity(userInfo.QuizAnswers[questionNum] == userInfo.QuizQuestions[questionNum].answerA  || userInfo.QuizAnswers[questionNum] == nil ? 1.0 : 0.7)
                    .scaleEffect(userInfo.QuizAnswers[questionNum] == userInfo.QuizQuestions[questionNum].answerB  || userInfo.QuizAnswers[questionNum] == nil ? 0.8 : 1.0)
                    Button(userInfo.QuizQuestions[questionNum].answerB.answer, action: {
                        userInfo.QuizAnswers[questionNum] = userInfo.QuizQuestions[questionNum].answerB
                    }).accessibilityIdentifier("buttonB")
                    .padding()
                    .frame(width: 300, height: 125, alignment: .center)
                    .background(userInfo.QuizQuestions[questionNum].answerB.type.backgroundColor)
                    .foregroundStyle(Color.white)
                    .clipShape(.capsule)
                    .opacity(userInfo.QuizAnswers[questionNum] == userInfo.QuizQuestions[questionNum].answerB || userInfo.QuizAnswers[questionNum] == nil ? 1.0 : 0.7)
                    .scaleEffect(userInfo.QuizAnswers[questionNum] == userInfo.QuizQuestions[questionNum].answerA  || userInfo.QuizAnswers[questionNum] == nil ? 0.8 : 1.0)
                    Button("Submit", action: {
                        if(questionNum == Constants().MAX_INDEX) {
                            //calculate final score
                            calcScore(userInfo: userInfo)
                            isShowingQuiz = false
                        } else if(questionNum == quizIndex) {
                            quizIndex+=1
                            questionNum+=1
                        } else {
                            questionNum+=1
                        }
                        print(questionNum)
                    }).disabled(userInfo.QuizAnswers[questionNum] == nil).accessibilityIdentifier("submit")
                    Spacer()
                }
                Button {
                    if(questionNum < quizIndex) {
                        questionNum+=1
                    }
                } label: {
                    Image("forwardArrow").disabled(questionNum == quizIndex)
                }
            }
        }
    }
}

struct QuizQuestion {
    var answerA: QuizAnswer
    var answerB: QuizAnswer
}

struct QuizAnswer: Equatable {
    var answer: String
    var type: languages
}

//struct favoriteLanguage {
//    var language: languages
//    var score: Int
//    var percentage: Float
//    
//    enum CodingKeys: String, CodingKey {
//        case language
//        case score
//        case percentage
//    }
//}

struct QuizScore: Codable {
    var actsOfService = 0
    var receivingGifts = 0
    var qualityTime = 0
    var wordsOfAffirmation = 0
    var physicalTouch = 0
    var favoriteLanguage: languages? = nil
    var favoriteScore: Int = 0
    var favoritePercentage = Float(0)
    
    enum CodingKeys: String, CodingKey {
        case actsOfService
        case receivingGifts
        case qualityTime
        case wordsOfAffirmation
        case physicalTouch
        case favoriteLanguage
        case favoriteScore
        case favoritePercentage
    }
    
    public func encode(to encoder:Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(actsOfService, forKey: .actsOfService)
        try container.encode(receivingGifts, forKey: .receivingGifts)
        try container.encode(physicalTouch, forKey: .physicalTouch)
        try container.encode(qualityTime, forKey: .qualityTime)
        try container.encode(wordsOfAffirmation, forKey: .wordsOfAffirmation)
        try container.encode(favoriteLanguage, forKey: .favoriteLanguage)
        try container.encode(favoriteScore, forKey: .favoriteScore)
        try container.encode(favoritePercentage, forKey: .favoritePercentage)
    }
    
    init() {
        
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            actsOfService = try container.decode(Int.self, forKey: .actsOfService)
            receivingGifts = try container.decode(Int.self, forKey: .receivingGifts)
            qualityTime = try container.decode(Int.self, forKey: .qualityTime)
            wordsOfAffirmation = try container.decode(Int.self, forKey: .wordsOfAffirmation)
            physicalTouch = try container.decode(Int.self, forKey: .physicalTouch)
            favoriteLanguage = try container.decode(languages.self, forKey: .favoriteLanguage)
            favoriteScore = try container.decode(Int.self, forKey: .favoriteScore)
            favoritePercentage = try container.decode(Float.self, forKey: .favoritePercentage)
        } catch {
            print(error)
        }
    }
    
    func addPoint(answerType: languages, userInfo: UserInfo) {
        switch answerType {
        case .actsOfService:
            userInfo.QuizScore.actsOfService+=1
        case .receivingGifts:
            userInfo.QuizScore.receivingGifts+=1
        case .qualityTime:
            userInfo.QuizScore.qualityTime+=1
        case .wordsOfAffirmation:
            userInfo.QuizScore.wordsOfAffirmation+=1
        case .physicalTouch:
            userInfo.QuizScore.physicalTouch+=1
        }
    }
    
    func saveUserData(userScore: QuizScore) {
        print(userScore)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userScore) {
            Constants().USER_DEFAULTS.set(encoded, forKey: "usersLoveLanguages")
        }
    }
    
    func fetchUserData() -> QuizScore? {
        if let data = Constants().USER_DEFAULTS.value(forKey: "usersLoveLanguages") as? Data {
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(QuizScore.self, from: data)
                return decoded
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    struct favoriteStruct {
        var favoriteLanguage: languages
        var favoriteScore: Int
        var favoritePercentage: Float
    }
    
    func fetchFavorite(userInfo: UserInfo) -> favoriteStruct {
        let words = Float(userInfo.QuizScore.wordsOfAffirmation)
        let gifts = Float(userInfo.QuizScore.receivingGifts)
        let acts = Float(userInfo.QuizScore.actsOfService)
        let time = Float(userInfo.QuizScore.qualityTime)
        let touch = Float(userInfo.QuizScore.physicalTouch)
        
        print(words)
        print(gifts)
        print(acts)
        print(time)
        print(touch)
        
        var percentage = words/Float(languages.wordsOfAffirmation.maxCount)
        print(words/Float(languages.wordsOfAffirmation.maxCount))
        print(gifts/Float(languages.receivingGifts.maxCount))
        print(acts/Float(languages.actsOfService.maxCount))
        print(time/Float(languages.qualityTime.maxCount))
        print(touch/Float(languages.physicalTouch.maxCount))
        var language = languages.wordsOfAffirmation
        var score = words
        
        if(percentage < gifts/Float(languages.receivingGifts.maxCount)) {
            percentage = gifts/Float(languages.receivingGifts.maxCount)
            language = languages.receivingGifts
            score = gifts
        }
        
        if(percentage < acts/Float(languages.actsOfService.maxCount)) {
            percentage = acts/Float(languages.actsOfService.maxCount)
            language = languages.actsOfService
            score = acts
        }
        
        if(percentage < time/Float(languages.qualityTime.maxCount)) {
            percentage = time/Float(languages.qualityTime.maxCount)
            language = languages.qualityTime
            score = time
        }
        
        if(percentage < touch/Float(languages.physicalTouch.maxCount)) {
            percentage = touch/Float(languages.physicalTouch.maxCount)
            language = languages.physicalTouch
            score = touch
        }
        
        return favoriteStruct(favoriteLanguage: language, favoriteScore: Int(score), favoritePercentage: percentage)
    }
}

enum languages: Codable {
    case actsOfService //max: 13
    case receivingGifts //max: 12
    case qualityTime //max: 13
    case wordsOfAffirmation //max: 12
    case physicalTouch //max: 10
}

extension languages {
    var backgroundColor: Color {
        switch (self) {
        case .actsOfService:
            return Color.blue
        case .physicalTouch:
            return Color.red
        case .qualityTime:
            return Color.green
        case .receivingGifts:
            return Color.orange
        case .wordsOfAffirmation:
            return Color.purple
        }
    }
    
    var maxCount: Int {
        switch (self) {
        case .actsOfService:
            return 13
        case .physicalTouch:
            return 10
        case .qualityTime:
            return 13
        case .receivingGifts:
            return 12
        case .wordsOfAffirmation:
            return 12
        }
    }
    
    var name: String {
        switch (self) {
        case .actsOfService:
            return "Acts of Service"
        case .physicalTouch:
            return "Physical Touch"
        case .qualityTime:
            return "Quality Time"
        case .receivingGifts:
            return "Receiving Gifts"
        case .wordsOfAffirmation:
            return "Words of Affirmation"
        }
    }
}

func prepareQuestions(userInfo: UserInfo) -> Void {
    var temp = QuizQuestion(answerA: QuizAnswer(answer: "I receive a loving note/text/email for no special reason from my loved one.", type: .wordsOfAffirmation), answerB: QuizAnswer(answer:"my partner and I hug.", type: .physicalTouch))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I can spend alone time with my partner - just the two of us", type: .qualityTime), answerB: QuizAnswer(answer:"my partner does something practical to help me out.", type: .actsOfService))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "my partner gives me a little gift as a token of our love for each other.", type: .receivingGifts), answerB: QuizAnswer(answer:"I get to spend uninterrupted leisure time with my partner.", type: .qualityTime))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "my partner unexpectedly does something for me like filling my car or doing the laundry.", type: .actsOfService), answerB: QuizAnswer(answer: "my partner and I touch.", type: .physicalTouch))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "my partner puts their arm around me when we're in public.", type: .physicalTouch), answerB: QuizAnswer(answer:"my partner surprises me with a gift.", type: .receivingGifts))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I’m around my partner, even if we’re not really doing anything.", type: .qualityTime), answerB: QuizAnswer(answer:"I hold hands with my partner.", type: .physicalTouch))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "my partner gives me a gift.", type: .receivingGifts), answerB: QuizAnswer(answer:"I hear “I love you” from my partner.", type: .wordsOfAffirmation))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I sit close to my partner.", type: .qualityTime), answerB: QuizAnswer(answer: "I am complimented by my loved one for no apparent reason.", type: .wordsOfAffirmation))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I get the chance to just “hang out” with my partner.", type: .qualityTime), answerB: QuizAnswer(answer:"I unexpectedly get small gifts from my partner.", type: .receivingGifts))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I hear my partner tell me, “I’m proud of you.", type: .wordsOfAffirmation), answerB: QuizAnswer(answer:"my partner helps me with a task.", type: .actsOfService))
    userInfo.QuizQuestions.append(temp)
    
    // 10 ---------------------------------------------------
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I get to do things with someone I love.", type: .qualityTime), answerB: QuizAnswer(answer:"I hear supportive words from someone I love.", type: .wordsOfAffirmation))
    userInfo.QuizQuestions.append(temp)
    
    // 11 ---------------------------------------------------
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love does things for me instead of just talking about doing nice things.", type: .actsOfService), answerB: QuizAnswer(answer: "I feel connected to someone I love through a hug.", type: .physicalTouch))
    userInfo.QuizQuestions.append(temp)
    
    // 12 ----------------------------
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I hear praise from someone I love.", type: .wordsOfAffirmation), answerB: QuizAnswer(answer:"someone I love gives me something that shows they were really thinking about me.", type: .receivingGifts))
    userInfo.QuizQuestions.append(temp)
    
    // 13
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I’m able to just be around someone I love.", type: .qualityTime), answerB: QuizAnswer(answer:"I get a back rub from someone I love.", type: .physicalTouch))
    userInfo.QuizQuestions.append(temp)
    
    // 14
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love reacts positively to something I’ve accomplished.", type: .wordsOfAffirmation), answerB: QuizAnswer(answer:"someone I love does something for me that I know they don’t particularly enjoy.", type: .actsOfService))
    userInfo.QuizQuestions.append(temp)
    
    // 15
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I am able to be in close physical proximity to someone I love.", type: .qualityTime), answerB: QuizAnswer(answer: "I sense someone I love showing interest in the things I care about.", type: .actsOfService))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love works on special projects with me that I have to complete.", type: .actsOfService), answerB: QuizAnswer(answer:"someone I love gives me an exciting gift.", type: .receivingGifts))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I’m complimented by someone I love on my appearance.", type: .wordsOfAffirmation), answerB: QuizAnswer(answer:"someone I love takes the time to listen to me and really understand my feelings.", type: .qualityTime))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I can share a meaningful touch in public with someone I love.", type: .physicalTouch), answerB: QuizAnswer(answer:"someone I love offers to run errands for me.", type: .actsOfService))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love does something special for me to help me out.", type: .actsOfService), answerB: QuizAnswer(answer: "I get a gift that someone I love put thought into choosing.", type: .receivingGifts))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love doesn’t check their phone while we’re talking with each other.", type: .qualityTime), answerB: QuizAnswer(answer:"someone I love goes out of their way to do something that relieves pressure on me.", type: .actsOfService))
    userInfo.QuizQuestions.append(temp)
    
    // 21 ------------------------------------------------
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I can look forward to a holiday because I’ll probably get a gift from someone I love.", type: .receivingGifts), answerB: QuizAnswer(answer:"I hear the words, “I appreciate you” from someone I love.", type: .wordsOfAffirmation))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love and haven’t seen in a while thinks enough of me to give me a little gift.", type: .receivingGifts), answerB: QuizAnswer(answer:"someone I love takes care of something I’m responsible to do but I feel too stressed to do at the time.", type: .actsOfService))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love doesn’t interrupt me while I’m talking.", type: .qualityTime), answerB: QuizAnswer(answer: "gift giving is an important part of the relationship with someone I love.", type: .receivingGifts))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love helps me out when they know I’m already tired.", type: .actsOfService), answerB: QuizAnswer(answer:"I get to go somewhere while spending time with someone I love.", type: .qualityTime))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love touches my arm or shoulder to show their care or concern.", type: .physicalTouch), answerB: QuizAnswer(answer: "someone I love gives me a little gift that they picked up in the course of their normal day.", type: .receivingGifts))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love says something encouraging to me.", type: .wordsOfAffirmation), answerB: QuizAnswer(answer:"I get to spend time in a shared activity or hobby with someone I love.", type: .qualityTime))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love surprises me with a small token of their appreciation.", type: .receivingGifts), answerB: QuizAnswer(answer:"I’m touching someone I love frequently to express our friendship.", type: .physicalTouch))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "someone I love helps me out - especially if I know they’re already busy.", type: .actsOfService), answerB: QuizAnswer(answer:"I hear someone I love tell me that they appreciate me.", type: .wordsOfAffirmation))
    userInfo.QuizQuestions.append(temp)
    
    temp = QuizQuestion(answerA: QuizAnswer(answer: "I get a hug from someone whom I haven’t seen in a while.", type: .physicalTouch), answerB: QuizAnswer(answer: "I hear someone I love tell me how much I mean to him/her.", type: .wordsOfAffirmation))
    userInfo.QuizQuestions.append(temp)
}

func calcScore(userInfo: UserInfo) {
    for i in 0...Constants().MAX_INDEX {
        let type = userInfo.QuizAnswers[i]!.type
        userInfo.QuizScore.addPoint(answerType: type, userInfo: userInfo)
    }
    userInfo.QuizScore.favoriteLanguage = findMaximum(userInfo: userInfo)
    userInfo.QuizScore.favoritePercentage = Float(getScorePercentage(score: userInfo.QuizScore.favoriteScore, maxCount: userInfo.QuizScore.favoriteLanguage!.maxCount))
    userInfo.QuizScore.saveUserData(userScore: userInfo.QuizScore)
}

func findMaximum(userInfo: UserInfo) -> languages {
    let words = userInfo.QuizScore.wordsOfAffirmation
    let gifts = userInfo.QuizScore.receivingGifts
    let acts = userInfo.QuizScore.actsOfService
    let time = userInfo.QuizScore.qualityTime
    let touch = userInfo.QuizScore.physicalTouch
    
    var temp = words/languages.wordsOfAffirmation.maxCount
    var type = languages.wordsOfAffirmation
    
    if(temp < gifts/languages.wordsOfAffirmation.maxCount) {
        temp = gifts/languages.wordsOfAffirmation.maxCount
        type = languages.receivingGifts
    }
    
    if(temp < acts/languages.actsOfService.maxCount) {
        temp = acts/languages.actsOfService.maxCount
        type = languages.actsOfService
    }
    
    if(temp < time/languages.qualityTime.maxCount) {
        temp = time/languages.qualityTime.maxCount
        type = languages.qualityTime
    }
    
    if(temp < touch/languages.physicalTouch.maxCount) {
        temp = temp/languages.physicalTouch.maxCount
        type = languages.physicalTouch
    }
    
    return type
}

#Preview {
    LoveLanguageQuizView(userInfo: UserInfo(), isShowingQuiz: .constant(true))
}
