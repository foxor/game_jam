package screens
{
    public class Mission extends Menu
    {
        public function Mission(title:String="TEMP_MENU")
        {
            super(title);
			addOption(0x00FF00, "Easy");
			addOption(0xFFFF00, "Medium");
			addOption(0xFF0000, "Hard");
        }
    }
}
