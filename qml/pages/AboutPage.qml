import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
 //   tools: backTools
        Column{
            id: column1
            anchors.fill: parent
            anchors.topMargin: Theme.paddingLarge * 2
            spacing: 15

            Image{
                source: "qrc:/tinywebbrowser.png"
                height: 200
                width: 200
                fillMode: Image.PreserveAspectFit
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }
            Text {
                font.pixelSize: 32
                color: "white"
                text: "Version: "+version
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Rectangle{
                gradient: Gradient {
                      GradientStop { position: 0.0; color: "#333333" }
                      GradientStop { position: 1.0; color: "#777777" }
                  }
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: 3
                width: parent.width-64
            }

            Text {
                width: 360
                font.pixelSize: 32
                color: "white"
                text: "<center>Created 2013</center><br />Mike7b4<center></center><br /><center>Heavily based on</center><br /><center>Sailfish component gallery example</center>All credit to Jolla employers and Qt team!"
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                height: 300
            }

            Rectangle{
                gradient: Gradient {
                      GradientStop { position: 0.0; color: "#333333" }
                      GradientStop { position: 1.0; color: "#777777" }
                  }
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: 3
                width: parent.width-64
            }

            Text {
                width: parent.width-70
                font.pixelSize: 20
                color: "gray"
                text: "This app is just a testapp."
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignHCenter
                height: 200
                wrapMode: Text.WordWrap
            }

        }
        MouseArea{
            anchors.fill: parent
            onClicked: pageStack.pop()
        }
}
