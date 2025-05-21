local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local Window = redzlib:MakeWindow({
    Title = "ETO Hub",
    SubTitle = "by ETO",
    SaveFolder = "ETO_Config",
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://71014873973869", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

redzlib:SetTheme("Dark")

-- Tab 1: أدوات متنوعة
local Tab1 = Window:MakeTab({"الأدوات", "Tools"})
Window:SelectTab(Tab1)

Tab1:AddSection({"عام"})
Tab1:AddParagraph({"معلومات", "سكربت مقدم من ETO\nواجهة احترافية باستخدام RedzHub"})

Tab1:AddButton({"Print رسالة", function() print("Hello World!") end})

Tab1:AddToggle({
    Name = "Anti-AFK",
    Description = "منع الطرد بسبب الخمول",
    Default = false,
    Callback = function(v)
        if v then
            local vu = game:service('VirtualUser')
            game:service('Players').LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

Tab1:AddSlider({
    Name = "السرعة",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

Tab1:AddButton({"تشغيل الطيران", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/4XcMN3qB"))()
end})

-- Tab 2: تليبور ذكي
local Tab2 = Window:MakeTab({"التنقل", "Teleport"})

local selectedPlayer = nil
local profileImage = nil
local playerNameLabel = nil

Tab2:AddTextBox({
    Name = "اسم اللاعب أو أول 3 حروف",
    PlaceholderText = "مثال: eto",
    Callback = function(input)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if string.sub(string.lower(player.Name), 1, #input) == string.lower(input) then
                selectedPlayer = player
                break
            end
        end

        if selectedPlayer then
            local userId = selectedPlayer.UserId
            profileImage = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

            Tab2:AddParagraph({"اللاعب المحدد", selectedPlayer.Name})
            Tab2:AddImage({ Image = profileImage, Size = UDim2.new(0, 100, 0, 100) })
        else
            Tab2:AddParagraph({"خطأ", "لم يتم العثور على لاعب بهذا الاسم"})
        end
    end
})

Tab2:AddButton({"تنقّل إلى اللاعب", function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character:MoveTo(selectedPlayer.Character.HumanoidRootPart.Position)
    else
        warn("لا يمكن التليبور. اللاعب غير موجود حالياً.")
    end
end})
