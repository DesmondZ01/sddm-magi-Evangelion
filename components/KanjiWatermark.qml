import QtQuick

Column {
    id: root
    property string text: ""
    property color stroke: "#2ee10600"
    spacing: 28 * scaleF
    property real scaleF: 1.0

    Repeater {
        model: root.text.split("")

        Text {
            required property string modelData
            text: modelData
            color: "transparent"
            style: Text.Outline
            styleColor: root.stroke
            font.family: "Noto Serif CJK JP"
            font.weight: Font.Black
            font.pixelSize: 92 * root.scaleF
        }
    }
}
