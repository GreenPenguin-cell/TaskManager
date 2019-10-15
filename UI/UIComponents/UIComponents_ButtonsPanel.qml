import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Rectangle
{




    //Размеры элементов
    property int p_element_heigth: height
    property int  p_element_width: parent.width/p_elements_count
    property  int p_elements_count: 4

    //Для контроля выделенных элементов
    property int current_index: 0
    signal s_current_change

    //Заголовок
    property string p_header: ""
    property bool p_has_header: false

    id:rec_main
    width: p_element_width +30
    height: 2
    color:p_background_color
    border.color: p_border_color
    border.width: 2

    ListModel
    {
        id:p_model
        property string p_param
        property int p_id
        ListElement
        {
            text:"Сыл"
            p_param:"but_add"
            p_id:4
        }
        ListElement
        {
            text:"Добавить"
            p_param:"but_add"
            p_id:3
        }
        ListElement
        {
            text:"Изменить"
            p_param:"but_change"
            p_id:2
        }
        ListElement
        {
            text:"Удалить"
            p_param:"but_del"
            p_id:1
        }


    }


    Repeater
    {
        id:radioButs_rep
        model:p_model
        delegate: UICOmponents_Button
        {
            width:p_element_width
            height:p_element_heigth
            x:parent.width-(parent.width/p_elements_count)*model.p_id//model.p_x
            y:0
            text:model.text
            p_slot_param:model.p_param
            onS_triggered:
            {
                s_but_panel_click(p_slot_param)
            }

        }
    }


    function f_calc_x_koord()
    {

    }

    function f_element_add(arg_text, arg_but_param)//, arg_alias_text)
    {


        p_elements_count += 1

        p_model.append({p_id:p_elements_count, text:arg_text, p_param:arg_but_param})


    }









}
