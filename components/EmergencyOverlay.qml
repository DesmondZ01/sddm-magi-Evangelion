import QtQuick

Rectangle {
    id: root
    anchors.fill: parent
    color: "#14e10600"
    visible: false
    property real scaleF: 1.0

    function show() {
        root.visible = true
        hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: 1600
        onTriggered: root.visible = false
    }

    HazardStripes {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 76 * root.scaleF
        scaleF: root.scaleF
    }
    HazardStripes {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 76 * root.scaleF
        scaleF: root.scaleF
        reverse: true
    }

    Rectangle {
        id: emCenter
        anchors.centerIn: parent
        width: Math.max(emBig.implicitWidth, emJp.implicitWidth) + 128 * root.scaleF
        height: emBig.implicitHeight + emJp.implicitHeight + emSub.implicitHeight + 84 * root.scaleF
        border.width: 3
        border.color: inverted ? "#ffffff" : "#e10600"
        color: inverted ? "#ffffff" : "#e10600"

        property bool inverted: false

        SequentialAnimation {
            loops: Animation.Infinite
            running: root.visible
            ScriptAction { script: emCenter.inverted = false }
            PauseAnimation { duration: 500 }
            ScriptAction { script: emCenter.inverted = true }
            PauseAnimation { duration: 500 }
        }

        Text {
            id: emBig
            anchors.top: parent.top
            anchors.topMargin: 26 * root.scaleF
            anchors.horizontalCenter: parent.horizontalCenter
            text: "EMERGENCY"
            color: emCenter.inverted ? "#e10600" : "#ffffff"
            font.family: "Noto Serif CJK JP"
            font.weight: Font.Black
            font.pixelSize: 64 * root.scaleF
            font.letterSpacing: 16 * root.scaleF
        }
        Text {
            id: emJp
            anchors.top: emBig.bottom
            anchors.topMargin: 10 * root.scaleF
            anchors.horizontalCenter: parent.horizontalCenter
            text: "緊急事態発生"
            color: emCenter.inverted ? "#e10600" : "#ffffff"
            font.family: "Noto Serif CJK JP"
            font.weight: Font.Black
            font.pixelSize: 28 * root.scaleF
            font.letterSpacing: 10 * root.scaleF
        }
        Text {
            id: emSub
            anchors.top: emJp.bottom
            anchors.topMargin: 16 * root.scaleF
            anchors.horizontalCenter: parent.horizontalCenter
            text: "UNAUTHORIZED PERSONNEL DETECTED"
            color: emCenter.inverted ? "#e10600" : "#ffffff"
            font.family: emMono.name
            font.pixelSize: 13 * root.scaleF
            font.letterSpacing: 5 * root.scaleF

            FontLoader { id: emMono; source: "../assets/fonts/ShareTechMono-Regular.ttf" }
        }
    }
}
