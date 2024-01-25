// TagSystem.as
/*

    Система меток.
    -- -- -- -- -- -- -- -- --
    Позволяет игрокам поставить временную метку в любом месте,
    уведомляющая остальных об опасности или том, что необходимо сделать.
    -- -- -- -- -- -- -- -- --
    Список меток:

    Номер         Название
    -- -- -- -- -- -- --
    1             GO HERE
    2             DIG HERE
    3             ATTACK
    4             DANGER
    5             RETREAT
    6             HELP
    7             KEG
    8             WiT SENCE

*/

#include "pathway.as";
#include "TagCommon.as";
//#include "BindingsCommon.as";

string tag_pos = " tag_pos";
string tag_duration = " tag_time";
string tag_variable = " tag_unit";
string tag_cmd_id   = "add_tag";

string path_string = getPath();
string soundsdir = path_string + "Sounds/Tags/";

s32 time_without_fade = 30;

CPlayer@ GetPlayerByIdent(string ident) {
    // Takes an identifier, which is a prefix of the player's character name
    // or username. If there is 1 matching player then they are returned.
    // If 0 or 2+ then a warning is logged.
    ident = ident.toLower();
    CPlayer@[] matches; // players matching ident

    for (int i=0; i < getPlayerCount(); i++) {
        CPlayer@ p = getPlayer(i);
        if (p is null) continue;

        string username = p.getUsername().toLower();
        string charname = p.getCharacterName().toLower();

        if (username == ident || charname == ident) {
            return p;
        }
        else if (username.find(ident) >= 0 || charname.find(ident) >= 0) {
            matches.push_back(p);
        }
    }

    if (matches.length == 1) {
        return matches[0];
    }

    return null;
}

void SendTag(CRules@ rules, CControls@ controls, CPlayer@ player, s32 kind, Vec2f custom_pos = Vec2f_zero)
{
    CPlayer@ localplayer = getLocalPlayer();
    bool player_doesnt_see_tags   = rules.get_bool(player.getUsername() + "tag_hidden");

    if (player_doesnt_see_tags) return;

    Vec2f pos = controls.getMouseWorldPos();

    if (custom_pos != Vec2f_zero)
    {
        pos = custom_pos;
    }

    CBitStream params;
    params.write_netid(player.getNetworkID());
    params.write_Vec2f(pos);
    params.write_u32(getGameTime());
    params.write_s32(kind);

    rules.SendCommand(rules.getCommandID(tag_cmd_id), params);
}

// show tag only to teammates/spectators
bool shouldShowIndicator(CRules@ rules, CPlayer@ tag_initiator)
{
    CPlayer@ my_player = getLocalPlayer();

    if (my_player !is null && my_player.isMyPlayer())
    {
        int my_team_num = my_player.getTeamNum();
        if (((my_team_num == rules.getSpectatorTeamNum()) || (my_team_num == tag_initiator.getTeamNum()))) return true;
    }

    return false;
}

void onCommand(CRules@ rules, u8 cmd, CBitStream @params)
{
    if (cmd == rules.getCommandID(tag_cmd_id))
    {
        CPlayer@ player = getPlayerByNetworkId(params.read_netid());
        CPlayer@ localplayer = getLocalPlayer();
        string name = player.getUsername();

        bool player_doesnt_see_tags   = rules.get_bool(player.getUsername() + "tag_hidden");
        if (player_doesnt_see_tags) return;

        Vec2f pos  = params.read_Vec2f();
        u32 time = params.read_u32();
        s32 kind = params.read_s32();

        if (isClient())
        {
            if (kind == 0)
            {
                rules.set_Vec2f(name + tag_pos, pos);
                rules.set_u32(name + tag_duration, getGameTime());
                rules.set_s32(name + tag_variable, kind);
            }

            rules.set_Vec2f(name + tag_pos, pos);
            rules.set_u32(name + tag_duration, getGameTime());
            rules.set_s32(name + tag_variable, kind);
        }

        if (shouldShowIndicator(rules, player))
        {

            CPlayer@ localplayer = getLocalPlayer();
            bool player_is_muted = rules.get_bool(player.getUsername() + "is_tag_muted");
            bool localplayer_is_deaf = rules.get_bool(localplayer.getUsername() + "is_deaf");
            u32 time_since_last_tag = getGameTime() - rules.get_u32(player.getUsername() + "last_tag");
            u32 tag_cooldown = rules.get_u32(player.getUsername() + "tag_cooldown_time");

            if (player_is_muted == false)
            {

                rules.set_u32(player.getUsername() + "last_tag", getGameTime());
                int upd_cooldown = 30;

                if (player.isMod())
                {
                    upd_cooldown = 8;
                }

                if      (kind == 1) { Sound::Play(soundsdir + "placeholder", pos, 3.0f); }
                else if (kind == 2) { Sound::Play(soundsdir + "placeholder", pos, 3.0f); }
                else if (kind == 3) { Sound::Play(soundsdir + "placeholder", pos, 3.0f); }
                else if (kind == 4) { Sound::Play(soundsdir + "placeholder", pos, 3.0f); }
                else if (kind == 5) { Sound::Play(soundsdir + "placeholder", pos, 3.0f); }
                else if (kind == 6) { Sound::Play(soundsdir + "placeholder", pos, 3.0f); }
                else if (kind == 7) { Sound::Play(soundsdir + "placeholder", pos, 3.0f); }
                else if (kind == 8) { Sound::Play(soundsdir + "placeholder_wtf", pos, 3.0f); }

                rules.set_u32(player.getUsername() + "tag_cooldown_time", upd_cooldown);
            }
        }
    }
}



// clear tags on start
void onRestart(CRules@ rules)
{
    for (int player_index = 0;
         player_index < getPlayerCount();
         player_index++) {
        CPlayer@ player = getPlayer(player_index);
        string name = player.getUsername();
        if (rules.exists (name + tag_variable)) {
            rules.set_s32(name + tag_variable, -1);
            // rules.Sync   (name + tag_variable, true);
        }
    }
}

// make same, but on rejoin
void onNewPlayerJoin (CRules@ rules, CPlayer@ player)
{
    string name = player.getUsername();
    if (rules.exists (name + tag_variable)) {
        rules.set_s32(name + tag_variable, -1);
    }
}

string get_font(string chosen_font, s32 size)
{
    string result = chosen_font + "_"+size;
    if (!GUI::isFontLoaded(result))
    {
        string font_name = CFileMatcher(chosen_font + ".ttf").getFirst();
        GUI::LoadFont(result, font_name, size, true);
    }
    return result;
}

void onInit(CRules@ rules)
{
    rules.addCommandID(tag_cmd_id);
}

TagMenu tmenu;

void onTick(CRules@ this)
{
    CPlayer@ p = getLocalPlayer();

    if (p is null || !p.isMyPlayer())
    {
        return;
    }

    CControls@ controls = getControls();

    /*if (true)
    {
         u32 time_since_last_tag = getGameTime() - getRules().get_u32(p.getUsername() + "last_tag");
         u32 tag_cooldown = getRules().get_u32(p.getUsername() + "tag_cooldown_time");

        if ( (time_since_last_tag >= tag_cooldown && !getRules().get_bool(p.getUsername() + "is_tag_muted")) || p.isMod())
        {
                if (controls.isKeyPressed("tag1")) { SendTag(this, controls, p, 1); } // DANGER
                if (controls.isKeyPressed("tag2")) { SendTag(this, controls, p, 2); } // GO
                if (controls.isKeyPressed("tag3")) { SendTag(this, controls, p, 3); } // HOLD
                if (controls.isKeyPressed("tag4")) { SendTag(this, controls, p, 4); } // KEG
                if (controls.isKeyPressed("tag5")) { SendTag(this, controls, p, 5); } // CATCH
                if (controls.isKeyPressed("tag6")) { SendTag(this, controls, p, 6); } // HELP
                if (controls.isKeyPressed("tag7")) { SendTag(this, controls, p, 7); } // ATTACK
                if (controls.isKeyPressed("tag8")) { SendTag(this, controls, p, 8); } // ?
        }
    }*/

    if (controls.isKeyJustPressed(KEY_MBUTTON))
    {
            TagMenu@ menu = TagMenu(controls.getMouseScreenPos());

            TagMenuEntry@ entry = TagMenuEntry("1", controls.getMouseScreenPos());
            entry.visible_name = "GO HERE";
            entry.t_color = SColor( 255, 122,  255,  104);
            menu.add_entry(entry);

            TagMenuEntry@ entry2 = TagMenuEntry("2", controls.getMouseScreenPos());
            entry2.visible_name = "DIG HERE";
            entry2.t_color = SColor( 255, 169,  113,  80);
            menu.add_entry(entry2);

            TagMenuEntry@ entry3 = TagMenuEntry("3", controls.getMouseScreenPos());
            entry3.visible_name = "ATTACK";
            entry3.t_color = SColor( 255, 238,  200,  0);
            menu.add_entry(entry3);

            TagMenuEntry@ entry4 = TagMenuEntry("4", controls.getMouseScreenPos());
            entry4.visible_name = "DANGER";
            entry4.t_color = SColor( 255, 235,  0,  0);
            menu.add_entry(entry4);

            TagMenuEntry@ entry5 = TagMenuEntry("5", controls.getMouseScreenPos());
            entry5.visible_name = "RETREAT";
            entry5.t_color = SColor( 255, 232,  124,  0);
            menu.add_entry(entry5);

            TagMenuEntry@ entry6 = TagMenuEntry("6", controls.getMouseScreenPos());
            entry6.visible_name = "HELP";
            entry6.t_color = SColor( 255, 169,  235,  255);
            menu.add_entry(entry6);

            TagMenuEntry@ entry7 = TagMenuEntry("7", controls.getMouseScreenPos());
            entry7.visible_name = "KEG";
            entry7.t_color = SColor( 255, 255,  126,  126);
            menu.add_entry(entry7);

            TagMenuEntry@ entry8 = TagMenuEntry("8", controls.getMouseScreenPos());
            entry8.visible_name = "WiT SENCE";
            entry8.t_color = SColor( 255,  255, 255, 255);
            menu.add_entry(entry8);

            tmenu = menu;

    }

    if (controls.isKeyPressed(KEY_MBUTTON))
    {
        tmenu.update();
    }

    else if (controls.isKeyJustReleased(KEY_MBUTTON) && tmenu !is null)
    {
        TagMenuEntry@ selected = tmenu.get_selected();
        if (selected !is null)
        {
            SendTag(this, controls, p, parseInt(selected.name), tmenu.world_origin);
        }
        else
        {
            SendTag(this, controls, p, 0);
        }
    }
}


void onRender(CRules@ rules)
{
    CPlayer@ p = getLocalPlayer();

    if (p !is null && p.isMyPlayer())
    {
        CControls@ controls = getControls();

        if (controls !is null)
        {
            if (controls.isKeyPressed(KEY_MBUTTON))
            {
                GUI::SetFont("menu");
                tmenu.render();
            }
        }
    }

    for (int player_index = 0; player_index < getPlayerCount(); player_index++)
    {
        CPlayer@ player = getPlayer(player_index);

        string name = player.getUsername();

        if (!rules.exists(name + tag_pos)) continue;
        if (!rules.exists(name + tag_duration)) continue;
        if (!rules.exists(name + tag_variable)) continue;

        bool player_is_muted = rules.get_bool(player.getUsername() + "is_tag_muted");

        // tent swap class without pressing 'e'
        // moving more than 2 tunnels over doesn't clearmenus

        if (!shouldShowIndicator(rules, player)) continue;

        s32 tag_time = s32(rules.get_u32(name + tag_duration));
        s32 time_elapsed = getGameTime() - tag_time;

        int tag_period = 10;
        if (time_elapsed < 0) continue;
        if (time_elapsed > tag_period + time_without_fade) continue; // stop drawing the indicator after some time
        
        Vec2f tag_world_pos = rules.get_Vec2f(name + tag_pos);
        Vec2f tag_screen_pos = getDriver().getScreenPosFromWorldPos(tag_world_pos);
        
        s32 tag_unit = rules.get_s32(name + tag_variable);
        if (tag_unit < 0) continue;
        if (tag_unit > 59) continue; //

        SColor tag_text_color = SColor(   0,   0,   0,   0);
        SColor tag_active_color = SColor( 255,  255, 255, 255);

        float alpha;

        CCamera@ camera = getCamera();

        if (camera is null) return;

        float screen_size_x = getDriver().getScreenWidth();
        float screen_size_y = getDriver().getScreenHeight();
        float resolution_scale = camera.targetDistance * (screen_size_y / 720.f); // NOTE(hobey): scaling relative to 1280x720

        float resolution_modifier_big = resolution_scale * 0.225f;

        if (time_elapsed == 0) resolution_modifier_big *= 5.5;
        if (time_elapsed == 1) resolution_modifier_big *= 5;
        if (time_elapsed == 2) resolution_modifier_big *= 4;

        if (time_elapsed <= time_without_fade)
        {
            alpha = 1;
        }
        else if (time_elapsed > time_without_fade)
        {
            alpha = float(tag_period - (time_elapsed - time_without_fade)) / float(tag_period);
        }

        if (tag_unit == 0) continue;

        string player_display_name = player.getUsername();

        string tag_quote = "uninitialized phrase";

        /////////////////////////////////////////////////////////
        // tag list
        if (tag_unit == 1)
        { tag_quote = "GO HERE"; tag_active_color = SColor( 255, 122,  255,  104); }
        if (tag_unit == 2)
        { tag_quote = "DIG HERE"; tag_active_color = SColor( 255, 169,  113,  80); }
        if (tag_unit == 3)
        { tag_quote = "ATTACK"; tag_active_color = SColor( 255, 238,  200,  0); }
        if (tag_unit == 4)
        { tag_quote = "DANGER"; tag_active_color = SColor( 255, 235,  0,  0); }
        if (tag_unit == 5)
        { tag_quote = "RETREAT!"; tag_active_color = SColor( 255, 232,  124,  0); }
        if (tag_unit == 6)
        { tag_quote = "HELP"; tag_active_color = SColor( 255, 169,  235,  255); }
        if (tag_unit == 7)
        { tag_quote = "KEG"; tag_active_color = SColor( 255, 255,  126,  126); }
        if (tag_unit == 8)
        { tag_quote = "WiT SENCE"; tag_active_color = SColor( 255, 255,  255,  255); }
        /////////////////////////////////////////////////////////

        if (getLocalPlayer() !is null)
        {
            if (getLocalPlayer().getBlob() !is null)
            {
                f32 distance = (tag_world_pos - getLocalPlayer().getBlob().getPosition()).Length(); 
            }
        }

        SColor tag_quote_color = tag_active_color.getInterpolated(tag_text_color, alpha);
        SColor name_color   = tag_active_color.getInterpolated(tag_text_color, alpha/* * .80f*/);

        if (player_is_muted == false)
        {
            if (getLocalPlayer() !is null)
            {
                if (getLocalPlayer().getBlob() !is null)
                {
                    if (time_elapsed <= 15)
                    {
                        f32 distance = (tag_world_pos - getLocalPlayer().getBlob().getPosition()).Length();
                        if (distance < 400.0f)
                        {
                            Vec2f player_screen_pos = getDriver().getScreenPosFromWorldPos(getLocalPlayer().getBlob().getPosition());

                            GUI::DrawLine2D(tag_screen_pos, player_screen_pos, tag_quote_color);
                        }
                    }
                }
            }

            string tag_quote_font = get_font("AveriaSerif-Regular", s32(16.f * (screen_size_y / 720.f)));
            string player_display_name_font = get_font("DejaVuSans-Bold", s32(12.f * (screen_size_y / 720.f)));

            player_display_name = "<" + player_display_name + ">";

            // draw tag text
            GUI::SetFont(tag_quote_font);
            Vec2f text_dimensions_0;
            GUI::GetTextDimensions(tag_quote, text_dimensions_0);


            GUI::DrawIcon("PingIcon.png", 0, Vec2f(64, 64), tag_screen_pos - Vec2f(64 * resolution_modifier_big, 64 * resolution_modifier_big) + Vec2f(0, Maths::Sin(getGameTime() / 3.0f) * 4), resolution_modifier_big, tag_quote_color);

            // draw the indicator at the edge of the screen if it's off-screen
            // the player_display_name can still go off the screen at the moment
            if (tag_screen_pos.x < text_dimensions_0.x * .5f)
            {
                tag_screen_pos.x = text_dimensions_0.x * .5f;
            }
            if (tag_screen_pos.y < text_dimensions_0.y * .5f)
            {
                tag_screen_pos.y = text_dimensions_0.y * .5f;
            }
            if (tag_screen_pos.x >= screen_size_x - text_dimensions_0.x * .5f)
            {
                tag_screen_pos.x  = screen_size_x - text_dimensions_0.x * .5f;
            }
            if (tag_screen_pos.y >= screen_size_y - text_dimensions_0.y * .5f)
            {
                tag_screen_pos.y  = screen_size_y - text_dimensions_0.y * .5f;
            }

            GUI::SetFont(tag_quote_font);
            GUI::DrawText(tag_quote, tag_screen_pos - text_dimensions_0 * .5f - Vec2f(0.f, text_dimensions_0.y - 2 * resolution_scale) + Vec2f(2, 2) + Vec2f(0, Maths::Sin(getGameTime() / 3.0f) * 4), SColor(255, 0, 0, 0));
            GUI::DrawText(tag_quote, tag_screen_pos - text_dimensions_0 * .5f - Vec2f(0.f, text_dimensions_0.y - 2 * resolution_scale) + Vec2f(0, Maths::Sin(getGameTime() / 3.0f) * 4), tag_quote_color);

            //draw player name
            GUI::SetFont(player_display_name_font);
            Vec2f text_dimensions_1;
            GUI::GetTextDimensions(player_display_name, text_dimensions_1);
            GUI::DrawText(player_display_name, tag_screen_pos - text_dimensions_1 * .5f + Vec2f(0.f, text_dimensions_0.y - 8 * resolution_scale) + Vec2f(0, Maths::Sin(getGameTime() / 3.0f) * 4), name_color);
        }
    }
}
