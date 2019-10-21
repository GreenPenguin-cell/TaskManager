import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

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
