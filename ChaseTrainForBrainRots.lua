local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart

local Window = Rayfield:CreateWindow({
   Name = "Brainrot remover",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Max",
   ShowText = "Rayfield", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   -- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

local MainTab = Window:CreateTab("Hacks", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

local Button = MainTab:CreateButton({
   Name = "tp to end",
   Callback = function()
   rootPart.CFrame = CFrame.new(-169, 31, 3129)
   end,
})

local Button = MainTab:CreateButton({
   Name = "tp to train",
   Callback = function()
   rootPart.CFrame = CFrame.new(5.97769451, 9.94454384, 118.347977, -0.025869254, 1.00549975e-07, 0.99966532, 3.08066568e-08, 1, -9.97864262e-08, -0.99966532, 2.82149468e-08, -0.025869254)
   end,
})

local Button = MainTab:CreateButton({
   Name = "Give best coil",
   Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer -- alleen in testmodus/Command Bar

local tool = ReplicatedStorage.Assets.Tools["Radio Active Coil"]:Clone()
tool.Parent = player.Backpack
   end,
})

local Button = MainTab:CreateButton({
   Name = "Open Item Giver (Only local)",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/maxmuestar/RobloxScirpts/refs/heads/main/ChaseTrainForBrainrots%20/itemgiver.lua"))()
   end,
})
