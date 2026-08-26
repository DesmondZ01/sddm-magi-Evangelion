import QtQuick

Item {
    id: root
    property color stripeA: "#e8c400"
    property color stripeB: "#141414"
    property bool reverse: false
    readonly property real unit: 40 * scaleF
    property real scaleF: 1.0

    clip: true

    Rectangle {
        width: parent.width * 2.4 + 800 * root.scaleF
        height: parent.height * 3
        y: -parent.height
        x: -400 * root.scaleF - (root.reverse ? width : 0)
        rotation: -30
        transformOrigin: Item.Center

        Row {
            Repeater {
                model: 80
                Rectangle {
                    width: root.unit
                    height: parent.height
                    color: index % 2 === 0 ? root.stripeA : root.stripeB
                }
            }
        }

        SequentialAnimation on x {
            loops: Animation.Infinite
            running: root.visible
            NumberAnimation { from: 0; to: -root.unit * 2 * (root.reverse ? -1 : 1); duration: 700 }
        }
    }
}
