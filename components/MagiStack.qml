import QtQuick

Column {
    id: root
    spacing: 18 * scaleF
    property real scaleF: 1.0
    readonly property color gold: "#ffcc00"
    readonly property color goldDim: "#73ffcc00"
    readonly property color goldText: "#9effcc00"
    readonly property color cyan: "#38a8ff"
    readonly property color dim: "#6b6640"

    FontLoader { id: monoFont; source: "../assets/fonts/ShareTechMono-Regular.ttf" }
    readonly property string monoName: monoFont.name
    readonly property string jpSerif: "Noto Serif CJK JP"

    Repeater {
        model: [
            { name: "MELCHIOR-1", cap: "SCIENCE // 2ND TREE OF LIFE", dur: 3200 },
            { name: "BALTHASAR-2", cap: "LABOR // PERSONNEL MATRIX", dur: 4100 },
            { name: "CASPER-3", cap: "FAITH // DECISION QUORUM", dur: 2700 }
        ]

        delegate: Column {
            id: block
            required property var modelData
            spacing: 5 * root.scaleF
            width: 240 * root.scaleF

            Item {
                width: parent.width
                height: Math.max(nameText.implicitHeight, stText.implicitHeight)

                Text {
                    id: nameText
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\u2B21 " + block.modelData.name
                    color: root.gold
                    font.family: root.monoName
                    font.pixelSize: 12.5 * root.scaleF
                    font.letterSpacing: 1.5 * root.scaleF
                }
                Text {
                    id: stText
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "ONLINE"
                    color: root.gold
                    font.family: root.monoName
                    font.pixelSize: 11.5 * root.scaleF
                }
            }

            Rectangle {
                width: parent.width
                height: 6 * root.scaleF
                color: "transparent"
                border.color: root.goldDim
                border.width: 1

                Rectangle {
                    id: fill
                    anchors.fill: parent
                    anchors.margins: 1.5 * root.scaleF
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0; color: "#1565a8" }
                        GradientStop { position: 1; color: root.cyan }
                    }
                }

                SequentialAnimation on width {
                    loops: Animation.Infinite
                    running: root.visible
                    NumberAnimation { target: fill; property: "width"; to: fill.parent.width * 0.94; duration: block.modelData.dur; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: fill; property: "width"; to: fill.parent.width * 0.72; duration: block.modelData.dur; easing.type: Easing.InOutQuad }
                }
            }

            Text {
                text: block.modelData.cap
                color: root.dim
                font.family: root.monoName
                font.pixelSize: 10 * root.scaleF
                font.letterSpacing: 2 * root.scaleF
            }
        }
    }

    Rectangle {
        width: 240 * root.scaleF
        height: syncTitle.height + 58 * root.scaleF + 12 * root.scaleF
        color: "#d6050504"
        border.color: root.goldDim
        border.width: 1

        Column {
            anchors.fill: parent
            Item {
                id: syncTitle
                width: parent.width
                height: 24 * root.scaleF

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10 * root.scaleF
                    anchors.verticalCenter: parent.verticalCenter
                    text: "SYNC DATA"
                    color: root.dim
                    font.family: root.monoName
                    font.pixelSize: 11 * root.scaleF
                    font.letterSpacing: 3 * root.scaleF
                }
                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10 * root.scaleF
                    anchors.verticalCenter: parent.verticalCenter
                    text: "同期率"
                    color: root.goldText
                    font.family: root.jpSerif
                    font.weight: Font.Bold
                    font.pixelSize: 11 * root.scaleF
                }
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: "#21ffcc00"
                }
            }

            Item {
                width: parent.width
                height: 58 * root.scaleF

                Row {
                    id: grid
                    anchors.fill: parent
                    anchors.margins: 9 * root.scaleF
                    spacing: 3 * root.scaleF

                    Repeater {
                        model: 26
                        Rectangle {
                            required property int index
                            width: (grid.width - 25 * 3 * root.scaleF) / 26
                            height: (15 + Math.random() * 80) / 100 * grid.height
                            anchors.bottom: parent.bottom

                            gradient: Gradient {
                                orientation: Gradient.Vertical
                                GradientStop { position: 0.0; color: "#8fd0ff" }
                                GradientStop { position: 0.3; color: "#2e97e8" }
                                GradientStop { position: 1.0; color: "#0d2c4d" }
                            }

                            Behavior on height {
                                NumberAnimation { duration: 650; easing.type: Easing.OutCubic }
                            }
                        }
                    }
                }

                Timer {
                    interval: 750
                    running: root.visible
                    repeat: true
                    onTriggered: {
                        for (var i = 0; i < grid.children.length; i++) {
                            var b = grid.children[i]
                            if (b.height !== undefined)
                                b.height = (12 + Math.random() * 85) / 100 * grid.height
                        }
                    }
                }
            }
        }
    }
}
