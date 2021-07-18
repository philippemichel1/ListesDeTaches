//
//  VueTacheListeModel.swift
//  listeDeTaches
//
//  Created by Philippe MICHEL on 03/07/2021.
//

import SwiftUI
class VueTacheListeModel: ObservableObject {
    @Published var items:[Tache] = []
    var mesTaches:[String] =  ["Ménage", "Courses", "Classer les papier", "Faire les Devoirs", "Aller boire un pot en terrasse", "aller à la piscine"]
    
    //initialisation des proprietes
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
        
    }
    
    //supprimer toutes les taches
    func tacheToutSupprimer() {
        items.removeAll()
    }
}
