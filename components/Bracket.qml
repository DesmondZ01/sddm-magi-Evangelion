import QtQuick

Item {
    id: root
    property bool flipX: false
    property bool flipY: false
    property color tint: "#73ffcc00"
    property real scaleF: 1.0

    width: 42 * scaleF
    height: 26 * scaleF

    Rectangle {
        width: parent.width
        height: 2 * scaleF
        color: root.tint
        anchors.top: root.flipY ? undefined : parent.top
        anchors.bottom: root.flipY ? parent.bottom : undefined
        anchors.left: root.flipX ? parent.left : parent.left
        anchors.right: root.flipX ? parent.right : undefined
    }
    Rectangle {
        width: 2 * scaleF
        height: parent.height
        color: root.tint
        anchors.left: root.flipX ? undefined : parent.left
        anchors.right: root.flipX ? parent.right : undefined
        anchors.top: parent.top
    }
}
