import QtQuick 2.0

Item {
    Rectangle
    {
        id:main_rec
        anchors.fill: parent
        color: "green"
        Text {
            id: name
            text: qsTr("Priority page")
        }
    }

}
