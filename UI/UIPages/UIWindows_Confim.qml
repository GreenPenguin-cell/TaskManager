import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"
Window {
    //id: name
    //Определяет режим - подтверждение или предупреждение что действие невозможно
    property bool is_DS: false
    property string p_text: ""
    //По этому обьекты -в вызыватели определяют им это или нет
    property string p_object_caller
    title: "Подтверждение"


    onP_object_callerChanged:
    {
        if(p_object_caller=="check_correct")
        {
            but_ok.visible=false
            but_cancel.x = rec_main.width/2-but_cancel.width/2
            but_cancel.text = "Ок"
            title="Предупреждение"
        }
        else
        {
            but_ok.visible=true
            but_ok.width=rec_main.width/2
            but_ok.x=0
            but_cancel.x = but_ok.width
            but_cancel.text = "Отмена"
            title="Подтверждение"
        }
    }

    Rectangle
    {
        id:rec_main
        anchors.fill: parent
        border.width: 2
        color:"#e1e1b0"
        border.color: "#979763"
        Text {
            id: conf_text
            x:parent.width/2-width/2
            y:parent.height/2-height/2
            width: contentWidth
            height: contentHeight
            text: p_text
            font.pixelSize: parent.height/15
        }

        UICOmponents_Button
        {
            id:but_ok
            width: parent.width/2
            height: parent.height/7
            x:0
            y:parent.height-height
            text:"Ок"
            onS_triggered:
            {
                s_confirm_close(true, p_object_caller)
                console.log(p_object_caller)

                close()
            }
        }
        UICOmponents_Button
        {
            id:but_cancel
            width: parent.width/2
            height: parent.height/7
            x:parent.width/2//but_ok.width
            y:parent.height-height
            text:"Отмена"
            onS_triggered:
            {
                s_confirm_close(false,p_object_caller)
                close()
            }
        }

        Component.onCompleted:
        {

            if(is_DS)
            {
                but_ok.visible=false
                but_cancel.x = rec_main.width/2-but_cancel.width/2
                but_cancel.text = "Ок"
                title="Предупреждение"
            }
            else
            {
                but_ok.visible=true
                but_ok.width=parent.width/2
                but_ok.x=0
                but_cancel.x = but_ok.width
                but_cancel.text = "Отмена"
                title="Подтверждение"
            }
            show()

        }


    }


}
