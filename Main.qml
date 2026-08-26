import QtQuick
import QtQuick.Controls.Basic
import "components"

Rectangle {
    id: root
    color: "#0b0809"

    readonly property real sf: Math.max(0.65, Math.min(1.35, Math.min(width / 1920, height / 1080)))
    readonly property color gold: "#ffcc00"
    readonly property color goldHi: "#ffd83d"
    readonly property color goldDim: "#73ffcc00"
    readonly property color goldFaint: "#21ffcc00"
    readonly property color goldText: "#9effcc00"
    readonly property color cyan: "#38a8ff"
    readonly property color redC: "#e10600"
    readonly property color dimC: "#6b6640"

    property string selectedName: ""
    property string selectedSessionName: "HYPRLAND"
    property int sessionIdx: typeof sessionModel !== "undefined" ? sessionModel.lastIndex : 0
    property bool authBusy: false

    FontLoader { id: monoFont; source: "assets/fonts/ShareTechMono-Regular.ttf" }
    FontLoader { id: condBold; source: "assets/fonts/SairaCondensed-Bold.ttf" }
    FontLoader { id: condSemi; source: "assets/fonts/SairaCondensed-SemiBold.ttf" }
    readonly property string monoName: monoFont.name
    readonly property string condName: condBold.name

    // ---------- background ----------
    Canvas {
        id: bgCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            ctx.fillStyle = "#0b0809"
            ctx.fillRect(0, 0, width, height)

            var step = 42 * root.sf
            ctx.strokeStyle = "rgba(255,204,0,0.04)"
            ctx.lineWidth = 1
            for (var x = 0; x < width; x += step) {
                ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, height); ctx.stroke()
            }
            for (var y = 0; y < height; y += step) {
                ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(width, y); ctx.stroke()
            }

            var g = ctx.createRadialGradient(width / 2, height / 2, Math.min(width, height) * 0.3,
                                             width / 2, height / 2, Math.max(width, height) * 0.75)
            g.addColorStop(0, "rgba(0,0,0,0)")
            g.addColorStop(1, "rgba(0,0,0,0.6)")
            ctx.fillStyle = g
            ctx.fillRect(0, 0, width, height)
        }

        Connections {
            target: root
            function onWidthChanged() { bgCanvas.requestPaint() }
            function onHeightChanged() { bgCanvas.requestPaint() }
        }
    }

    Image {
        visible: typeof config !== "undefined" && typeof config.General !== "undefined" && config.General.background && config.General.background.length > 0
        source: visible ? config.General.background : ""
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }
    Rectangle {
        visible: typeof config !== "undefined" && typeof config.General !== "undefined" && config.General.background && config.General.background.length > 0
        anchors.fill: parent
        color: "#8c0b0809"
    }

    Image {
        anchors.fill: parent
        source: "assets/scanlines.png"
        fillMode: Image.Tile

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            running: true
            NumberAnimation { to: 0.85; duration: 3800 }
            NumberAnimation { to: 0.6; duration: 60 }
            NumberAnimation { to: 0.85; duration: 60 }
            PauseAnimation { duration: 300 }
            NumberAnimation { to: 0.72; duration: 60 }
            NumberAnimation { to: 0.85; duration: 60 }
        }
    }

    Rectangle {
        y: -150 * root.sf
        width: parent.width
        height: 130 * root.sf
        gradient: Gradient {
            GradientStop { position: 0; color: "transparent" }
            GradientStop { position: 0.5; color: "#0dffcc00" }
            GradientStop { position: 1; color: "transparent" }
        }
        SequentialAnimation on y {
            loops: Animation.Infinite
            running: true
            NumberAnimation { from: -150 * root.sf; to: root.height + 20 * root.sf; duration: 9000 }
        }
    }

    // ---------- edge brackets ----------
    Bracket { anchors { top: parent.top; left: parent.left; margins: 14 * root.sf } scaleF: root.sf }
    Bracket { anchors { top: parent.top; right: parent.right; margins: 14 * root.sf } scaleF: root.sf; flipX: true }
    Bracket { anchors { bottom: parent.bottom; left: parent.left; margins: 14 * root.sf } scaleF: root.sf; flipY: true }
    Bracket { anchors { bottom: parent.bottom; right: parent.right; margins: 14 * root.sf } scaleF: root.sf; flipX: true; flipY: true }

    // ---------- vertical kanji watermarks ----------
    KanjiWatermark {
        text: "人類補完計画"
        x: 30 * root.sf
        y: (root.height - height) / 2
    }
    KanjiWatermark {
        text: "第三新東京市"
        stroke: "#1fffcc00"
        x: root.width - 130 * root.sf
        y: (root.height - height) / 2
    }

    // ---------- hex reticle ----------
    HexReticle {
        width: 600 * root.sf
        height: 600 * root.sf
        x: root.width / 2 - width / 2
        y: root.height * 0.53 - height / 2
        opacity: 0.85
    }

    // ---------- header ----------
    Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 46 * root.sf

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: root.goldFaint
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 30 * root.sf
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12 * root.sf

            Canvas {
                width: 22 * root.sf
                height: 22 * root.sf
                anchors.verticalCenter: parent.verticalCenter
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()
                    ctx.fillStyle = "#e10600"
                    ctx.beginPath()
                    ctx.moveTo(width * 0.98, height * 0.08)
                    ctx.bezierCurveTo(width * 0.42, height * 0.16, width * 0.16, height * 0.44, width * 0.1, height * 0.98)
                    ctx.bezierCurveTo(width * 0.5, height * 0.85, width * 0.82, height * 0.5, width * 0.98, height * 0.08)
                    ctx.fill()
                }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "NERV // MAGI SYSTEM v3.31"
                color: root.gold
                font.family: root.monoName
                font.pixelSize: 13 * root.sf
                font.letterSpacing: 3 * root.sf
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 30 * root.sf
            anchors.verticalCenter: parent.verticalCenter
            spacing: 18 * root.sf

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "TOKYO-3"
                color: root.gold
                font.family: root.monoName
                font.pixelSize: 13 * root.sf
                font.letterSpacing: 3 * root.sf
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "第3新東京市 · +9:00 JST"
                color: root.dimC
                font.family: "Noto Serif CJK JP"
                font.pixelSize: 12 * root.sf
            }
        }
    }

    // ---------- left stack ----------
    MagiStack {
        anchors.top: parent.top
        anchors.topMargin: 70 * root.sf
        anchors.left: parent.left
        anchors.leftMargin: 32 * root.sf
        scaleF: root.sf
    }

    // ---------- right boot log ----------
    BootLog {
        anchors.top: parent.top
        anchors.topMargin: 70 * root.sf
        anchors.right: parent.right
        anchors.rightMargin: 32 * root.sf
        scaleF: root.sf
    }

    // ---------- micro readouts ----------
    Text {
        anchors.left: parent.left
        anchors.leftMargin: 32 * root.sf
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 52 * root.sf
        text: "POSITION ANGLE :: 041.7   ORDER CORRECTION :: 0.02"
        color: root.goldText
        font.family: root.monoName
        font.pixelSize: 11 * root.sf
        font.letterSpacing: 2 * root.sf
    }
    Text {
        anchors.right: parent.right
        anchors.rightMargin: 32 * root.sf
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 52 * root.sf
        text: "PATTERN ANALYSIS :: BLUE   A.T. FIELD :: ACTIVE"
        color: root.goldText
        font.family: root.monoName
        font.pixelSize: 11 * root.sf
        font.letterSpacing: 2 * root.sf
    }

    Ruler {
        anchors.left: parent.left
        anchors.leftMargin: 60 * root.sf
        anchors.right: parent.right
        anchors.rightMargin: 60 * root.sf
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8 * root.sf
        scaleF: root.sf
    }

    // ---------- center zone ----------
    Column {
        anchors.centerIn: parent
        spacing: 22 * root.sf
        y: root.height * 0.53 - height / 2

        ClockPanel {
            anchors.horizontalCenter: parent.horizontalCenter
            scaleF: root.sf
        }

        Rectangle {
            id: card
            anchors.horizontalCenter: parent.horizontalCenter
            width: 480 * root.sf
            height: cardInner.height + hazardBar.height
            color: "#e00b0806"
            border.color: root.goldDim
            border.width: 1

            transform: Translate { id: shakeT }
            SequentialAnimation {
                id: shakeAnim
                NumberAnimation { target: shakeT; property: "x"; to: -9; duration: 60 }
                NumberAnimation { target: shakeT; property: "x"; to: 8; duration: 60 }
                NumberAnimation { target: shakeT; property: "x"; to: -7; duration: 60 }
                NumberAnimation { target: shakeT; property: "x"; to: 6; duration: 60 }
                NumberAnimation { target: shakeT; property: "x"; to: -4; duration: 60 }
                NumberAnimation { target: shakeT; property: "x"; to: 2; duration: 60 }
                NumberAnimation { target: shakeT; property: "x"; to: 0; duration: 40 }
            }

            Column {
                id: cardInner
                anchors.top: parent.top
                width: parent.width

                Rectangle {
                    id: hazardBar
                    width: parent.width
                    height: 10 * root.sf
                    clip: true
                    color: "#0c0a08"
                    Rectangle {
                        width: 2000 * root.sf
                        height: 100 * parent.height
                        y: -(height - parent.height) / 2
                        rotation: -45
                        transformOrigin: Item.Center
                        Row {
                            Repeater {
                                model: 110
                                Rectangle {
                                    required property int index
                                    width: 13 * root.sf
                                    height: parent.height
                                    color: index % 2 === 0 ? root.gold : "#0c0a08"
                                }
                            }
                        }
                    }
                }

                Column {
                    width: parent.width
                    leftPadding: 26 * root.sf
                    rightPadding: 26 * root.sf
                    topPadding: 20 * root.sf
                    bottomPadding: 24 * root.sf
                    spacing: 12 * root.sf

                    Row {
                        spacing: 10 * root.sf
                        Text {
                            text: "SUBJECT REGISTRY"
                            color: root.dimC
                            font.family: root.monoName
                            font.pixelSize: 11.5 * root.sf
                            font.letterSpacing: 3 * root.sf
                        }
                        Text {
                            anchors.baseline: parent.children[0].baseline
                            text: "人事ファイル"
                            color: root.goldText
                            font.family: "Noto Serif CJK JP"
                            font.weight: Font.Bold
                            font.pixelSize: 12 * root.sf
                        }
                    }

                    ListView {
                        id: userList
                        width: parent.width - parent.leftPadding - parent.rightPadding
                        x: parent.leftPadding
                        height: Math.min(contentHeight, 200 * root.sf)
                        interactive: contentHeight > height
                        clip: true
                        spacing: 8 * root.sf
                        model: typeof userModel !== "undefined" ? userModel : null

                        boundsBehavior: Flickable.StopAtBounds
                        ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

                        delegate: Rectangle {
                            id: userCard
                            required property int index
                            required property string name
                            required property string realName
                            width: ListView.view ? ListView.view.width : 0
                            height: 62 * root.sf
                            color: userList.currentIndex === index ? "#12ffcc00" : "transparent"
                            border.color: userList.currentIndex === index ? root.gold : "transparent"
                            border.width: 1

                            readonly property string uname: {
                                var n = realName !== undefined ? realName : ""
                                return n.length > 0 ? n.toUpperCase() : (name || "").toUpperCase()
                            }

                            Component.onCompleted: {
                                if (name === userModel.lastUser || (userModel.lastUser === "" && index === 0)) {
                                    userList.currentIndex = index
                                    selectedName = name
                                }
                            }

                            Rectangle {
                                anchors.left: parent.left
                                width: 3 * root.sf
                                height: parent.height
                                color: root.gold
                                visible: userList.currentIndex === index
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: selectUser(index)
                            }

                            Row {
                                anchors.fill: parent
                                anchors.margins: 8 * root.sf
                                spacing: 14 * root.sf

                                Rectangle {
                                    width: 46 * root.sf
                                    height: 46 * root.sf
                                    anchors.verticalCenter: parent.verticalCenter
                                    gradient: Gradient {
                                        orientation: Gradient.Horizontal
                                        GradientStop { position: 0; color: "#e01000" }
                                        GradientStop { position: 1; color: "#9c0000" }
                                    }
                                    Text {
                                        anchors.centerIn: parent
                                        text: ("0" + (userCard.index + 1)).slice(-2)
                                        color: "#ffffff"
                                        font.family: root.condName
                                        font.pixelSize: 22 * root.sf
                                    }
                                }

                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 3 * root.sf

                                    Text {
                                        text: userCard.uname
                                        color: root.goldHi
                                        font.family: root.condName
                                        font.pixelSize: 18 * root.sf
                                        font.letterSpacing: 3.5 * root.sf
                                    }
                                    Text {
                                        text: userCard.index === 0
                                              ? "SUBJECT: THIRD CHILD · CLEARANCE: PILOT · 第3適格者"
                                              : "SUBJECT: OTHERS · CLEARANCE: CADET"
                                        color: root.goldText
                                        font.family: root.monoName
                                        font.pixelSize: 11 * root.sf
                                    }
                                }

                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "◂"
                                    visible: userList.currentIndex === index
                                    color: root.redC
                                    font.pixelSize: 13 * root.sf
                                }
                            }
                        }
                    }

                    Row {
                        spacing: 10 * root.sf
                        Text {
                            text: "AUTHENTICATION CODE"
                            color: root.dimC
                            font.family: root.monoName
                            font.pixelSize: 11.5 * root.sf
                            font.letterSpacing: 3 * root.sf
                        }
                        Text {
                            anchors.baseline: parent.children[0].baseline
                            text: "認証コード"
                            color: root.goldText
                            font.family: "Noto Serif CJK JP"
                            font.weight: Font.Bold
                            font.pixelSize: 12 * root.sf
                        }
                    }

                    TextField {
                        id: pwField
                        width: parent.width - parent.leftPadding - parent.rightPadding
                        height: 46 * root.sf
                        echoMode: TextInput.Password
                        font.family: root.monoName
                        font.pixelSize: 16 * root.sf
                        color: root.goldHi
                        placeholderText: "AWAITING INPUT"
                        placeholderTextColor: root.dimC
                        selectionColor: root.goldDim
                        cursorDelegate: Rectangle {
                            width: 8
                            color: root.gold
                            visible: pwField.cursorVisible
                            SequentialAnimation on opacity {
                                loops: Animation.Infinite
                                running: true
                                NumberAnimation { to: 0; duration: 500 }
                                NumberAnimation { to: 1; duration: 500 }
                            }
                        }
                        background: Rectangle {
                            color: "#80000000"
                            border.color: pwField.activeFocus ? root.gold : root.goldDim
                            border.width: 1
                        }
                        onAccepted: tryLogin()
                    }

                    Rectangle {
                        id: authBtn
                        width: parent.width - parent.leftPadding - parent.rightPadding
                        height: 46 * root.sf
                        color: authMouse.containsMouse ? root.gold : "transparent"
                        border.color: root.gold
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: "[ AUTHENTICATE ]"
                            color: authMouse.containsMouse ? "#0c0a08" : root.gold
                            font.family: root.monoName
                            font.pixelSize: 14 * root.sf
                            font.letterSpacing: 5 * root.sf
                        }

                        MouseArea {
                            id: authMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: tryLogin()
                        }
                    }
                }
            }
        }
    }

    // ---------- footer ----------
    Item {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 46 * root.sf

        Rectangle {
            anchors.top: parent.top
            width: parent.width
            height: 1
            color: root.goldFaint
        }

        Item {
            anchors.left: parent.left
            anchors.leftMargin: 30 * root.sf
            anchors.verticalCenter: parent.verticalCenter
            width: plugRow.width
            height: plugRow.height

            Row {
                id: plugRow
                spacing: 6 * root.sf

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "PLUG SUITE: " + root.selectedSessionName.toUpperCase()
                    color: root.gold
                    font.family: root.monoName
                    font.pixelSize: 12.5 * root.sf
                    font.letterSpacing: 2 * root.sf
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "▼"
                    color: root.dimC
                    font.pixelSize: 10 * root.sf
                }
            }

            MouseArea {
                id: plugMouse
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: sessionPopup.open()
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 30 * root.sf
            anchors.verticalCenter: parent.verticalCenter
            spacing: 14 * root.sf

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "エントリープラグ接続 · MAGI CONSENSUS: 2/3"
                color: root.dimC
                font.family: "Noto Serif CJK JP"
                font.pixelSize: 11 * root.sf
            }

            Repeater {
                model: [
                    { label: "[ REBOOT ]", action: "reboot" },
                    { label: "[ SHUTDOWN ]", action: "powerOff" }
                ]
                delegate: Rectangle {
                    id: pwrBtn
                    required property var modelData
                    width: pwrLabel.implicitWidth + 20 * root.sf
                    height: 28 * root.sf
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    border.color: pwrMouse.containsMouse ? root.redC : root.goldDim
                    border.width: 1

                    Text {
                        id: pwrLabel
                        anchors.centerIn: parent
                        text: pwrBtn.modelData.label
                        color: pwrMouse.containsMouse ? root.redC : root.goldText
                        font.family: root.monoName
                        font.pixelSize: 11 * root.sf
                        font.letterSpacing: 2 * root.sf
                    }

                    MouseArea {
                        id: pwrMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (pwrBtn.modelData.action === "reboot") sddm.reboot()
                            else sddm.powerOff()
                        }
                    }
                }
            }
        }
    }

    Popup {
        id: sessionPopup
        x: 30 * root.sf
        y: root.height - height - 50 * root.sf
        width: 260 * root.sf
        height: Math.min(sessionList.contentHeight + 8, 220 * root.sf)
        padding: 1
        background: Rectangle {
            color: "#f7050504"
            border.color: root.goldDim
            border.width: 1
        }

        ListView {
            id: sessionList
            anchors.fill: parent
            clip: true
            model: typeof sessionModel !== "undefined" ? sessionModel : null

            delegate: ItemDelegate {
                id: sessionEntry
                required property int index
                required property string modelData
                width: sessionList.width
                height: 30 * root.sf

                contentItem: Text {
                    text: sessionEntry.modelData
                    color: sessionIdx === sessionEntry.index ? root.gold : root.dimC
                    font.family: root.monoName
                    font.pixelSize: 12 * root.sf
                    font.letterSpacing: 2 * root.sf
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 12 * root.sf
                }

                background: Rectangle {
                    color: sessionEntry.hovered ? "#14ffcc00" : "transparent"
                }

                onClicked: {
                    sessionIdx = index
                    root.selectedSessionName = sessionEntry.modelData.toUpperCase()
                    sessionPopup.close()
                }
            }

            Component.onCompleted: {
                positionViewAtIndex(sessionIdx, ListView.Beginning)
                if (currentItem) root.selectedSessionName = currentItem.modelData.toUpperCase()
            }
        }
    }

    // ---------- overlays ----------
    EmergencyOverlay {
        id: emergency
        visible: false
        z: 90
    }

    Rectangle { id: flashRed; anchors.fill: parent; color: "#40e10600"; opacity: 0; z: 80 }
    Rectangle { id: flashGold; anchors.fill: parent; color: "#40ffcc00"; opacity: 0; z: 80 }
    Rectangle { id: flashWhite; anchors.fill: parent; color: "#66ffffff"; opacity: 0; z: 80 }

    Item {
        id: stampBox
        z: 95
        anchors.centerIn: parent
        rotation: -5
        opacity: 0
        visible: false

        Rectangle {
            width: stampText.implicitWidth + 68 * root.sf
            height: stampText.implicitHeight + 24 * root.sf
            color: "#bf000000"
            border.color: stampText.color
            border.width: 3
        }
        Rectangle {
            width: stampText.implicitWidth + 56 * root.sf
            height: stampText.implicitHeight + 12 * root.sf
            anchors.centerIn: parent
            color: "transparent"
            border.color: stampText.color
            border.width: 1
        }
        Text {
            id: stampText
            anchors.centerIn: parent
            color: root.gold
            text: ""
            font.family: "Noto Serif CJK JP"
            font.weight: Font.Black
            font.pixelSize: 40 * root.sf
            font.letterSpacing: 8 * root.sf
        }

        SequentialAnimation {
            id: stampAnim
            ParallelAnimation {
                NumberAnimation { target: stampBox; property: "opacity"; to: 1; duration: 150 }
                NumberAnimation { target: stampBox; property: "scale"; from: 1.3; to: 1; duration: 150; easing.type: Easing.OutBack }
            }
            PauseAnimation { duration: 1200 }
            NumberAnimation { target: stampBox; property: "opacity"; to: 0; duration: 350 }
            ScriptAction { script: stampBox.visible = false }
        }
    }

    function showStamp(text, ok) {
        stampText.text = text
        stampText.color = ok ? root.gold : root.redC
        stampBox.scale = 1.3
        stampBox.opacity = 0
        stampBox.visible = true
        stampAnim.restart()
    }

    function doFlash(which) {
        var r = which === "red" ? flashRed : which === "gold" ? flashGold : flashWhite
        flashSeq.target = r
        flashSeq.restart()
    }

    SequentialAnimation {
        id: flashSeq
        property var target: flashRed
        alwaysRunToEnd: true
        NumberAnimation { target: flashSeq.target; property: "opacity"; from: 1; to: 0; duration: 600 }
    }

    // ---------- splash ----------
    SplashCard {
        id: splash
        z: 130
        visible: true
        onDismissed: pwField.forceActiveFocus()
    }

    // ---------- logic ----------
    function selectUser(idx) {
        userList.currentIndex = idx
        var u = userModel.get(idx)
        if (u) selectedName = u.name
        pwField.forceActiveFocus()
    }

    function tryLogin() {
        if (authBusy) return
        if (selectedName.length === 0) {
            showStamp("ENTRY REQUIRED", false)
            shakeAnim.restart()
            return
        }
        if (pwField.text.length === 0) {
            doFlash("red")
            showStamp("ENTRY REQUIRED", false)
            shakeAnim.restart()
            return
        }
        authBusy = true
        sddm.login(selectedName, pwField.text, sessionIdx)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            authBusy = false
            pwField.text = ""
            emergency.show()
            shakeAnim.restart()
        }
        function onLoginSucceeded() {
            doFlash("white")
            showStamp("ACCESS GRANTED · 同期率100%", true)
        }
    }

    Timer {
        interval: 600
        running: true
        onTriggered: if (!splash.visible) pwField.forceActiveFocus()
    }
}
