
import sqlite3
from utils import display
from PyQt5.QtWidgets import QDialog
from PyQt5.QtCore import pyqtSlot
from PyQt5 import uic
class AppFctPar2_1(QDialog):
    # Constructeur
    def __init__(self, data:sqlite3.Connection):
        super(QDialog, self).__init__()
        self.ui = uic.loadUi("gui/fct_2_1.ui", self)
        self.data = data

        # On met à jour l'affichage avec les données actuellement présentes dans la base
        self.refreshPartie2_1()

    ####################################################################################################################
    # Méthodes permettant de rafraichir les différentes tables
    ####################################################################################################################

    # Fonction de mise à jour de l'affichage d'une seule table
    def refreshTable(self, label, table, query):
        display.refreshLabel(label, "")
        try:
            cursor = self.data.cursor()
            result = cursor.execute(query)
        except Exception as e:
            table.setRowCount(0)
            display.refreshLabel(label, "Impossible d'afficher les données de la table : " + repr(e))
        else:
            display.refreshGenericData(table, result)

    # Fonction permettant de mettre à jour toutes les tables
    @pyqtSlot()
    def refreshPartie2_1(self):

        self.refreshTable(self.ui.label_fct_partie_2_1, self.ui.table_fct_partie_2_1,
                          "WITH NonRes AS (" 
                          "SELECT dateRep "
                          "FROM LesRepresentations "
                          "EXCEPT "
                          "SELECT dateRep "
                          "FROM LesVentes) "
                          "SELECT noSpec, nomSpec, dateRep "
                          "FROM NonRes "
                          "JOIN LesRepresentations "
                          "USING (dateRep) "
                          "JOIN LesSpectacles "
                          "USING (noSpec)")
