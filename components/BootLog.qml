import QtQuick

Rectangle {
    id: root
    color: "#d6050504"
    border.color: "#73ffcc00"
    border.width: 1
    property real scaleF: 1.0

    width: 396 * scaleF
    height: titleRow.height + logColumn.implicitHeight + 22 * scaleF

    FontLoader { id: monoFont; source: "../assets/fonts/ShareTechMono-Regular.ttf" }
    readonly property string monoName: monoFont.name

    property var lines: [
        "> MAGI SYSTEM BOOT SEQUENCE INITIATED",
        "> MELCHIOR-1 .......... ONLINE",
        "> BALTHASAR-2 ......... ONLINE",
        "> CASPER-3 ............ ONLINE",
        "> pattern analysis ......... BLUE",
        "> A.T. field generation ... ACTIVE",
        "> pilot sync ratio ........ 41.3%",
        "> umbilical cable ......... NOMINAL",
        "> personnel database ...... LOADED",
        "> awaiting authentication "
    ]
    property int revealed: 0

    Column {
        id: titleRow
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Item {
            width: parent.width
            height: 24 * root.scaleF

            Text {
                anchors.left: parent.left; anchors.leftMargin: 12 * root.scaleF
                anchors.verticalCenter: parent.verticalCenter
                text: "SYSTEM LOG"
                color: "#6b6640"
                font.family: root.monoName
                font.pixelSize: 11 * root.scaleF
                font.letterSpacing: 3 * root.scaleF
            }
            Text {
                anchors.right: parent.right; anchors.rightMargin: 12 * root.scaleF
                anchors.verticalCenter: parent.verticalCenter
                text: "TTY1"
                color: "#6b6640"
                font.family: root.monoName
                font.pixelSize: 11 * root.scaleF
            }
            Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#21ffcc00" }
        }
    }

    Column {
        id: logColumn
        anchors.top: titleRow.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12 * root.scaleF
        spacing: 4 * root.scaleF

        Repeater {
            model: root.lines

            delegate: Row {
                id: lineRow
                required property int index
                required property string modelData
                spacing: 2 * root.scaleF
                opacity: index < root.revealed ? 1 : 0
                x: index < root.revealed ? 0 : -6 * root.scaleF
                Behavior on opacity { NumberAnimation { duration: 250 } }
                Behavior on x { NumberAnimation { duration: 250 } }

                Text {
                    text: lineRow.modelData
                    color: "#9effcc00"
                    font.family: root.monoName
                    font.pixelSize: 12.5 * root.scaleF
                }
                Rectangle {
                    visible: lineRow.index === root.lines.length - 1 && lineRow.index < root.revealed
                    width: 8 * root.scaleF
                    height: 14 * root.scaleF
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#38a8ff"

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        running: true
                        NumberAnimation { to: 0; duration: 500 }
                        NumberAnimation { to: 1; duration: 500 }
                    }
                }
            }
        }
    }

    Timer {
        running: root.visible
        interval: 240
        repeat: true
        triggeredOnStart: false
        onTriggered: if (root.revealed < root.lines.length) root.revealed++
    }
}
