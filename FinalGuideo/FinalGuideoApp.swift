//
//  FinalGuideoApp.swift
//  FinalGuideo
//
//  Created by Apprenant 81 on 08/02/2022.
//

import SwiftUI

@main
struct FinalGuideoApp: App {
    @StateObject var viewRouteur = ViewRouter()
    var body: some Scene {
        WindowGroup {
            //QuizzView(quizzOption: allQuizz[0], categories: allCategories[0])
            MotherView()
                .environmentObject(ViewRouter())
        }
    }
}
