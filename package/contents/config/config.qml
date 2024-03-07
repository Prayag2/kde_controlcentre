import org.kde.plasma.plasmoid
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("Appearance")
        icon: "preferences-desktop-color"
        source: "config/configAppearance.qml"
    }
    ConfigCategory {
        name: i18n("Behaviour")
        icon: "preferences-desktop"
        source: "config/configBehaviour.qml"
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
