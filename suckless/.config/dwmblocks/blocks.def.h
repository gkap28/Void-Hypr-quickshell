//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	//{"TeamViewer", "~/.config/.local/bin/teamviewer-status.sh", 60, 0},
	{" 🌞 ",       "/home/georg/.local/bin/scripts/weather.sh",    90,     0}, 
	{" ",       "/home/georg/.local/bin/scripts/internet.sh",   1,       5}, 
	{" 📢 ",       "/home/georg/.config/dwmblocks/volume.conf",    0,       8},
	{" 💾 ",       "/home/georg/.config/dwmblocks/disk.sh",        1,       0 },
	//{" 💾 ",       "~/.config/dwmblocks/memory.sh",      1,     0 },
	{" 🕛 ", "date '+%b %d (%a) %H:%M:%S'",                        1,     1},


};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
