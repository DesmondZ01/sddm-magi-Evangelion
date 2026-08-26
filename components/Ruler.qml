import QtQuick

Item {
    id: root
    height: 15 * scaleF
    property real scaleF: 1.0

    Row {
        id: ticks
        anchors.fill: parent
        Repeater {
            model: 90
            Rectangle {
                required property int index
                width: 1
                height: index % 5 === 0 ? parent.height : parent.height * 0.42
                color: index % 5 === 0 ? "#99ffcc00" : "#59ffcc00"
            }
        }
    }

    Rectangle {
        id: playhead
        y: -3 * scaleF
        width: 2
        height: parent.height + 4 * scaleF
        color: "#ffffff"

        SequentialAnimation on x {
            loops: Animation.Infinite
            running: root.visible
            NumberAnimation { to: root.width - 2; duration: 14000 }
            NumberAnimation { to: 0; duration: 14000 }
        }
    }
}
