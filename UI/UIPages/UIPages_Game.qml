import QtQuick 2.0

Item {
    Rectangle
    {
        id:main_rec
        anchors.fill: parent
        color: "black"
        Text {
            id: name
            color: "white"
            text: qsTr("game page")
        }
    }

}
