import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
    CreditsModel {id: credits}
    Column{
        id: column1
        anchors.fill: parent
        anchors.topMargin: Theme.paddingLarge * 3
        spacing: 15

        Image{
            source: appicon
            height: 128
            width: 128
            fillMode: Image.PreserveAspectFit
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
        }
        Label {
            font.pixelSize: Theme.fontSizeMedium
            text: appname+" v"+version
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

        Label {
            width: 360
            font.pixelSize: Theme.fontSizeMedium
            text: "Created 2013-2014 by Mike7b4\nUpdated by llelectronics"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignHCenter
            //wrapMode: Text.WordWrap
            //height: Theme.fontSizeMedium * 1 + 20
        }

        Repeater{
            model: credits
            Label  {
                anchors.horizontalCenter: parent.horizontalCenter
                text: title
                font.pixelSize: Theme.fontSizeSmall
            }
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

        Label {
            width: parent.width-70
            font.pixelSize: Theme.fontSizeSmall
            text: qsTr("This app is just a testapp.")
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
