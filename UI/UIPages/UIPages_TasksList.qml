import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    id:list_page
    property  QtObject dataModel: undefined
    //signal s_task_click(int id)
    Connections
    {
        target: data_view
        onS_model_element_click:
        {
           s_task_click(id)
        }
    }

    UIComponents_ListViewTable
    {
        id:data_view

        x:0
        y:upper_panel.height
        width: parent.width
        height: parent.height-upper_panel.height
        dataSourse: dataModel
        p_element_height: parent.height/5
        p_element_width: parent.width
        Component.onCompleted:
        {
            data_view.f_column_add("Задача")
            data_view.f_column_add("Время дедлайна")
            data_view.f_column_add("Дата дедлайна")
        }

    }

}
