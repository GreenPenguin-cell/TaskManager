import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Rectangle {
    id:but_rec
    width: 100
    height: 50
    color : focus ? "#5b765d" : "#9aa99b"
    border.color: "#5b765d"
    border.width: 2

    signal s_triggered
    //Хранит параметр передаваемый сигналом, это нужно для создания таких кнопок в репитере
    //ЧТобы анализируя параметр выполнять разные действия
    property string p_slot_param: ""
    property string text: ""
    MouseArea
    {
        anchors.fill:parent
        onClicked:
        {
            s_triggered()
        }
        onContainsPressChanged: but_rec.focus = !but_rec.focus

    }
    Text
    {
        id:text_but
        width: 3
        height: text_but.contentHeight
        text:"X"
        x:3
        y:3
        onTextChanged:
        {
            if(width<contentWidth)
                width = contentWidth
            if(height<contentHeight)
                height = contentHeight

        }

    }
    Component.onCompleted:
    {
        f_set_text(text)

    }


    function f_auto_size()
    {
      but_rec.width = text_but.contentWidth+5

    }

    function f_set_text(arg_text)
    {
        text_but.text = arg_text
    }


}
