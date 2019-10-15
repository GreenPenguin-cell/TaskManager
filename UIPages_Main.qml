import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Item {

    property QtObject dataModel: undefined
//    title: qsTr("Диспетчер задач")
    Button
    {
        id:but_add
        x:549
        y:37
        text:"Добавить"
        onClicked:
        {
            dataModel.add("Commnad", "Alias Command")
        }
    }
    Button
    {
        id:but_change
        x:549
        y:97
        text:"Изменить"
        onClicked:
        {
            dataModel.change(view.currentIndex, "new Command", "new Alias")
        }
    }
    Button
    {
        id:but_remove
        x: 555
        y: 157
        text: "Удалить"
        onClicked:
        {
            dataModel.removeRow(view.currentIndex, dataModel)
        }
    }
    UIComponents_ListViewTable
    {
        id:data_view

        dataSourse: dataModel
        Component.onCompleted:
        {
            data_view.f_column_add("Задача")
            data_view.f_column_add("Время дедлайна")
            data_view.f_column_add("Дата дедлайна")
        }

    }

}
