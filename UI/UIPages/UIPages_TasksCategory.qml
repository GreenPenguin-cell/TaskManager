import QtQuick 2.0

Item {
    Rectangle
    {
        id:main_rec
        anchors.fill: parent
        color: "yellow"
        Text {
            id: name
            text: qsTr("Category page")
        }
    }

}
