import QtQuick
import org.kde.plasma.plasma5support as PlasmaCore


PlasmaCore.DataSource {
    engine: "executable"
    connectedSources: []

    enum ItemType {
        Unknown,
        ColourThemes,
        PlasmaThemes
    }

    property int lastItemType: ConfigAppearanceDataSource.ItemType.Unknown
    property var typesToFetch: []

    signal itemsReady(var items, var itemType)

    onNewData: (sourceName, data) => {
        disconnectSource(sourceName); // cmd finished

        if (lastItemType == ConfigAppearanceDataSource.ItemType.Unknown)
            return;

        itemsReady(parseCommandOutput(data), lastItemType);
        processNextFetchRequest();
    }

    // Functions //

    function getItems() {
        // TODO: Find a better way of doing this
        typesToFetch = [
            ConfigAppearanceDataSource.ItemType.ColourThemes,
            ConfigAppearanceDataSource.ItemType.PlasmaThemes
        ];

        processNextFetchRequest();
    }

    function getItemsForType(itemType) {
        if (itemType == ConfigAppearanceDataSource.ItemType.Unknown) {
            processNextFetchRequest();
            return;
        }

        this.lastItemType = itemType;

        switch (itemType) {
            case ConfigAppearanceDataSource.ItemType.ColourThemes:
                connectSource("plasma-apply-colorscheme --list-schemes | tail --lines=+2");
                break;

            case ConfigAppearanceDataSource.ItemType.PlasmaThemes:
                connectSource("plasma-apply-desktoptheme --list-themes | tail --lines=+2");
                break;
        }
    }

    function processNextFetchRequest() {
        if (typesToFetch.length < 1)
            return;

        getItemsForType(typesToFetch.pop());
    }

    function parseCommandOutput(data) {
        var items = data["stdout"].split("\n");

        for (var i = 0; i < items.length; i++) {
            items[i] = items[i]
                .substring(3)
                .split(" ")[0];
        }

        return items;
    }
}