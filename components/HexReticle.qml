import QtQuick

Item {
    id: root
    property color accent: "#e10600"
    property color gold: "#66ffcc00"

    Canvas {
        id: staticLayer
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            var w = width, h = height
            var s = Math.min(w, h) / 100

            ctx.strokeStyle = root.accent
            ctx.lineWidth = 0.7 * s
            hex(ctx, w/2, h/2, 47 * s)

            ctx.strokeStyle = Qt.rgba(225/255, 6/255, 0, 0.55)
            ctx.lineWidth = 0.35 * s
            hex(ctx, w/2, h/2, 39.5 * s)

            ctx.strokeStyle = root.accent
            ctx.lineWidth = 0.55 * s
            ctx.beginPath()
            ctx.moveTo(w/2, h/2 - 23 * s)
            ctx.lineTo(w/2 + 19 * s, h/2 + 11.5 * s)
            ctx.lineTo(w/2 - 19 * s, h/2 + 11.5 * s)
            ctx.closePath()
            ctx.stroke()

            ctx.strokeRect(w/2 - 2.5 * s, h/2 - 2.5 * s, 5 * s, 5 * s)
            ctx.fillStyle = root.accent
            ctx.beginPath()
            ctx.arc(w/2, h/2, 1.1 * s, 0, Math.PI * 2)
            ctx.fill()

            ctx.strokeStyle = root.gold
            ctx.lineWidth = 0.3 * s
            var ticks = [[0,-1],[0,1],[-1,-0.5],[-1,0.5],[1,-0.5],[1,0.5]]
            for (var i = 0; i < ticks.length; i++) {
                var t = ticks[i]
                var r1 = 47 * s, r2 = 38 * s
                ctx.beginPath()
                ctx.moveTo(w/2 + t[0] * r1, h/2 + t[1] * r1)
                ctx.lineTo(w/2 + t[0] * r2, h/2 + t[1] * r2)
                ctx.stroke()
            }
        }

        function hex(ctx, cx, cy, r) {
            ctx.beginPath()
            for (var i = 0; i < 6; i++) {
                var a = Math.PI / 180 * (60 * i - 90)
                var x = cx + r * Math.cos(a), y = cy + r * Math.sin(a)
                if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y)
            }
            ctx.closePath()
            ctx.stroke()
        }
    }

    Item {
        anchors.fill: parent
        RotationAnimation on rotation {
            from: 0; to: 360
            duration: 70000
            loops: Animation.Infinite
            running: root.visible
        }
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                var r = Math.min(width, height) / 2 * 0.86
                ctx.strokeStyle = root.gold
                ctx.lineWidth = 0.35 * Math.min(width, height) / 100
                ctx.setLineDash([2.5 * Math.min(width,height)/100, 3 * Math.min(width,height)/100])
                ctx.beginPath()
                ctx.arc(width/2, height/2, r, 0, Math.PI * 2)
                ctx.stroke()
            }
        }
    }
}
