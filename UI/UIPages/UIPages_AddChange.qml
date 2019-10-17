import QtQuick 2.0

Item {
    id:main
    property int p_changed_task_id: -1
    Rectangle
    {
        id:main_rec
        anchors.fill: parent
        color: "yellow"
        Text {
            id: name
            x: 259
            y: 195
            width: 163
            height: 83
            text: qsTr("add page")
            font.pointSize: 20
        }
        Text {
            id: txt_task_id
            x: 259
            y: name.height+10
            width: 163
            height: 83
            text: qsTr("-1")
            font.pointSize: 20
        }
        Binding
        {
            target:txt_task_id
            property: "text"
            value: p_changed_task_id
        }
    }

}
