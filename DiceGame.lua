-- Welcome to DiceGame, the dankest game ever
-- "10k dice game let's fuckin go" - Zanizan
-- Author: Zanizan
local DiceGame_LastRoll = 100;
local DiceGame_RollEventFrame = CreateFrame("Frame");

function DiceGame_OnLoad()
	SlashCmdList["DICEGAME"] = StartDiceGame;

	SLASH_DICEGAME1 = "/dicegame";
	SLASH_DICEGAME2 = "/dg";
end

function StartDiceGame()
	print("Welcome to Dice Game, brah. 10k lets fuckin go!");

	DiceGame_RollEventFrame:SetScript("OnEvent", CheckIfRoll);
	DiceGame_RollEventFrame:RegisterEvent("CHAT_MSG_SYSTEM");
	DiceGameFrame:Show();
	resetDiceRoll();
end

function StopDiceGame()
	DiceGame_RollEventFrame:UnregisterEvent("CHAT_MSG_SYSTEM");
	DiceGameFrame:Hide();
	resetDiceRoll();
end

function CheckIfRoll(self, event, arg1)
	if arg1:match("rolls") then
		DiceGame_LastRoll = tonumber(string.match(arg1, "%d+"));
		if DiceGame_LastRoll == 1 then
			-- Check if I was the person who rolled the 1
			if (string.match(arg1, UnitName("player")) ~= nil) then
				PlaySoundFile("Sound\\Creature\\Blackknight\\Ac_Blackknight_Slay01.ogg");
				StaticPopup_Show("BERNIE");
			end
			resetDiceRoll();
		end
	end
end

function RollDice()
	RandomRoll(1, DiceGame_LastRoll);
end

function resetDiceRoll()
	DiceGame_LastRoll = 100;
end

StaticPopupDialogs["BERNIE"] = {
  text = "Pay up scrub. This ain't no Bernie Sanders America!",
  button1 = "Right on",
  button2 = "I'm a commie",
  OnCancel = function()
      message("Fuck you!");
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,
}
