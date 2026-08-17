import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Io


       ShellRoot {
       
           SystemClock {
               id: globalClock
               precision: SystemClock.Seconds
           }
       
       
           Component.onCompleted: {
               console.log("HYPRLAND:", Object.keys(Hyprland))
           }
       
       
           Process {
               id: clickRunner
        running: false
    }

    function runCmd(cmdString) {
        clickRunner.running = false;
        clickRunner.command = ["sh", "-c", cmdString];
        clickRunner.running = true;
    }



    component SimpleCommandButton : MouseArea {

        property string command
        property alias text: buttonText.text
        property alias textColor: buttonText.color

        width: 35
        height: 26

        cursorShape: Qt.PointingHandCursor

        onClicked: runCmd(command)


        Rectangle {

            anchors.fill: parent

            radius: 4

            color:
            parent.containsMouse
            ?
            "#313244"
            :
            "transparent"



            Text {

                id: buttonText

                anchors.centerIn: parent

                font.pointSize: 11

                font.family:
                "Symbols Nerd Font, Noto Color Emoji, sans-serif"
            }
        }
    }



   component ScriptWidget : MouseArea {

    property string scriptPath
    property string clickCommand
    property string defaultIcon


    width: contentLayout.implicitWidth + 90
    height: 26

    cursorShape: Qt.PointingHandCursor


    onClicked:
    runCmd(clickCommand)



    Process {

        id: scriptProc


        command:
        [
            "bash",
            "-c",
            scriptPath
        ]


        running: true



        stdout: SplitParser {

            onRead: data => {

                
             
                outputText.text =
                defaultIcon + " " + data.trim()
            }
        }
    }



    Timer {

        interval: 30000

        running: true

        repeat: true


        onTriggered: {

            scriptProc.running = false

            scriptProc.running = true
        }
    }



    RowLayout {

        id: contentLayout


        anchors.centerIn: parent

        spacing: 5



        Text {

            id: outputText


            text:
            defaultIcon + " --"


            color:
            "#cdd6f4"


            font.pointSize:
            10


            font.family:
            "Symbols Nerd Font, Noto Color Emoji, sans-serif"
        }
    }
}


    component MyBar : PanelWindow {


        property int startWorkspace: 1

        property int endWorkspace: 5



        anchors {

            top: true

            left: true

            right: true
        }



        implicitHeight: 34


        color:
        "#1e1e2e"



        RowLayout {

            anchors.fill: parent


            anchors.leftMargin: 15

            anchors.rightMargin: 15


            spacing: 0



            RowLayout {


                Layout.fillWidth: true

                Layout.preferredWidth: 1


                Layout.alignment:
                Qt.AlignLeft | Qt.AlignVCenter



                spacing: 8



                SimpleCommandButton {

                    text:
                    ""

                    textColor:
                    "#cba6f7"


                    command:
                    "rofi -show drun"
                }



                SimpleCommandButton {

                    text:
                    ""

                    textColor:
                    "#a6e3a1"


                    command:
                    "/home/georg/.local/bin/waypaper"
                }                Row {

                    spacing: 6


                    Repeater {

                        model: Hyprland.workspaces



                        delegate: Rectangle {


                            visible: {

                                var num =
                                parseInt(modelData.name)

                                return (
                                    num >= startWorkspace
                                    &&
                                    num <= endWorkspace
                                )
                            }


                            width:
                            visible ? 24 : 0


                            height:
                            visible ? 24 : 0


                            radius: 12
                        
                    color: {
                     
                         var occupied = false
                     
                         for (var i = 0; i < Hyprland.toplevels.values.length; i++) {
                     
                             var client = Hyprland.toplevels.values[i]
                     
                             if (client.workspace && client.workspace.id === modelData.id) {
                                 occupied = true
                                 break
                             }
                         }
                     
                     
                         if (occupied && modelData.active)
                             return "#4fa86b"   // grün = aktiv + Fenster
                     
                     
                         if (occupied)
                             return "#89b4fa"   // blau = Fenster vorhanden
                     
                     
                         return "#313244"       // schwarz = leer
                     }

                            MouseArea {

                                anchors.fill: parent

                                cursorShape:
                                Qt.PointingHandCursor


                                onClicked:
                                modelData.activate()
                            }



                            Text {

                                anchors.centerIn: parent


                                text:
                                modelData.name


                                color:

                                parent.color ==
                                
                                "#a6e3a1"
                                ?
                                "#11111b"
                                :
                                "#cdd6f4"



                                font.bold:
                                parent.color == "#a6e3a1"
                            }
                        }
                    }
                }
            }



            // Uhr mittig

            Item {

                Layout.fillWidth: true

                Layout.preferredWidth: 1



                Text {

                    anchors.centerIn: parent


                    text:

                    Qt.formatDateTime(
                        globalClock.date,
                        "hh:mm:ss  |  dd.MM.yyyy"
                    )


                    color:
                    "#cdd6f4"


                    font.pointSize:
                    11


                    font.bold:
                    true
                }
            }



            // Rechte Seite

            RowLayout {


                Layout.fillWidth: true

                Layout.preferredWidth: 1


                Layout.alignment:
                Qt.AlignRight | Qt.AlignVCenter



                spacing: 18



                MouseArea {

                    width: 45

                    height: 26


                    cursorShape:
                    Qt.PointingHandCursor


                    property int layoutState: 0



                    onClicked: {

                        runCmd(
                        "hyprctl switchxkblayout logitech-wireless-keyboard-pid:0068 next"
                        )


                        layoutState =
                        (layoutState + 1) % 3
                    }



                    Rectangle {

                        anchors.fill: parent


                        color:
                        "#313244"


                        radius: 4



                        Text {

                            anchors.centerIn: parent


                            text: {

                                if (
                                parent.parent.layoutState === 1
                                )
                                    return "DE"


                                if (
                                parent.parent.layoutState === 2
                                )
                                    return "GR"


                                return "US"
                            }


                            color:
                            "#f9e2af"


                            font.pointSize:
                            10


                            font.bold:
                            true
                        }
                    }
                }



                // Updates

                ScriptWidget {

                    width: 55

                    defaultIcon:
                    "󰚰"



                    scriptPath:

                    "bash /home/georg/.local/bin/updates.sh"



                    clickCommand:

                    "kitty --class floating bash -c '/home/georg/.local/bin/installupdates.sh'"
                }



                // Wetter

                ScriptWidget {

                     width: 90

                    defaultIcon:
                    ""



                    scriptPath:

                   "bash /home/georg/.local/bin/weather.sh"


                    clickCommand:

                    "kitty --class weather-floating bash -c '/home/georg/.local/bin/wttr.sh'"
                }                // Speicher

                 Text {

                    id: diskText
                    color: "#cdd6f4"
                
                    font.pointSize: 10
                
                    text: "--"
                
                    Process {
                
                        command:
                        [
                            "bash",
                            "-c",
                            "df -h / | awk 'NR==2 {print $5}'"
                        ]
                
                        running: true
                
                
                        stdout: SplitParser {
                
                            onRead: data => {
                                diskText.text = data.trim()
                            }
                        }
                    }
                }



                // PipeWire

                Rectangle {


                    width:
                    75


                    height:
                    26


                    radius:
                    4


                    color:
                    "#313244"



                    Process {


                        id: volProc



                        command:

                        [
                            "bash",
                            "-c",
                            "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)\"%\"}'"
                        ]



                        running:
                        true



                        stdout:

                        SplitParser {


                            onRead:

                            data => {

                                volText.text =
                                data.trim()
                            }
                        }
                    }



                    MouseArea {


                        anchors.fill:
                        parent



                        cursorShape:
                        Qt.PointingHandCursor



                        onClicked:

                        runCmd(
                        "kitty --class floating pulsemixer"
                        )



                        onWheel:

                        wheel => {


                            if (
                            wheel.angleDelta.y > 0
                            )

                                runCmd(
                                "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                                )


                            else

                                runCmd(
                                "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                                )



                            volProc.running = false

                            volProc.running = true
                        }



                        RowLayout {


                            anchors.centerIn:
                            parent



                            spacing:
                            5



                            Text {

                                text:
                                ""


                                color:
                                "#a6e3a1"


                                font.pointSize:
                                10
                            }



                            Text {

                                id: volText


                                text:
                                "--"


                                color:
                                "#cdd6f4"


                                font.pointSize:
                                10
                            }
                        }
                    }
                }



                SimpleCommandButton {

                    text:
                    "⏻"


                    textColor:
                    "#f38ba8"



                    command:

                    "~/.config/rofi/powermenu.sh"
                }
            }
        }
    }



    MyBar {

        screen:

        Quickshell.screens.find(
            s => s.name === "DP-3"
        )


        startWorkspace:
        6


        endWorkspace:
        10
    }



    MyBar {

        screen:

        Quickshell.screens.find(
            s => s.name === "HDMI-A-1"
        )


        startWorkspace:
        1


        endWorkspace:
        5
    }
}