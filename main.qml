import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import dataModel 1.0
import "UI"
//import "UI/UIPages"
//import TaskModel 1.0

Window {
    //Главное окно
    //Тут мы загружаем сразу главную страницу, основная работа на ней
    //Здесь будут обьявлены сигналы и переменные, которые должны быть видимы всем компонентам
    id:mainwindow

    //Обьявляем основную модель, которая сделана как плагин
    TaskModel
    {
        id:dataModel
    }



    //Этот сигнал используется для перенаправления. Когда с ListViewTable приходит сигнал клика
    //На элемент, страница _TasksList реагирует на него, отправляя этот сигнал
    //А главная страница уже перехватывает его
    signal s_task_click(int id)
    //Сигнал вызывается из страницы добавления при отменене
    signal s_task_addClose()


    visible: true
    width: 800
    height: 700

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


