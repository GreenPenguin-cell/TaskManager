import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"
//Date format пн окт. 21 2019
Rectangle
{
    property int p_width
    property int p_height
    property string p_binding_property
    property QtObject p_binding_object
    id:rec_main
    Calendar
    {
        id:date_selecter
        x:0
        y:but_hide_show.height
        width:p_width
        height: p_height-but_hide_show.height
        onClicked:
        {
            var val = new Date()
             val = date_selecter.selectedDate
            txt_selected_date.f_set_text(val.toDateString())
            console.log(val.toDateString())
        }
        //visible: false
    }

    UICOmponents_Button
    {
        id:but_hide_show
        x:0
        y:0
        width: p_width
        height: p_height/18-txt_selected_date
        text: "Развернуть календарь"
        onS_triggered:
        {
            //txt_selected_date.f_set_text(Date(date_selecter.selectedDate))

            date_selecter.visible=!date_selecter.visible
            if(date_selecter.visible)
            {
                rec_main.height+=date_selecter.height
                //but_hide_show.y=0
                //console.log(date_selecter.selectedDate)
            }
            else
            {
                //but_hide_show.y=parent.height/2

                rec_main.height-=date_selecter.height
            }

        }
        UIComponents_InputWindow
        {
            id:txt_selected_date
            x:0
            y:but_hide_show.height
            width: but_hide_show.width
            height: but_hide_show.height/1.5
            binding_object: p_binding_object
            binding_prop_name: p_binding_property
            Component.onCompleted:
            {
                f_set_text(date_selecter.selectedDate.toDateString())
            }
        }
    }
    function f_set_date(arg_value)
    {
        date_selecter.selectedDate=arg_value
    }

    function f_get_date()
    {
        return  date_selecter.selectedDate
    }

}
