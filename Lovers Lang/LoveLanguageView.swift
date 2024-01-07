//
//  LoveLanguageView.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 1/2/24.
//

import SwiftUI

struct LoveLanguageView: View {
    @State private var isShowingQuiz = false
    @State var favoriteLanguage: languages?
    @State var favoritePercentage: Float?
    @ObservedObject var userInfo: UserInfo
    let const = Constants()
    
    var body: some View {
        NavigationStack {
            if userInfo.QuizScore.favoriteLanguage == nil {
                VStack {
                    Text("It looks like you haven't taken the Love Language Quiz yet. Take it now to find out your Love Language!").padding().frame(width: const.SCREEN_WIDTH * 0.9, alignment: .center)
                    Button(action: {
                        isShowingQuiz.toggle()
                    }, label: {
                        Text("Take Quiz")
                    })
                    .padding()
                    .frame(width: const.SCREEN_WIDTH * 0.8)
                    .background(Color("Text"))
                    .clipShape(.capsule)
                    .foregroundColor(Color("Background"))
                    .accessibilityIdentifier("takeQuizButton")
                }.onAppear {
                    prepareQuestions(userInfo: userInfo)
                }.navigationDestination(isPresented: $isShowingQuiz) {
                    LoveLanguageQuizView(userInfo: userInfo, isShowingQuiz: $isShowingQuiz)
                }
            } else {
                VStack{
                    HStack {
                        Text(languages.actsOfService.name).frame(width: 200, alignment: .leading)
                        LoveLanguageBar(loveLanguage: languages.actsOfService, score: userInfo.QuizScore.actsOfService).frame(width: const.LOVE_LANG_BAR_WIDTH, alignment: .bottomLeading)
                    }
                    HStack {
                        Text(languages.physicalTouch.name).frame(width: 200, alignment: .leading)
                        LoveLanguageBar(loveLanguage: languages.physicalTouch, score: userInfo.QuizScore.physicalTouch).frame(width: const.LOVE_LANG_BAR_WIDTH, alignment: .leading)
                    }
                    HStack {
                        Text(languages.qualityTime.name).frame(width: 200, alignment: .leading)
                        LoveLanguageBar(loveLanguage: languages.qualityTime, score: userInfo.QuizScore.qualityTime).frame(width: const.LOVE_LANG_BAR_WIDTH, alignment: .leading)
                    }
                    HStack {
                        Text(languages.receivingGifts.name).frame(width: 200, alignment: .leading)
                        LoveLanguageBar(loveLanguage: languages.receivingGifts, score: userInfo.QuizScore.receivingGifts).frame(width: const.LOVE_LANG_BAR_WIDTH, alignment: .leading)
                    }
                    HStack {
                        Text(languages.wordsOfAffirmation.name).frame(width: 200, alignment: .leading)
                        LoveLanguageBar(loveLanguage: languages.wordsOfAffirmation, score: userInfo.QuizScore.wordsOfAffirmation).frame(width: const.LOVE_LANG_BAR_WIDTH, alignment: .leading)
                    }
                    Text(verbatim: "Based on your test results, your most preferred love language is \(userInfo.QuizScore.favoriteLanguage?.name ?? "unknown") with a percentage of \(userInfo.QuizScore.favoritePercentage)%").frame(width: Constants().SCREEN_WIDTH * 0.8, height: Constants().SCREEN_HEIGHT * 0.2).accessibilityIdentifier("userSummary")
                }.padding().accessibilityIdentifier("languagesChart")
            }
        }.onAppear{
            print("userInfo.QuizScore: \(userInfo.QuizScore)")
            if let _ = userInfo.QuizScore.favoriteLanguage {
                let temp = userInfo.QuizScore.fetchFavorite(userInfo: userInfo)
                favoriteLanguage = temp.favoriteLanguage
                favoritePercentage = temp.favoritePercentage
                favoritePercentage = round(favoritePercentage! * 100)
            }
        }
    }
}

struct LoveLanguageBar: View {
    let const = Constants()
    let loveLanguage: languages
    let score: Int
    @State var scorePercentage: CGFloat?
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule().frame(width: const.LOVE_LANG_BAR_WIDTH, height: const.LOVE_LANG_BAR_HEIGHT).foregroundStyle(Color.gray).opacity(0.5)
            Capsule().frame(width: getScorePercentageCG(score: score, maxCount: loveLanguage.maxCount) * const.LOVE_LANG_BAR_WIDTH, height: const.LOVE_LANG_BAR_HEIGHT).foregroundStyle(loveLanguage.backgroundColor)
        }.frame(width: const.LOVE_LANG_BAR_WIDTH)
    }
}

func getScorePercentageCG(score: Int, maxCount: Int) -> CGFloat {
    let scoreFloat = Float(score)
    let maxCountFloat = Float(maxCount)
    return CGFloat(scoreFloat/maxCountFloat)
}

func getScorePercentage(score: Int, maxCount: Int) -> Float {
    let scoreFloat = Float(score)
    let maxCountFloat = Float(maxCount)
    return Float(scoreFloat/maxCountFloat)
}



struct LoveLanguage {
    var name: String
    var color: Color
}

#Preview {
    LoveLanguageView(userInfo: UserInfo())
}
