//
//  ContentView.swift
//  listeDeTaches
//
//  Created by Philippe MICHEL on 28/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var montrerAlerte:Bool = false
    
    @ObservedObject var vuListeModel: ListeTacheUserDefaultModel

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("textField", text: $text)
                        Button(action: {
                                // rentre le clavier 
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                verifSaisie()
                        }, label: {
                                    Image(systemName: Ressouces.images.ajouter.rawValue)
                        })
                            .alert(isPresented: $montrerAlerte, content: {
                                Alert(title: Text("alert"))
                            })
                    }
                }
                // affiche le bouton la liste de tâche contient au moins un élément.
                if vuListeModel.items.count > 0 {
                    Section {
                        HStack(alignment:.center) {
                            Button(action: {
                                vuListeModel.tacheToutSupprimer()
                                
                            }, label: {
                                Text("button")
                            })
                            .padding(3)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        }
                        
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
    
    //verification de la saisie
    func verifSaisie() {
        if text == "" {
            montrerAlerte = true
            
        } else {
            vuListeModel.ajouterTache(string: text)
            montrerAlerte = false
            text = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( vuListeModel: ListeTacheUserDefaultModel())
    }
}

