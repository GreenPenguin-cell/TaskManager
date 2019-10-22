import QtQuick 2.0

Rectangle {
    id:rec_main
    property  QtObject binding_object
    property string binding_property_name
    Rectangle
    {
        id:rec_seconds
        x:rec_seconds.width+rec_minits.width
        y:0
        border.width: 2
        border.color: "black"
        width: parent.width/3
        height: parent.height
        UICOmponents_Button
        {
            id:but_up_seconds
            x:0
            y:0
            width: parent.width/5
            height: parent.height/2
            text: "+"
            onS_triggered:
            {

                var olds = Number(txt_seconds.f_get_text())
                if((olds<=59)&&(olds>=0))
                {
                    olds+=1
                    if(olds<10)
                        txt_seconds.f_set_text("0"+String(olds))
                    else
                        txt_seconds.f_set_text(olds)
                }
                if(olds>59)
                    txt_seconds.f_set_text("59")

            }
        }
        UICOmponents_Button
        {
            id:but_down_seconds
            x:0
            y:but_up_seconds.height
            width: parent.width/5
            height: parent.height/2
            text: "-"
            onS_triggered:
            {
                var olds = Number(txt_seconds.f_get_text())
                if((olds<=59)&&(olds>=0))
                {
                    olds-=1
                    if(olds<10)
                        txt_seconds.f_set_text("0"+String(olds))
                    else
                        txt_seconds.f_set_text(olds)
                }
                if(olds<0)
                    txt_seconds.f_set_text("00")
            }
        }

        UIComponents_InputWindow
        {
            id:txt_seconds
            x:but_up_seconds.width
            y:0
            width: parent.width-but_up_seconds.width
            height: parent.height
            onS_text_changed:
            {
                //               var newt=f_get_text()
                //               var type = typeof newt
                //               if(type!='int    ')
                //                   f_set_text(00)
            }
        }

    }
    Rectangle
    {
        id:rec_minits
        x:rec_hours.width
        y:0
        border.width: 2
        border.color: "black"
        width: parent.width/3
        height: parent.height
        UICOmponents_Button
        {
            id:but_up_minits
            x:0
            y:0
            width: parent.width/5
            height: parent.height/2
            text: "+"
            onS_triggered:
            {
                var olds = Number(txt_minits.f_get_text())
                if((olds<=59)&&(olds>=0))
                {
                    olds+=1
                    if(olds<10)
                        txt_minits.f_set_text("0"+String(olds))
                    else
                        txt_minits.f_set_text(olds)
                }
                if(olds>59)
                    txt_minits.f_set_text("59")
            }

        }
        UICOmponents_Button
        {
            id:but_down_minits
            x:0
            y:but_up_minits.height
            width: parent.width/5
            height: parent.height/2
            text: "-"
            onS_triggered:
            {
                var olds = Number(txt_minits.f_get_text())
                if((olds<=59)&&(olds>=0))
                {
                    olds-=1
                    if(olds<10)
                        txt_minits.f_set_text("0"+String(olds))
                    else
                        txt_minits.f_set_text(olds)
                }
                if(olds<0)
                    txt_minits.f_set_text("00")
            }
        }

        UIComponents_InputWindow
        {
            id:txt_minits
            x:but_up_seconds.width
            y:0
            width: parent.width-but_up_seconds.width
            height: parent.height

        }

    }
    Rectangle
    {
        id:rec_hours
        x:0//rec_seconds.width+rec_minits.width
        y:0
        border.width: 2
        border.color: "black"
        width: parent.width/3
        height: parent.height
        UICOmponents_Button
        {
            id:but_up_hours
            x:0
            y:0
            width: parent.width/5
            height: parent.height/2
            text: "+"
            onS_triggered:
            {
                var olds = Number(txt_hours.f_get_text())
                if((olds<=23)&&(olds>=0))
                {
                    olds+=1
                    if(olds<10)
                        txt_hours.f_set_text("0"+String(olds))
                    else
                        txt_hours.f_set_text(olds)
                }
                if(olds>23)
                    txt_hours.f_set_text("23")

            }
        }
        UICOmponents_Button
        {
            id:but_down_hours
            x:0
            y:but_up_hours.height
            width: parent.width/5
            height: parent.height/2
            text: "-"
            onS_triggered:
            {
                var olds = Number(txt_hours.f_get_text())
                if((olds<=23)&&(olds>=0))
                {
                    olds-=1
                    if(olds<10)
                        txt_hours.f_set_text("0"+String(olds))
                    else
                        txt_hours.f_set_text(olds)
                }
                if(olds<0)
                    txt_hours.f_set_text("00")

            }

        }



        UIComponents_InputWindow
        {
            id:txt_hours
            x:but_up_seconds.width
            y:0
            width: parent.width-but_up_seconds.width
            height: parent.height

        }

    }
    Binding
    {
        target: binding_object
        value: f_get_time()
        property: binding_property_name
    }

    function f_set_time(arg_time)
    {
        var vals = arg_time.split(":")
        txt_seconds.p_text=vals[2]
        txt_minits.p_text=vals[1]
        txt_hours.p_text=vals[0]
    }

    function f_get_time()
    {
        var time = txt_hours.f_get_text()+":"+txt_minits.f_get_text()+":"+txt_seconds.f_get_text()
        return time
    }
}
