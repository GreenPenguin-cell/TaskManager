import QtQuick 2.0

Item {
    Rectangle
    {
        id:main_rec
        anchors.fill: parent
        color: "skyblue"
        Text {
            id: name
            text: qsTr("game page")
        }
    }

}
