import QtQuick 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "../Components"
import "../Constants"

// Content
ColumnLayout {
    id: root

    property var details

    // Title
    DefaultText {
        text_value: API.get().settings_pg.empty_string + (qsTr("Swap Progress"))
    }

    DefaultText {
        text_value: API.get().settings_pg.empty_string + (qsTr("Events: ") + (!details ? 0 : details.events.length))
    }

    DefaultListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        model: details ? details.events : []

        delegate: ColumnLayout {
            width: root.width
            DefaultText {
                id: name
                font.pixelSize: price_value.font.pixelSize

                text_value: API.get().settings_pg.empty_string + (modelData.state)
                color: Style.colorWhite4
            }
        }
    }
}