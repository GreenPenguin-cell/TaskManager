import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    id:main
    property int p_changed_task_id: -1
    property QtObject dataModel: undefined
    property bool flag_data_correct: false


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
            onS_triggered: f_check_correct()//f_save()
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
        //        UIComponents_InputWindow
        //        {
        //            id:txt_time
        //            x:parent.width/20
        //            y:parent.height/1.8
        //            width: parent.width/1.3
        //            height: parent.height/15
        //            has_header: true
        //            header_text: "Время дедлайна"
        //            binding_object: dataModel
        //            binding_prop_name: "p_ChangedValues_Time"
        //        }
        UIComponents_TimeSelecter
        {
            id:txt_time
            x:parent.width/20
            y:parent.height/1.8
            width: parent.width/1.3
            height: parent.height/15
            binding_object:dataModel
            binding_property_name:"p_ChangedValues_Time"
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
    Connections
    {
        target: mainwindow
        onS_confirm_close:
        {
            if(arg_res)
            {
                if(arg_object_caller=="task_change")
                {
                    dataModel.f_add_changed_values(p_changed_task_id)
                    s_task_addClose()
                }

            }
        }
    }

    function f_save()
    {
        if(p_changed_task_id!=-1)
        {
            confim_wind.p_text = "Сохранить изменения задачи?"
            confim_wind.is_DS = false
            confim_wind.p_object_caller = "task_change"
            confim_wind.show()
        }
        else
        {
            dataModel.f_add_changed_values(p_changed_task_id)
            s_task_addClose()
        }

    }
    function f_check_correct()
    {
        if(txt_name.f_get_text()==='Fucking')
        {

            confim_wind.is_DS = true
            confim_wind.p_object_caller = "check_correct"
            confim_wind.p_text = "MIR IST KALT(("
            confim_wind.show()
            flag_data_correct=false
        }
        else
            flag_data_correct=true
        if(flag_data_correct)
            f_save()
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
            txt_time.f_set_time(dataModel.p_ChangedValues_Time)
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
