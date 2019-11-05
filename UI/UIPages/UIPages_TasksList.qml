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

    Rectangle
    {
        id:instr_panel
        x:0
        y:0//upper_panel.height
        width: parent.width
        height: parent.height/20
        border.width: 1
        color :"#b8c3b9"
        border.color: "#5b765d"
        UICOmponents_Button
        {
            id:but_save
            x:0
            y:0
            radius: 20
            width: (parent.width-str_find.width)/2
            height: parent.height
            text: "S"
            onS_triggered:
            {
                dataModel.f_save_data()
            }
        }
        UICOmponents_Button
        {
            id:but_clear
            x:but_save.width+str_find.width
            y:0
            radius: 20
            width: (parent.width-str_find.width)/2
            height: parent.height
            text: "F"
            onS_triggered:
            {
//                test_snd.play()
//                console.log(test_snd.errorString)
            }
        }
//        Text {
//            id: time_out
//            x:parent.width-width-10
//            y:0
//            width: parent.width/6
//            height: parent.height
//            font.pixelSize: parent.height/2
//            text: qsTr("00:00:00")
//        }
        UIComponents_InputWindow
        {
            id:str_find
            x:but_save.width
            y:0
            width: parent.width/1.5//-but_clear.width*2
            height: parent.height
            p_text: "<Поиск>"
            p_pixel_size: time_out.font.pixelSize
        }

    }

//    Connections
//    {
//        target: task_timer
//        onS_time_send:
//        {
//            time_out.text=arg_time
//        }
//    }
    UIComponents_ListViewTable
    {
        id:data_view

        x:0
        y:instr_panel.height
        width: parent.width
        height: parent.height-instr_panel.height
        dataSourse: dataModel
        p_element_height: parent.height/5
        p_element_width: width
        Component.onCompleted:
        {
            data_view.f_column_add("Задача")
            data_view.f_column_add("Время дедлайна")
            data_view.f_column_add("Дата дедлайна")
        }

    }

}
