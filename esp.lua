-- Oyuncu etiketlerini görünür hale getirme fonksiyonu
local function enablePlayerESP(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            -- Oyuncu öldüğünde etiketi ve hoş geldin mesajını kaldırın
            local espLine = character:FindFirstChild("ESPLine")
            if espLine then
                espLine:Destroy()
            end
            local welcomeMessage = player:FindFirstChild("WelcomeMessage")
            if welcomeMessage then
                welcomeMessage:Destroy()
            end
        end)

        local rootPart = character:WaitForChild("HumanoidRootPart")
        local espLine = rootPart:FindFirstChild("ESPLine")
        if not espLine then
            espLine = Instance.new("LineHandleAdornment")
            espLine.Name = "ESPLine"
            espLine.From = rootPart.Position
            espLine.To = rootPart.Position + Vector3.new(0, 5, 0) -- Etiketin boyutu
            espLine.Adornee = rootPart
            espLine.AlwaysOnTop = true
            espLine.Transparency = 0.5 -- Etiketin saydamlığı
            espLine.Color3 = Color3.new(1, 0, 0) -- Etiketin rengi (örnek: kırmızı)
            espLine.ZIndex = 5 -- Etiketin diğer nesnelerin üzerine gelmesi
            espLine.Parent = rootPart
        end

        -- Hoş geldin mesajı GUI'sini oluştur
        local welcomeMessage = Instance.new("BillboardGui")
        welcomeMessage.Name = "WelcomeMessage"
        welcomeMessage.Enabled = true
        welcomeMessage.Adornee = rootPart
        welcomeMessage.Size = UDim2.new(0, 200, 0, 50)
        welcomeMessage.StudsOffset = Vector3.new(0, 2, 0) -- Mesajın karakterin üzerinde yüksekliği
        welcomeMessage.Parent = player.PlayerGui

        local messageText = Instance.new("TextLabel")
        messageText.Text = "Hoş Geldin!"
        messageText.Size = UDim2.new(1, 0, 1, 0)
        messageText.TextColor3 = Color3.new(1, 1, 1)
        messageText.BackgroundTransparency = 1
        messageText.TextScaled = true
        messageText.Parent = welcomeMessage

        -- Mesajı belirli bir süre sonra kaldır
        wait(1) -- 1 saniye bekle
        welcomeMessage:Destroy() -- Mesajı kaldır
    end)
end

-- Oyuncu katılma işlemi
game.Players.PlayerAdded:Connect(function(player)
    enablePlayerESP(player)
end)

-- Mevcut oyuncuları işleme al
for _, player in ipairs(game.Players:GetPlayers()) do
    enablePlayerESP(player)
end
