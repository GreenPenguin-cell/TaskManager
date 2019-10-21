import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
//import QtGraphicalEffects 1.0


Rectangle {
    id:but_rec
    width: 100
    height: 50



    color : focus ? "#5b765d" : "#9aa99b"

    border.color: "#5b765d"
    border.width: 2
    property string p_image_path: ""
    property bool p_has_image: false
    signal s_triggered
    //Хранит параметр передаваемый сигналом, это нужно для создания таких кнопок в репитере
    //ЧТобы анализируя параметр выполнять разные действия
    property string p_slot_param: ""
    property string text: ""
    Image {
        id: background
        x:0
        y:0
        source: p_image_path
        width: but_rec.width
        height: but_rec.height

    }


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
        font.pointSize: 9
        x:parent.width/2-contentWidth/2
        y:parent.height/2-contentHeight/2
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
        if(!p_has_image)
            background.visible=false

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
