// StorageMaterialConverter.as

s32 convert_time_inventory = 45;

///////////////////////////////////////////////
// Converter heart
void onTick(CBlob@ this)
{
    if (!isServer()) return;

    CInventory@ inv = this.getInventory();

    // Convert material, if storage have it in inventory
    if (this !is null && inv !is null) {
    	for (int i = 0; i < inv.getItemsCount(); i++) {
            CBlob@ item = inv.getItem(i);
            const string name = item.getName();

            const int stone_count = inv.getCount("mat_stone");
            const int wood_count = inv.getCount("mat_wood");

            // DEBUG
            /*if (name == "mat_stone") {
                printf("Stone amount in inventory is " + stone_count);
            } else if (name == "mat_wood") {
                printf("Wood amount in inventory is " + wood_count);
            }*/

            if (name == "mat_stone" && getGameTime() > convert_time_inventory * getTicksASecond() + item.get_s32("storage pickup time")) {
                getRules().add_s32("teamstone" + this.getTeamNum(), stone_count);
                inv.server_RemoveItems("mat_stone", stone_count);

                this.getSprite().PlaySound("/mat_converted.ogg");
            } else if (name == "mat_wood" && getGameTime() > convert_time_inventory * getTicksASecond() + item.get_s32("storage pickup time")) {
                getRules().add_s32("teamwood" + this.getTeamNum(), wood_count);
                inv.server_RemoveItems("mat_wood", wood_count);

                this.getSprite().PlaySound("/mat_converted.ogg");
            }
        }
    }
}
///////////////////////////////////////////////
///////////////////////////////////////////////

// Set pickup timer
void onAddToInventory(CBlob@ this, CBlob@ blob)
{
    if (!isServer()) return;

    if (this !is null && blob !is null) {
        if (blob.getConfig() == "mat_stone") {
            blob.set_s32("storage pickup time", getGameTime());
            blob.Sync("storage pickup time", true);

            //printf("Stone pickup time is " + blob.get_s32("pickup time"));
        } else if (blob.getConfig() == "mat_wood") {
            blob.set_s32("storage pickup time", getGameTime());
            blob.Sync("storage pickup time", true);

            //printf("Wood pickup time is " + blob.get_s32("pickup time"));
        }
    }
}