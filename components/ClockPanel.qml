import QtQuick

Column {
    id: root
    spacing: 8 * scaleF
    property real scaleF: 1.0

    FontLoader { id: monoFont; source: "../assets/fonts/ShareTechMono-Regular.ttf" }
    FontLoader { id: condBold; source: "../assets/fonts/SairaCondensed-Bold.ttf" }
    readonly property string monoName: monoFont.name
    readonly property string condName: condBold.name

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "LOCAL TIME // "
        color: "#6b6640"
        font.family: root.monoName
        font.pixelSize: 11 * root.scaleF
        font.letterSpacing: 5 * root.scaleF

        Text {
            anchors.left: parent.right
            anchors.baseline: parent.baseline
            text: "東京-3"
            color: "#e10600"
            font.family: "Noto Serif CJK JP"
            font.weight: Font.Bold
            font.pixelSize: 11 * root.scaleF
        }
    }

    Item {
        width: timeGlow.implicitWidth
        height: timeGlow.implicitHeight
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: timeGlow2
            anchors.centerIn: parent
            text: timeGlow.timeText
            color: "#47e10600"
            font.family: root.condName
            font.pixelSize: 68 * root.scaleF
            font.letterSpacing: 12 * root.scaleF
        }
        Text {
            id: timeGlow
            property string timeText: "00:00:00"
            anchors.centerIn: parent
            text: timeGlow.timeText
            color: "#ff4438"
            font.family: root.condName
            font.pixelSize: 68 * root.scaleF
            font.letterSpacing: 12 * root.scaleF
        }
    }

    Text {
        id: dateText
        anchors.horizontalCenter: parent.horizontalCenter
        text: "--- 0000.00.00"
        color: "#9effcc00"
        font.family: root.monoName
        font.pixelSize: 13 * root.scaleF
        font.letterSpacing: 6 * root.scaleF
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var d = new Date()
            var p = function(n) { return n < 10 ? "0" + n : "" + n }
            timeGlow.timeText = p(d.getHours()) + ":" + p(d.getMinutes()) + ":" + p(d.getSeconds())
            var days = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
            dateText.text = days[d.getDay()] + " " + d.getFullYear() + "." + p(d.getMonth() + 1) + "." + p(d.getDate())
        }
    }
}
