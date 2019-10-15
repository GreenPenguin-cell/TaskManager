import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import dataModel 1.0
//import TaskModel 1.0

Window {

    //Обьявляем модель, которая сделана как плагин
    TaskModel
    {
        id:dataModel
    }
    //Обьявляем главную страницу
    UIPages_Main
    {
        id:main_page
    }

    id:mainWindow
    visible: true
    width: 800
    height: 700
   Loader
   {
       id:load_main
       anchors.fill: parent
       sourceComponent: main_page
   }

}


