import QtQuick 2.0

Rectangle {
//    Image {
//        id: background
//        x:0
//        y:0
//        source: "../UIFiles/s1200.jpeg"
//        width: rec_view.width
//        height: rec_view.height
//    }

    id:rec_view
    width: parent.width/1.4
    height: parent.height/1.4
    color: "#e1e1b0"
//        Image {
//            id: background
//            x:0
//            y:0
//            source: "back.jpg"
//            width: rec_view.width
//            height: rec_view.height
//        }
    property QtObject dataSourse: undefined //Хранит модель данных
    property  int  column_count: 0
    property  int p_current_index

    property int p_element_width: 100
    property int p_element_height: 70

    ListModel
    {
        id:lmododel_headers
        property int splitter
    }




    ListView {
        id: view

        anchors.margins: 3
        anchors.fill: parent
        spacing: 10
        //width: parent.width
        model: dataSourse
        clip: true



        delegate: Item {
            id: listDelegate

            property var view: ListView.view
            property var isCurrent: ListView.isCurrentItem

           // width: view.width//view.width
            height: p_element_height//-10
            UICOmponents_Button
            {
                text: model.CommandNameRole
                width: p_element_width
                height: p_element_height
                border.width: 2
                color: focus ? "#797a58":"#bebe7d"
                border.color: "#797a58"
//                p_has_image: true
//                p_image_path: "element.jpeg"
                onS_triggered:
                {
                    view.currentIndex = model.index
                    //Будет открытие страницы просмотра и изменения(отправка сигнала с индексом)
                    //console.log(view.currentIndex)
                }
            }



        }
    }
    function f_get_current_index()
    {
        return p_current_index
    }

    function f_column_add(arg_text)
    {
        column_count+=1
        lmododel_headers.append({text:arg_text, splitter:lmododel_headers.count})
    }
}
//Таким раньше был делегат, впринципе неплохо, но не подходит под телефон
//            Binding
//            {
//                target: rec_view
//                property: "p_current_index"
//                value: view.currentIndex
//            }

//            Rectangle {
//                id:rec_view_componenet
//                anchors.margins: 5
//                anchors.fill: parent
//                // radius: height / 2

//                Rectangle
//                {
//                    id:rec_splitter
//                    x:parent.width/2
//                    y:0
//                    width: 1
//                    height: parent.height
//                    color: "black"
//                }
//                Text
//                {
//                    id:txt_command
//                    x:0
//                    y:1
//                    renderType: Text.NativeRendering
//                    text:model.CommandNameRole
//                }
//                Text
//                {
//                    id:txt_alias
//                    x:parent.width/2+1
//                    y:1
//                    renderType: Text.NativeRendering
//                    text:model.CommandAliasRole
//                }

//                color: "white"//model.color
//                border {
//                    color: "black"
//                    width: 1
//                }



//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {view.currentIndex = model.index

//                    }
//                }
//            }


//Этот кусок кода отвечал за заголовки, причем их количество - динамично, может пригодится
//        header: Rectangle {
//            width: view.width
//            height: 40
//            border {
//                color: "black"
//                width: 1
//            }
//            Repeater
//            {
//                id: rep_column_spleater
//                model:lmododel_headers
//                Rectangle
//                {
//                    x:parent.width/column_count + parent.width/column_count*model.splitter
//                    y:0
//                    width: 1
//                    height: parent.height
//                    color: "black"
//                    Text {
//                        text: model.text
//                        x:-contentWidth*1.5
//                        y:4
//                    }
//                }

//            }


//        }
//        highlight: Rectangle {
//            color: "skyblue"
//        }
//        highlightFollowsCurrentItem: true
