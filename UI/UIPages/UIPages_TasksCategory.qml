import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    property QtObject dataModel
    //#e1e1b0
    Rectangle
    {
        id:main_rec
        //anchors.fill: parent
        width: parent.width
        height: parent.height
        y:listDelegate.height
        //color:"#bcbc91"
        color:"#e1e1b0"
        ListModel
        {
            id:test
            ListElement
            {
                text:"cat1"
                color:"#bcbc91"

            }
            ListElement
            {
                text:"cat2"
                color:"#bcbc91"
            }
        }

        ListView {
            id: view
            anchors.margins: 3
            //anchors.fill: parent
            width: parent.width//-rec_scroll.width
            height: parent.height
            spacing: 10
            //width: parent.width
            model: test
            clip: true



            delegate: Item {
                id: listDelegate

                property var view: ListView.view
                property var isCurrent: ListView.isCurrentItem
                // y:rec_upper_panel.height

                // width: view.width//view.width
                height:main_rec.height/10// p_element_height//-10
                UICOmponents_Button
                {
                    text: model.text

                    width: main_rec.width//p_element_width//-rec_scroll.width
                    height: main_rec.height/10//p_element_height
                    border.width: 2
                    color: focus ? "#797a58":model.color//"#bebe7d"
                    border.color: "#797a58"
                    //                p_has_image: true
                    //                p_image_path: "element.jpeg"
                    onS_triggered:
                    {

                    }
                    UICOmponents_Button
                    {
                        id:but_deploy
                        x:parent.width-width
                        y:0
                        width: parent.width/10
                        height: parent.height
                        border.width: parent.border.width
                        border.color: parent.border.color




                    }

                }



            }



        }
    }




}
