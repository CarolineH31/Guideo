//
//  DashboardView.swift
//  FinalGuideo
//
//  Created by Apprenant 81 on 08/02/2022.
//
import PhotosUI
import SwiftUI


struct DashboardView: View {
    
    @State private var userName: String = ""
    @State private var showingAlert = true
    @State private var showingAlertResults = false
    @State private var backgroundOpacity = true
    
    @State private var showingQuizzAlert = false
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var customBlue = Color("primaryBlue")
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack{
                    ZStack {
                        
                        Rectangle()
                            .frame(height: 190)
                            .edgesIgnoringSafeArea(.all)
                            .foregroundColor(Color("primaryBlue"))
                        
                        
                        ZStack(alignment: .bottomTrailing) {
                            Image(uiImage: self.image)
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: 130)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                            
                            
                            Button() {
                                
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 32)
                                    .background(Color("primaryBlue"))
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .onTapGesture {
                                        showSheet = true
                                    }
                            }
                            
                            .sheet(isPresented: $showSheet) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                            }
                            
                        }.zIndex(1)
                    }
                
                    VStack{
                        
                        Text("Bienvenue")
                            .foregroundColor(customBlue)
                        
                        Button() {
                            withAnimation {
                                self.showingAlert.toggle()
                                backgroundOpacity.toggle()
                            }
                            self.userName = ""
                        } label: {
                            Text("\(userName == "" ? "Utilisateur" : userName)")
                                .foregroundColor(Color("primaryBlue"))
                                .font(userName.count <= 7 ? .largeTitle : .title)
                                .fontWeight(.heavy)
                        }
                    }.padding(.bottom, 30)
                    
                    
                    
                    Button() {
                        showingQuizzAlert = true
                    } label: {
                        Text("Lancer Quizz")
                            .font(.body)
                            .padding(.horizontal, 127.0)
                            .padding(.vertical, 14.0)
                            .background(.orange)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        
                    }
                    
                    
                    
                    Button() {
                        withAnimation {
                            self.showingAlertResults.toggle()
                            backgroundOpacity.toggle()
                        }
                    } label: {
                        Text("Mes résultats du quizz")
                            .font(.body)
                            .padding(.horizontal, 90.0)
                            .padding(.vertical, 12.0)
                            .foregroundColor(.orange)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                    }
                    
                    .alert(isPresented:$showingQuizzAlert) {
                        Alert(
                            title: Text("Est-tu sûr de vouloir lancer un Quizz ?"),
                            message: Text("Cette action supprimera définitivement tes résultats actuels."),
                            primaryButton: .destructive(Text("Annuler")) {
                                print("Deleting...")
                            }, secondaryButton: .default(Text("Lancer Quizz")){
                                viewRouter.currentPage = .pageQuizz
                            }
                            
                        )
                    }
                    
                    
                    Picker(selection: .constant(1), label: Text("Picker")) {
                        Text("Mes métiers").tag(1)
                        Text("Mes formations").tag(2)
                    }.pickerStyle(SegmentedPickerStyle())
                        .colorMultiply(customBlue)
                        .padding()
                    
                    
                    Spacer()
                    
                }
                
                .navigationBarTitle(Text("Tableau de bord"), displayMode: .inline)
                .blur(radius: backgroundOpacity ? 25 : 0)
                
                ZStack {
                    CustomAlert(textEntered: $userName, showingAlert: $showingAlert, backgroundOpacity: $backgroundOpacity)
                        .opacity(showingAlert ? 1 : 0)
                }.transition(.scale)
                ZStack {
                    CustomAlertResults(showingAlertResults: $showingAlertResults, backgroundOpacity: $backgroundOpacity)
                        .opacity(showingAlertResults ? 1 : 0)
                }.transition(.scale)
                
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
