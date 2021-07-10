//
//  VueTacheListeModel.swift
//  listeDeTaches
//
//  Created by Philippe MICHEL on 03/07/2021.
//

import SwiftUI
class VueTacheListeModel: ObservableObject {
    @Published var items:[Tache] = []
    var mesTaches:[String] =  ["Ménage", "Courses", "Enfants école", "Devoirs", "Aller boire un verre en terrasse", "Aller au magasin de bricolage acheter du platre"]
    
    init() {
        items = mesTaches.map({ string in
            Tache(nom: string, statut: false)
        })
    }
    
    // mise de la tache de vrai à faux

    // mise à jour de la tache
    func miseAjourTache(tache: Tache) {
        guard let index = items.firstIndex(where: {$0.id == tache.id}) else { return }
        items[index].statut.toggle()
    }
    
    //ajoute une tache à la liste
    func ajouterTache(string: String) {
        guard string != "" else {return}
        items.append(Tache(nom: string, statut: false))
    }
    
    // supprime une tache de la liste
    func supprimerTache(index: IndexSet) {
        items.remove(atOffsets: index)
        sync()
    }
    
}
