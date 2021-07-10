//
//  ContentView.swift
//  listeDeTaches
//
//  Created by Philippe MICHEL on 28/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @ObservedObject var vuListeModel: ListeTacheUserDefaultModel

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("textField", text: $text)
                        Button(action: {
                                vuListeModel.ajouterTache(string: text)                     }, label: {
                                    Image(systemName: Ressouces.images.ajouter.rawValue)
                        })
                    }
                }
                Section(header: Text("section")) {
                    List {
                        ForEach(vuListeModel.items) { tache in
                            HStack {
                                Text(tache.nom)
                                Spacer(minLength: 20)
                                Button(action: {
                                    vuListeModel.miseAjourTache(tache: tache)
                                }, label: {
                                    self.changementStatutTacheImage(statutDeTache: tache.statut)
                                })
                            }
                        }
                        .onDelete(perform: { indexSet in
                            vuListeModel.supprimerTache(index: indexSet)
                        })
                    }
                }
            }
            .navigationTitle(Text("title"))
        }
    }
    
    // changement du logo sur changement de statut de la tâche
    func changementStatutTacheImage(statutDeTache: Bool) -> some View {
        let systemeName = statutDeTache ? Ressouces.images.tacheEffectuer.rawValue : Ressouces.images.tacheNonEffectuer.rawValue
        let color: Color = statutDeTache ? .green : .red
        return Image(systemName: systemeName).foregroundColor(color)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( vuListeModel: ListeTacheUserDefaultModel())
    }
}
