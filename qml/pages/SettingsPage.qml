import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        id: view
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        Column {
            id: column
            spacing: 5
            width: parent.width

            PageHeader {
                title: qsTr("Settings")
            }


            SectionHeader { text: qsTr("Appearance") }

            TextSwitch {
                id: headerVisibleSwitch
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                text: qsTr("Quick menu enabled")
                description: qsTr("Use it to get more space for text")
                checked: headerVisible
                onCheckedChanged: headerVisible = headerVisibleSwitch.checked;
            }

            TextSwitch {
                id: lineNumbersVisibleSwitch
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                text: qsTr("Line numeration enabled") + "\n" + "(experimental, broken)"
                checked: lineNumbersVisible
                onCheckedChanged: lineNumbersVisible = lineNumbersVisibleSwitch.checked;
            }

            SectionHeader { text: qsTr("Fonts and size") }

            ComboBox {
                label: qsTr("Font size:")
                value: fontSize

                menu: ContextMenu {
                    MenuItem {
                        text: "Medium (default)"
                        onClicked: fontSize = Theme.fontSizeMedium;
                    }
                    MenuItem {
                        text: "Small"
                        onClicked: fontSize = Theme.fontSizeSmall;
                    }
                    MenuItem {
                        text: "Large"
                        onClicked: fontSize = Theme.fontSizeLarge;
                    }
                }
            }

            ComboBox {
                label: qsTr("Font:")
                value: fontType

                menu: ContextMenu {
                    MenuItem {
                        text: "Sail Sans Pro Light (default)"
                        onClicked: fontType = Theme.fontFamily;
                    }
                    MenuItem {
                        text: "Open Sans"
                        onClicked: fontType = "Open Sans";
                    }
                    MenuItem {
                        text: "Helvetica"
                        onClicked: fontType = "Helvetica";
                    }
                    MenuItem {
                        text: "Droid Sans Mono"
                        onClicked: fontType = "Droid Sans Mono";
                    }
                    MenuItem {
                        text: "Comic Sans"
                        onClicked: fontType = "Comic Sans";
                    }
                    MenuItem {
                        text: "Ubuntu"
                        onClicked: fontType = "Ubuntu";
                    }
                    MenuItem {
                        text: "DejaVu Sans Mono"
                        onClicked: fontType = "DejaVu Sans Mono";
                   }
                }
            }

            SectionHeader { text: qsTr("File browser") }

            TextSwitch {
                id: showHiddenFilesSwitch
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                text: qsTr("Show hidden files")
                description: qsTr("Be careful to enable this option!")
                checked: showHiddenFiles
                onCheckedChanged: showHiddenFiles = showHiddenFilesSwitch.checked;
            }

        }
    }

    Component.onDestruction: {
            py2.call('editFile.setValue', ["headerVisible", headerVisible], function(result) {});
            py2.call('editFile.setValue', ["lineNumbersVisible", lineNumbersVisible], function(result) {});

            py2.call('editFile.setValue', ["fontType", fontType], function(result) {});
            py2.call('editFile.setValue', ["fontSize", fontSize], function(result) {});

            py2.call('editFile.setValue', ["showHiddenFiles", showHiddenFiles], function(result) {});
    }
}
