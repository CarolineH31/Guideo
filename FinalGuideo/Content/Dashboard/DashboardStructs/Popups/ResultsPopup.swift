//
//  ResultsPopup.swift
//  FinalGuideo
//
//  Created by Apprenant 81 on 08/02/2022.
//

import SwiftUI

struct CustomAlertResults: View {
    @Binding var showingAlertResults: Bool
    @Binding var backgroundOpacity: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.orange)
            
            VStack {
                
                Spacer()
                
                Text("Résultats Quizz")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("Ici catégories de métiers.")
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    Button("Accepter") {
                        self.showingAlertResults.toggle()
                        self.backgroundOpacity.toggle()
                    }
                }
                .padding(30)
                .padding(.horizontal, 40)
                .foregroundColor(.white)
                
            }
        }
        .frame(width: 300, height: 400)
        
    }
}
