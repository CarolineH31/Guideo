//
//  OnboardingView.swift
//  FinalGuideo
//
//  Created by Apprenant 81 on 08/02/2022.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            Color("primaryBlue")
                .ignoresSafeArea()
            VStack{
                Spacer(minLength: 50)
                VStack{
                    
                    TitleView()
                }
                VStack{
                    Spacer()
                    ImageView()
                }
                VStack{
                    Spacer()
                    TextOnboardingView()
                    Spacer()
                }
                VStack{
                    Button(action: {
                        viewRouter.currentPage = .pageQuizz
                    }) {
                        StartButtonView(text: "C'est parti!")
                    }
                }
                VStack{
                    Button(action: {
                        viewRouter.currentPage = .pageDashboard
                    }) {
                        SkipButtonView()
                    }
                }
            }.padding(.horizontal, 40.0)
            
        }.foregroundColor(.white)
            .multilineTextAlignment(.center)
            .environmentObject(ViewRouter())
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

