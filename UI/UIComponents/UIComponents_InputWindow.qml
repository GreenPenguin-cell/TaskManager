import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

Rectangle {
    id:inp_rec
    width: 100
    height: 50
    color: "#dfe2dd"
    border.width: 2
    border.color: "#7d7b4f"
    visible: true
    property string p_message: text_inp.text
    property bool has_header: false
    property string  header_text: "<header>"
    property string  p_text: ""

    property string binding_prop_name: ""
    property QtObject binding_object

    property bool is_multiline: false
    property bool is_read_only: false
    signal s_text_changed
    Binding
    {
        id:binding
        target: binding_object
        property: binding_prop_name
        value: p_message
    }

    TextEdit
    {
        id:text_inp
        anchors.fill: parent
        x:2
        y:2
        width: parent.width-3
        height: parent.height-3
        font.pixelSize: parent.height/2
        text:"<Enter text>"
        //onTextChanged: p_message = text_inp.text
        readOnly: is_read_only
        onTextChanged: s_text_changed()
        Text
        {
            id:header
            x:0
            y:-header.contentHeight
            text:""
            visible: true
        }
    }
    Component.onCompleted:
    {
        header.visible = has_header
        header.text = header_text
        if(binding_object === undefined)
            binding_object=Component
        f_set_text(p_text)

        if(is_multiline)
            text_inp.font.pixelSize=inp_rec.height/6
    }

    function f_set_textSize(arg_size)
    {
        text_inp.font.pixelSize=arg_size
    }

    function f_get_text()
    {
        return text_inp.text
    }

    function f_set_text_color(arg_ccolor)
    {
        text_inp.color = arg_ccolor
    }
    function f_set_background_color(arg_ccolor)
    {
        inp_rec.color = arg_ccolor;
    }
    function f_set_border_color(arg_color)
    {
        inp_rec.border.color = arg_color
    }
    function f_set_border_width(arg_width)
    {
        inp_rec.border.width = arg_width
    }
    function f_set_text(arg_text)
    {
        text_inp.text = arg_text
    }
    function get_content_width()
    {
       return text_inp.contentWidth
    }
    function get_content_heigth()
    {
       return text_inp.contentHeight
    }



}

