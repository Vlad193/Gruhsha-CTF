const SColor BLACK = SColor(0xFF000000);
const SColor GRAY = SColor(0xFFCFCFCF);
const SColor WHITE = SColor(0xFFFFFFFF);
const SColor BLUE = SColor(0xFF1A6F9E);
const SColor RED = SColor(0xFFBA2721);

void Text(const string text, Vec2f pos, SColor color) {
    GUI::DrawText(text, pos, color);
}

void Icon(const string icon, Vec2f pos) {}

void TextButton(const string text, Vec2f tl, Vec2f br) {
    GUI::DrawPane(tl, br, GRAY);
    GUI::DrawTextCentered(text, Vec2f(tl.x + ((br.x - tl.x) * 0.50f), tl.y + ((br.y - tl.y) * 0.50f)), WHITE);
}

void IconButton() {}

void TextPanel(const string text, Vec2f tl, Vec2f br) {
    GUI::DrawPane(tl, br, GRAY);
    GUI::DrawTextCentered(text, Vec2f(tl.x + ((br.x - tl.x) * 0.50f), tl.y + ((br.y - tl.y) * 0.50f)), WHITE);
}

void IconPanel() {}