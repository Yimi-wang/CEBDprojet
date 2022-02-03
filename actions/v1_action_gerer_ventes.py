import sqlite3
from utils import display
from PyQt5.QtWidgets import QDialog
from PyQt5.QtCore import pyqtSlot
from PyQt5 import uic

class Ajouter_Reservation(QDialog):

    # Constructeur
    def __init__(self, data:sqlite3.Connection):
        super(QDialog, self).__init__()
        self.ui = uic.loadUi("gui/par3_2.ui", self)
        self.data = data


    # Fonction de mise à jour de l'affichage
    @pyqtSlot()
    def ajouter(self):
        try:
            cursor = self.data.cursor()
            cursor.execute(
                "INSERT INTO LesVentes VALUES (?, ?, ?, ?, ?);",
                [self.ui.L_noPlace.text().strip(), self.ui.L_noRang.text().strip(),
                 self.ui.L_dateRep.text().strip(), self.ui.L_noDos.text().strip(),
                 self.ui.L_catR.text().strip()])
        except Exception as e:
            self.ui.table_fct_comp_1.setRowCount(0)
            display.refreshLabel(self.ui.text, "Impossible d'ajouter les donnee : " + repr(e))
        else:
            display.refreshLabel(self.ui.text, "Ajouter les donnee succee")

    def delete(self):
        try:
            cursor = self.data.cursor()
            cursor.execute(
                "DELETE FROM LesVentes where noPlace = ? AND noRang = ? AND dateRep = ? AND noDos = ? AND catR = ?;",
                [self.ui.L_noPlace.text().strip(), self.ui.L_noRang.text().strip(),
                 self.ui.L_dateRep.text().strip(), self.ui.L_noDos.text().strip(),
                 self.ui.L_catR.text().strip()])
        except Exception as e:
            display.refreshLabel(self.ui.text, "Impossible de delete les donnee : " + repr(e))
        else:
            display.refreshLabel(self.ui.text, "Delete les donnee succee")



