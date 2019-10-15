import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import dataModel 1.0
import "UI"
//import "UI/UIPages"
//import TaskModel 1.0

Window {

    //Обьявляем модель, которая сделана как плагин
    TaskModel
    {
        id:dataModel
    }



    //Сигнал поступающий с кнопок панелей
    signal s_but_panel_click(string arg_but_param)


    id:mainWindow
    visible: true
    width: 800
    height: 700
    //Для стартовой страницы сойдет и так загружать
    //Впринципе, тут можно больше особо ничего не писать
    Loader
    {
        id:load_main
        anchors.fill: parent
        Component.onCompleted:
        {
            setSource("UI/UIPages/UIPages_Main.qml", {dataModel:dataModel})
        }
    }

}


