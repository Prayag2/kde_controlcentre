import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
        name: i18n("Appearance")
        icon: "preferences-desktop-color"
        source: "config/configAppearance.qml"
    }
    ConfigCategory {
        name: i18n("Color schemes")
        icon: "color-picker"
        source: "config/configColorscheme.qml"
        visible: Plasmoid.configuration.showColorSwitcher
    }
    ConfigCategory {
        name: i18n("Support")
        icon: "face-angel"
        source: "config/configSupport.qml"
    }
}
