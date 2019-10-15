import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Rectangle
{
    //Расцветка
    property string p_background_color: "white"
    property string p_border_color: "black"

    //Размеры элементов
    property int p_element_heigth: 20
    property int  p_element_width: 90

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
        property int y: 0
        property int x: 0


    }
    Text {
        id: header
        text: qsTr(p_header)
        visible: p_has_header
        x:0
        y:-header.height
        width: contentWidth
        height: contentHeight
    }
    onS_current_change:
    {
        if(current_index !=-1)
            radioButs_rep.itemAt(current_index).checked = false
        var is_check = false
        for(var i =0;i<radioButs_rep.count;i++)
        {
            if(radioButs_rep.itemAt(i).checked)
            {
                current_index = i
                is_check = true

            }
        }
        if(!is_check)
            current_index =-1
    }

    Repeater
    {
        id:radioButs_rep
        model:p_model
        Component.onCompleted:
        {
            s_current_change()
        }

        delegate: RadioButton
        {
            width:p_element_width
            height:p_element_heigth
            x:model.x
            y:model.y
            text:model.text
            checked:false
            onCheckedChanged:
            {
                s_current_change()
            }

        }
    }
    function f_get_current_element_text()
    {
        if(current_index!= -1)
        {
            var str = radioButs_rep.itemAt(current_index).text
            return radioButs_rep.itemAt(current_index).text
        }
        return("Invalid current index")
    }

    function f_element_add(arg_text)//, arg_alias_text)
    {
        rec_main.height +=p_element_heigth

        p_model.append({x:2,y:rec_main.height-p_element_heigth, text:arg_text})
    }









}
