void DrawTeamMaterialsIndicator()
{
    if (g_videorecording)
	return;

	CPlayer@ p = getLocalPlayer();
	u8 team = p.getTeamNum();

	if (p is null || !p.isMyPlayer()) { return; }

	if (p.getBlob() !is null && p.getTeamNum() == team)
	{
		GUI::SetFont("hud");
		u16 leftside_indent = 4;
		u16 text_indent = 32;
		u16 material_display_width = 90;
		u16 material_display_height = 40;
		Vec2f icon_dimensions = Vec2f(16, 16);
		string icon = "Materials.png";
		SColor wood_color = SColor(255, 164, 103, 39);
		SColor stone_color = SColor(255, 151, 167, 146);
		SColor gold_color = SColor(255, 254, 165, 61);
		CTeam@ red = getRules().getTeam(1);
		CTeam@ blue = getRules().getTeam(0);
		Vec2f dim = Vec2f(342, 64);
		Vec2f ul(getHUDX() - dim.x / 2.0f, getHUDY() - dim.y + 12);
		ul += Vec2f(-160, -28);

		Vec2f ul2 = ul + Vec2f(0, 40);

		string msg1 = getRules().get_s32("woodpool" + team);
		string msg2 = getRules().get_s32("stonepool" + team);

		SColor dcolor = blue.color;

		if (p.getTeamNum() == 1)
		{
			dcolor = red.color;
		}

		GUI::DrawPane(ul + Vec2f(0, 4), ul + Vec2f(material_display_width+leftside_indent, material_display_height), dcolor);

		GUI::DrawPane(ul2 + Vec2f(0, 4), ul2 + Vec2f(material_display_width+leftside_indent, material_display_height), dcolor);

		//wood
		GUI::DrawIcon(
			icon,
			25, //matwood icon
			icon_dimensions,
			ul2 + Vec2f(leftside_indent, 0),
			1.0f,
			0);
		GUI::DrawText(msg1, ul + Vec2f(leftside_indent*1.5+32, material_display_height/3), color_white);

		//stone
		GUI::DrawIcon(
			icon,
			24, //matstone icon
			icon_dimensions,
			ul + Vec2f(leftside_indent, 0),
			1.0f,
			0);
		GUI::DrawText(msg2, ul2 + Vec2f(leftside_indent*1.5+32, material_display_height/3), color_white);
	}
}