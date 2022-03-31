//
//  MapView.swift
//  FinalGuideo
//
//  Created by Apprenant 81 on 09/02/2022.
//

import MapKit
import SwiftUI


extension Map {
    func mapStyle(_ mapType: MKMapType) -> some View {
        MKMapView.appearance().mapType = mapType
        return self
    }
}

struct MapView: View {
    @State private var searchText = ""
    let names = ["ENAC", "ENAC2", "INAC", "ENOC", "ENAAAC", "INAAC"]
    @StateObject private var viewModel = StructsMap()

    // On définit les coordonnées des lieux de formation, forum etc
//    let locations = [
//        Location(name: "Simplon", coordinate: CLLocationCoordinate2D(latitude: 48.8543116218374, longitude: 2.4366172071529926), img: Image("formation_img")),
//        Location(name: "ENAC", coordinate: CLLocationCoordinate2D(latitude: 48.85396843363726, longitude: 2.4319144219330724), img: Image("formation_img"))]
    
    // On fait apparaitre la carte via Map, on met nos coordonnées dans coordinateRegion
    // on boucle sur la liste locations pour faire apparaitre toutes les annotationsItems (pose un point sur la carte)
    let locations = allCourseDescription
    var body: some View {
        NavigationView {
            ZStack{
                
                ///map
                Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: locations) { location in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.longitude, longitude: location.latitude)){
                    
                    VStack{
                        NavigationLink(destination: CardCourseView(image : allCourseDescription[12].image, title : allCourseDescription[12].title, titleLoc : allCourseDescription[12].titleLoc, description : allCourseDescription[12].description, like: allCourseDescription[12].like, tel : allCourseDescription[12].tel, mail : allCourseDescription[12].mail, website : allCourseDescription[12].website, longitude : allCourseDescription[12].latitude, latitude : allCourseDescription[12].longitude)) {
                            Image("formation_img")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                            
                        }
                        Text(location.titleLoc)
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }}
                //.mapStyle(.hybrid)
                .ignoresSafeArea(.all, edges: .all)
                .onAppear{viewModel.checkIfLocationServicesIsEnabled()}
                ///
            
                VStack{
                    
                    VStack(spacing:  0){
                        HStack{
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search", text: $searchText)
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                .colorScheme(.light)
                                
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .background(.cyan)
                        .cornerRadius(25)
                        
                        // Displaying results
                        
                        if searchText != ""{
                            ScrollView{
                                VStack(spacing: 15)
                                {
                                    ForEach(searchResults, id: \.self) { result in
                                        Text("\(result)")
                                            .searchCompletion(result)
                                            .foregroundColor(.black)
                                            .padding(10)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .onTapGesture {
                                                viewModel.selectPlace(position: result)
                                                searchText = ""
                                            }
                                        Divider()
                                    }
                                }.padding(.top)
                            }
                            .background(Color.white)
                        }
                        
                    }.padding()
                    
                    Spacer()
                    Button(action: viewModel.updatePos, label: {
                            
                            Image(systemName: "location.fill")
                                .font(.title2)
                                .padding(10)
                                .background(Color.red)
                                .clipShape(Circle())
                        })
//                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(width: 350, height: 250, alignment: .trailing)
                    .padding()
                }
            }
///
    }
    }
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
