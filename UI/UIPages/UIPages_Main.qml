import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    id:main

    property QtObject dataModel: undefined

    //Сигнал поступающий с кнопок панелей
    /*
      but_add - такой параметр должен приходить с кнопки добавить
      but_change - с изменить
      but_del - с удалить
      but_cat - категория
      but_prior - приоретет
      but_settings - настройки

      */
    signal s_but_panel_click(string arg_but_param)
    Connections
    {
        target: main
        onS_but_panel_click:
        {
            if(arg_but_param=="but_add")
               dataModel.add("Commnad", "Alias Command")
            if(arg_but_param=="but_del")
               dataModel.removeRow(data_view.f_get_current_index(), dataModel)
            if(arg_but_param=="but_change")
                dataModel.change(data_view.f_get_current_index(), "new Command", "new Alias")
        }
    }



//    UICOmponents_Button
//    {
//        id:but_add
//        x:549
//        y:37
//        text:"Добавить"
//        onS_triggered:
//        {
//            dataModel.add("Commnad", "Alias Command")

//        }
//    }

//    Button
//    {
//        id:but_change
//        x:549
//        y:97
//        text:"Изменить"
//        onClicked:
//        {
//            dataModel.change(view.currentIndex, "new Command", "new Alias")
//        }
//    }
//    Button
//    {
//        id:but_remove
//        x: 555
//        y: 157
//        text: "Удалить"
//        onClicked:
//        {
//            dataModel.removeRow(view.currentIndex, dataModel)
//        }
//    }


    UIComponents_ButtonsPanel
    {
        id:upper_panel
        x:0
        y:0
        width: parent.width
        height: parent.height/10
        p_elements_count: 4
        Component.onCompleted:
        {
//            f_element_add("Добавить", "but_add")
//            f_element_add("Удалить", "but_del")
//            f_element_add("Изменить", "but_change")
//            f_element_add("Пизда", "but_cat")
        }
    }

    UIComponents_ListViewTable
    {
        id:data_view

        x:0
        y:upper_panel.height
        width: parent.width
        height: parent.height/1.5
        dataSourse: dataModel
        Component.onCompleted:
        {
            data_view.f_column_add("Задача")
            data_view.f_column_add("Время дедлайна")
            data_view.f_column_add("Дата дедлайна")
        }

    }

}
