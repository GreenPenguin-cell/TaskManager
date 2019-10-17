import QtQuick 2.0

Item {
    Rectangle
    {
        id:main_rec
        anchors.fill: parent
        color: "white"
        Text {
            id: name
            text: qsTr("Settings page")
        }
    }

}
