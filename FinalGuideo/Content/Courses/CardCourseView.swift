//
//  CardCourseView.swift
//  FinalGuideo
//
//  Created by Apprenant 81 on 08/02/2022.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let img: Image
}

struct CardCourseView: View {
    @State private var isButtonClicked: Bool = false
    @StateObject private var viewModel = StructsMap()
    // On définit les coordonnées des lieux de formation, forum etc
    let locations = allCourseDescription
        
          var image: String
          var title: String
          var titleLoc: String
          var description: String
          var like: Bool
          var tel: String
          var mail: String
          var website: String
          var longitude: Double
          var latitude: Double
    
    var body: some View {
        VStack{
            ScrollView {
                Image("avion_img")
                    .resizable()
                    .frame(width: 323.0, height: 149.0)
                    .padding()
                
                HStack {
                    Text(titleLoc)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    
                    Button(action: {
                        isButtonClicked.toggle()
                    }) {
                        isButtonClicked ? Image(systemName: "bookmark.fill").foregroundColor(.red).font(.system(size: 30)) : Image(systemName: "bookmark").foregroundColor(.red).font(.system(size: 30))
                    }.frame(width: 120, height: 50)
                }
                
                Text(description)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 15.0)
                
                Text("Contacts")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .frame(height: 30)
                    .foregroundColor(Color("categoryBlue"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                FormationInfoView(numero: tel, site: website)
                
                Text("Carte")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .frame(height: 30)
                    .foregroundColor(Color("categoryBlue"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Map(coordinateRegion: $viewModel.mapRegionSave, showsUserLocation: true, annotationItems: locations) {location in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.longitude, longitude: location.latitude)){
                    VStack{
                        Image("formation_img")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        Text(location.titleLoc)
                    }
                }}
                .frame(width: 350, height: 250, alignment: .center)
                .cornerRadius(15)
                .onAppear{viewModel.checkIfLocationServicesIsEnabled()}
                .padding(.bottom, 100.0)
            }
        }
    }
}


struct FormationInfoView: View {
    
    let numero : String
    let site : String
    
    
    var body: some View {
        VStack{
            Text(numero)
                .font(.system(size: 22))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(site)
                .font(.system(size: 22))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 200, height: 20)
        .foregroundColor(.orange)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
        
    }
}

struct CardCourseView_Previews: PreviewProvider {
    static var previews: some View {
        CardCourseView(image : "", title : "", titleLoc : "titleLoc", description : "description", like: false, tel : "0678908788", mail : "", website : "www.test.com", longitude : 0.0, latitude : 0.0)
    }
}
