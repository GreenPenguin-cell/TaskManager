import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    id:main
    property int p_changed_task_id: -1
    property QtObject dataModel: undefined
    Rectangle
    {
        id:main_rec
        anchors.fill: parent
        color: "#e1e1b0"
        UIComponents_InputWindow
        {
            id:txt_name
            x:parent.width/20
            y:parent.height/10
            width: parent.width/1.3
            height: parent.height/15
            has_header: true
            header_text: "Название задачи"
        }
        UIComponents_InputWindow
        {
            id:txt_discr
            x:parent.width/20
            y:parent.height/10+txt_name.height*2
            width: parent.width/1.3
            height: parent.height/8
            has_header: true
            is_multiline: true
            header_text: "Описание задачи"
        }
        ComboBox
        {
            id:categ_list
            x:parent.width/20
            y:parent.height/10+txt_name.height*2+txt_discr.height*1.3
            width: parent.width/1.3
            height: parent.height/15
            model:dataModel.p_categs
            Label
            {
                x:0
                y:-contentHeight
                text: "Категория"
            }
        }
        //А вот для ввода даты и времени надо будет создать отдельные компоненты, текст временно
        UIComponents_InputWindow
        {
            id:txt_time
            x:parent.width/20
            y:parent.height/1.8
            width: parent.width/1.3
            height: parent.height/15
            has_header: true
            header_text: "Время дедлайна"
        }
        UIComponents_InputWindow
        {
            id:txt_date
            x:parent.width/20
            y:parent.height/1.5
            width: parent.width/1.3
            height: parent.height/15
            has_header: true
            is_multiline: true
            header_text: "Дата дедлайна"
        }
        UIComponents_ButtonsPanel
        {
            x:0
            y:parent.height-height
            width: parent.width
            height: parent.height/15
            p_elements_count: 2
            Component.onCompleted:
            {
                f_element_add("Сохранить", "but_save",2)
                f_element_add("Отмена", "but_cancel",1)
            }
        }
        Connections
        {
            //Вызыввается из главного окна сигналом-перенаправителем из
            //страницы со списком задач при клике на одну из них
            //arg_but_param
           target: mainwindow
           onS_task_click:
           {
              if(arg_but_param=="but_save")
                  f_save()
              if(arg_but_param=="but_cancel")
                  f_cancel()
           }
        }



        Binding
        {
            target:text1
            property: "text"
            value: dataModel.p_test[0]
        }

        Text {
            id: text1
            x: 288
            y: 395
            width: 118
            height: 23
            text: qsTr("Text")
            font.pixelSize: 12
        }
    }
    function f_save()
    {

    }
    function f_cancel()
    {

    }

    Component.onCompleted:
    {
        if(p_changed_task_id!=-1)
        {

        }

    }

}
