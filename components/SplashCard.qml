import QtQuick

Rectangle {
    id: root
    anchors.fill: parent
    color: "#000000"
    property real scaleF: 1.0
    signal dismissed

    MouseArea { anchors.fill: parent; onClicked: root.dismiss() }

    Column {
        anchors.centerIn: parent
        spacing: 22 * root.scaleF

        Text {
            id: jpTitle
            anchors.horizontalCenter: parent.horizontalCenter
            text: "使徒、襲来"
            color: "#ffffff"
            font.family: "Noto Serif CJK JP"
            font.weight: Font.Black
            font.pixelSize: Math.min(96 * root.scaleF, root.width / 7)
            font.letterSpacing: 12 * root.scaleF

            SequentialAnimation on x {
                loops: Animation.Infinite
                running: root.visible
                NumberAnimation { to: 0; duration: 2100 }
                NumberAnimation { to: -4; duration: 40 }
                NumberAnimation { to: 3; duration: 40 }
                NumberAnimation { to: 0; duration: 40 }
                PauseAnimation { duration: 400 }
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 360 * root.scaleF
            height: 2
            color: "#e10600"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "ANGEL ATTACK"
            color: "#e10600"
            font.family: monoFont.name
            font.pixelSize: 17 * root.scaleF
            font.letterSpacing: 14 * root.scaleF

            FontLoader { id: monoFont; source: "../assets/fonts/ShareTechMono-Regular.ttf" }
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 34 * root.scaleF
        anchors.horizontalCenter: parent.horizontalCenter
        text: "CLICK TO CONTINUE"
        color: "#4cffffff"
        font.family: monoFont.name
        font.pixelSize: 11 * root.scaleF
        font.letterSpacing: 3 * root.scaleF
    }

    Timer {
        interval: 2400
        running: true
        onTriggered: root.dismiss()
    }

    function dismiss() {
        if (root.opacity === 0) return
        dismissAnim.start()
    }

    SequentialAnimation {
        id: dismissAnim
        NumberAnimation { target: root; property: "opacity"; from: 1; to: 0; duration: 550 }
        ScriptAction { script: { root.visible = false; root.dismissed() } }
    }
}
