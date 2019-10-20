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
        UICOmponents_Button
        {
            id:but_save
            width: parent.width/2
            height: parent.height/15
            x:0
            y:parent.height-height
            text: "Сохранить"
            onS_triggered: f_save()
        }
        UICOmponents_Button
        {
            id:but_cancel
            width: parent.width/2
            height: parent.height/15
            x:parent.width/2
            y:parent.height-height
            text: "Отмена"
            onS_triggered: f_cancel()
        }
        UIComponents_InputWindow
        {
            id:txt_name
            x:parent.width/20
            y:parent.height/10
            width: parent.width/1.3
            height: parent.height/15
            has_header: true
            header_text: "Название задачи"
            binding_object: dataModel
            binding_prop_name: "p_ChangedValues_Name"
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
            binding_object: dataModel
            binding_prop_name: "p_ChangedValues_Discr"

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
        Binding
        {
            target: dataModel
            property: "p_ChangedValues_Categ_Id"
            value: categ_list.currentIndex
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
            binding_object: dataModel
            binding_prop_name: "p_ChangedValues_Time"
        }
        UIComponents_InputWindow
        {
            id:txt_date
            x:parent.width/20
            y:parent.height/1.5
            width: parent.width/1.3
            height: parent.height/15
            has_header: true
            is_multiline: false
            header_text: "Дата дедлайна"
            binding_object: dataModel
            binding_prop_name: "p_ChangedValues_Date"
        }



    }
    function f_save()
    {
        dataModel.f_add_changed_values(p_changed_task_id)
        s_task_addClose()
    }
    function f_cancel()
    {
       dataModel.f_clear_changed_values()
       s_task_addClose()
    }
    function f_fill_fields()
    {
        if(p_changed_task_id!=-1)
        {
            txt_name.p_text = dataModel.p_ChangedValues_Name
            txt_discr.p_text=dataModel.p_ChangedValues_Discr
            txt_time.p_text=dataModel.p_ChangedValues_Time
            txt_date.p_text=dataModel.p_ChangedValues_Date
            categ_list.currentIndex=dataModel.p_ChangedValues_Categ_Id
        }
    }

    Component.onCompleted:
    {
        dataModel.f_set_changed_values(p_changed_task_id)
        f_fill_fields()
    }

}
