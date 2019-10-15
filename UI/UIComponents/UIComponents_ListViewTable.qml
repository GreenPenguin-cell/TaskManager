import QtQuick 2.0

Rectangle {
    id:rec_view
    width: parent.width/1.4
    height: parent.height/1.4
    property QtObject dataSourse: undefined //Хранит модель данных
    property  int  column_count: 0
    property  int p_current_index

    ListModel
    {
        id:lmododel_headers
        property int splitter
    }




    ListView {
        id: view

        anchors.margins: 10
        anchors.fill: parent
        spacing: 10
        model: dataSourse
        clip: true

        header: Rectangle {
            width: view.width
            height: 40
            border {
                color: "black"
                width: 1
            }
            Repeater
            {
                id: rep_column_spleater
                model:lmododel_headers
                Rectangle
                {
                    x:parent.width/column_count + parent.width/column_count*model.splitter
                    y:0
                    width: 1
                    height: parent.height
                    color: "black"
                    Text {
                        text: model.text
                        x:-contentWidth*1.5
                        y:4
                    }
                }

            }


        }
        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        delegate: Item {
            id: listDelegate

            property var view: ListView.view
            property var isCurrent: ListView.isCurrentItem

            width: view.width
            height: 40

            Binding
            {
                target: rec_view
                property: "p_current_index"
                value: view.currentIndex
            }

            Rectangle {
                id:rec_view_componenet
                anchors.margins: 5
                anchors.fill: parent
                // radius: height / 2

                Rectangle
                {
                    id:rec_splitter
                    x:parent.width/2
                    y:0
                    width: 1
                    height: parent.height
                    color: "black"
                }
                Text
                {
                    id:txt_command
                    x:0
                    y:1
                    renderType: Text.NativeRendering
                    text:model.CommandNameRole
                }
                Text
                {
                    id:txt_alias
                    x:parent.width/2+1
                    y:1
                    renderType: Text.NativeRendering
                    text:model.CommandAliasRole
                }

                color: "white"//model.color
                border {
                    color: "black"
                    width: 1
                }



                MouseArea {
                    anchors.fill: parent
                    onClicked: {view.currentIndex = model.index

                    }
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
