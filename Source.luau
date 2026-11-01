local v0_1 = {}
v0_1.__index = v0_1
local v0_2 = {}
v0_2.__index = v0_2
local v0_3 = {}
v0_3.__index = v0_3
local v0_4 = game:GetService("UserInputService")
local v0_5 = game:GetService("TweenService")
local v0_6 = game:GetService("RunService")
local v0_7 = game:GetService("MarketplaceService")
local v0_8 = {
	Main = Color3.fromRGB(24, 24, 28),
	Sidebar = Color3.fromRGB(18, 18, 22),
	Card = Color3.fromRGB(30, 30, 35),
	Element = Color3.fromRGB(40, 40, 46),
	Hover = Color3.fromRGB(50, 50, 58),
	Danger = Color3.fromRGB(200, 60, 60),	Off = Color3.fromRGB(65, 65, 74),
	IconOff = Color3.fromRGB(160, 160, 170),
	IconOn = Color3.fromRGB(255, 255, 255),
	Accent = Color3.fromRGB(50, 90, 220),
	Text = Color3.fromRGB(255, 255, 255),
	SubText = Color3.fromRGB(200, 200, 210),
}
local v0_9 = 50
local v0_10 = 26
local v0_11 = 8
local function v0_12(v1_13, v1_14, v1_15, v1_16, v1_17)
	local v1_18 = v0_5:Create(
		v1_13,
		TweenInfo.new(v1_15 or 0.15, v1_16 or Enum.EasingStyle.Quad, v1_17 or Enum.EasingDirection.Out),
		v1_14
	)
	v1_18:Play()
	return v1_18
end
local function v0_19(v1_20)
	return v1_20.UserInputType == Enum.UserInputType.MouseButton1 or v1_20.UserInputType == Enum.UserInputType.Touch
end
local function v0_21(v1_22, v1_23, v1_24, v1_25)
	local v1_26 = Instance.new("UIScale")
	v1_26.Parent = v1_22
	v1_22.MouseEnter:Connect(function()
		if not (v1_25 and v1_25()) then
			v0_12(v1_22, { BackgroundColor3 = v1_24 }, 0.12)
		end
	end)
	v1_22.MouseLeave:Connect(function()
		v0_12(v1_26, { Scale = 1 }, 0.12)
		if not (v1_25 and v1_25()) then
			v0_12(v1_22, { BackgroundColor3 = v1_23 }, 0.15)
		end
	end)
	v1_22.InputBegan:Connect(function(v2_27)
		if v0_19(v2_27) then v0_12(v1_26, { Scale = 0.96 }, 0.08) end
	end)
	v1_22.InputEnded:Connect(function(v2_28)
		if v0_19(v2_28) then v0_12(v1_26, { Scale = 1 }, 0.18, Enum.EasingStyle.Back) end
	end)
end
local function v0_29(v1_30)
	return v1_30:find("^rbx") ~= nil or v1_30:find("^https?://") ~= nil
end
local function v0_31(v1_32, v1_33, v1_34)
	if v1_34 > 3 then return end
	for v2_35, v2_36 in pairs(v1_32) do
		local v2_37 = type(v2_35) == "string" and v2_35:lower() or ""
		local v2_38 = typeof(v2_36)
		if v2_38 == "string" then
			if v0_29(v2_36) then
				v1_33.image = v1_33.image or v2_36
			elseif v2_36:match("^%d+$") then
				v1_33.image = v1_33.image or ("rbxassetid://" .. v2_36)
			end
		elseif v2_38 == "number" then
			if v2_37 == "id" or v2_37 == "image" or v2_37 == "imageid" or v2_37 == "assetid" or v2_35 == 1 then
				if v2_36 > 1000 then v1_33.image = v1_33.image or ("rbxassetid://" .. v2_36) end
			end
		elseif v2_38 == "Vector2" then
			if v2_37:find("size") then
				v1_33.size = v1_33.size or v2_36
			elseif v2_37:find("pos") or v2_37:find("offset") then
				v1_33.offset = v1_33.offset or v2_36
			end
		elseif v2_38 == "table" then
			v0_31(v2_36, v1_33, v1_34 + 1)
		end
	end
end
local function v0_39(v1_40)
	local v1_41 = {}
	local v1_42 = typeof(v1_40)
	if v1_42 == "string" then
		if v0_29(v1_40) then
			v1_41.image = v1_40
		elseif v1_40:match("^%d+$") then
			v1_41.image = "rbxassetid://" .. v1_40
		end
	elseif v1_42 == "number" then
		v1_41.image = "rbxassetid://" .. v1_40
	elseif v1_42 == "table" then
		v0_31(v1_40, v1_41, 0)
	elseif v1_42 == "Instance" then
		local v2_43 = (v1_40:IsA("ImageLabel") or v1_40:IsA("ImageButton")) and v1_40
			or v1_40:FindFirstChildWhichIsA("ImageLabel", true)
		if v2_43 then
			v1_41.image, v1_41.size, v1_41.offset = v2_43.Image, v2_43.ImageRectSize, v2_43.ImageRectOffset
		end
	end
	if v1_41.image == "" then v1_41.image = nil end
	return v1_41
end
local function v0_44(v1_45, v1_46, v1_47, v1_48)
	local v1_49 = v0_39(v1_46)
	if not v1_49.image and typeof(v1_46) == "string" and v1_47 then
		local v2_50 = {
			function() return v1_47.GetIcon(v1_46) end,
			function() return v1_47:GetIcon(v1_46) end,
			function() return v1_47.Icons and v1_47.Icons[v1_46] end,
			function() return v1_47[v1_46] end,
		}
		for v3_51, v3_52 in ipairs(v2_50) do
			local v3_53, v3_54 = pcall(v3_52)
			if v3_53 and v3_54 ~= nil then
				local v4_55 = v0_39(v3_54)
				if v4_55.image then
					v1_49 = v4_55
					break
				end
			end
		end
	end
	if not v1_49.image then
		if not v1_48 then warn("[RobloxUI] icon not recognized:", typeof(v1_46), v1_46) end
		return false
	end
	v1_45.Image = v1_49.image
	v1_45.ImageRectSize = v1_49.size or Vector2.new(0, 0)
	v1_45.ImageRectOffset = v1_49.offset or Vector2.new(0, 0)
	return true
end
local function v0_56(v1_57)
	local v1_58 = pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(v1_57)
			v1_57.Parent = game:GetService("CoreGui")
		elseif gethui then
			v1_57.Parent = gethui()
		else
			v1_57.Parent = game:GetService("CoreGui")
		end
	end)
	if not v1_58 or not v1_57.Parent then
		local v2_59 = game:GetService("Players").LocalPlayer
		v1_57.Parent = v2_59 and v2_59:WaitForChild("PlayerGui")
	end
end
local function v0_60()
	local v1_61, v1_62 = pcall(function()
		return loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
	end)
	if v1_61 and v1_62 then return v1_62 end
	warn("[RobloxUI] failed to load icon library:", v1_62)
	return nil
end
local function v0_63(v1_64, v1_65)
	local v1_66 = Instance.new("UICorner")
	v1_66.CornerRadius = UDim.new(0, v1_65 or 6)
	v1_66.Parent = v1_64
	return v1_66
end
local v0_67 = { translations = {}, code = nil, resolved = nil, dict = nil, windows = {} }
local function v0_68(v1_69)
	return (tostring(v1_69):lower():gsub("_", "-"))
end
local function v0_70()
	local v1_71
	pcall(function()
		v1_71 = game:GetService("Players").LocalPlayer.LocaleId
	end)
	if type(v1_71) ~= "string" or v1_71 == "" then
		pcall(function()
			v1_71 = game:GetService("LocalizationService").RobloxLocaleId
		end)
	end
	if type(v1_71) ~= "string" or v1_71 == "" then
		pcall(function()
			v1_71 = game:GetService("LocalizationService").SystemLocaleId
		end)
	end
	if type(v1_71) == "string" and v1_71 ~= "" then return v1_71 end
	return "en-us"
end
local function v0_72(v1_73)
	local v1_74 = v0_68(v1_73)
	local v1_75 = v1_74:match("^[^-]+")
	local v1_76 = {}
	for v2_77 in pairs(v0_67.translations) do table.insert(v1_76, v2_77) end
	table.sort(v1_76)
	local v1_78
	for v2_79, v2_80 in ipairs(v1_76) do
		local v2_81 = v0_68(v2_80)
		if v2_81 == v1_74 then return v2_80 end
		if not v1_78 and v2_81:match("^[^-]+") == v1_75 then v1_78 = v2_80 end
	end
	return v1_78
end
local function v0_82(v1_83)
	if type(v1_83) ~= "string" then return v1_83 end
	local v1_84 = v0_67.dict
	return v1_84 and v1_84[v1_83] or v1_83
end
function v0_1:T(v1_85)
	return v0_82(v1_85)
end
function v0_1:_track(v1_86, v1_87, v1_88)
	v1_86[v1_87] = v0_82(v1_88)
	local v1_89 = { obj = v1_86, prop = v1_87, key = v1_88 }
	table.insert(self._i18n, v1_89)
	return v1_89
end
function v0_1:_onLang(v1_90, v1_91)
	table.insert(self._i18n, { obj = v1_90, fn = v1_91 })
end
local function v0_92(v1_93)
	local v1_94 = v1_93._i18n
	for v2_95 = #v1_94, 1, -1 do
		local v2_96 = v1_94[v2_95]
		if not v2_96.obj:IsDescendantOf(v1_93.ScreenGui) then
			table.remove(v1_94, v2_95)
		elseif v2_96.fn then
			pcall(v2_96.fn)
		else
			v2_96.obj[v2_96.prop] = v0_82(v2_96.key)
		end
	end
end
function v0_1:AddTranslations(v1_97)
	for v2_98, v2_99 in pairs(v1_97 or {}) do
		local v2_100 = v0_67.translations[v2_98]
		if not v2_100 then
			v2_100 = {}
			v0_67.translations[v2_98] = v2_100
		end
		for v3_101, v3_102 in pairs(v2_99) do v2_100[v3_101] = v3_102 end
	end
	if v0_67.code then v0_1:SetLang(v0_67.code) end
end
function v0_1:SetLang(v1_103)
	if v1_103 == nil or v1_103 == "auto" then v1_103 = v0_70() end
	v0_67.code = v1_103
	v0_67.resolved = v0_72(v1_103)
	v0_67.dict = v0_67.resolved and v0_67.translations[v0_67.resolved] or nil
	for v2_104 = #v0_67.windows, 1, -1 do
		local v2_105 = v0_67.windows[v2_104]
		if v2_105._destroyed then
			table.remove(v0_67.windows, v2_104)
		else
			v0_92(v2_105)
		end
	end
	return v0_67.resolved
end
function v0_1:GetLang()
	return v0_67.resolved, v0_67.code
end
function v0_1.new(v1_106)
	v1_106 = v1_106 or {}
	local v1_107 = setmetatable({}, v0_1)
	v1_107.Tabs = {}
	v1_107.ActiveTab = nil
	v1_107.Icons = v1_106.Icons or v0_60()
	v1_107.IconGlow = v1_106.IconGlow == true
	v1_107._i18n = {}
	if v1_106.Translations then v0_1:AddTranslations(v1_106.Translations) end
	if v1_106.Lang ~= nil then v0_1:SetLang(v1_106.Lang) end
	table.insert(v0_67.windows, v1_107)
	v1_107._floats = {}
	v1_107._floatZ = 0
	v1_107._dialogs = {}
	v1_107._binds = {}
	v1_107._cleanups = {}
	v1_107._listening = nil
	v1_107._toggleKey = v1_106.ToggleKey
	v1_107._connections = {}
	local v1_108 = Instance.new("ScreenGui")
	v1_108.Name = "Interface"
	v1_108.ResetOnSpawn = false
	v1_108.IgnoreGuiInset = true
	v1_108.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	v0_56(v1_108)
	local v1_109 = v1_106.Size or UDim2.new(0, 600, 0, 400)
	local v1_110 = Instance.new("CanvasGroup")
	v1_110.Name = "Main"
	v1_110.Size = v1_109
	v1_110.AnchorPoint = Vector2.new(0.5, 0.5)
	v1_110.Position = UDim2.new(0.5, 0, 0.5, 0)
	v1_110.BackgroundColor3 = v0_8.Main
	v1_110.BorderSizePixel = 0
	v1_110.ClipsDescendants = true
	v1_110.GroupTransparency = 1
	v1_110.Parent = v1_108
	v0_63(v1_110, v0_11)
	local v1_111 = Instance.new("UIScale")
	v1_111.Scale = 0.9
	v1_111.Parent = v1_110
	local function v1_112()
		local v2_113 = v1_108.AbsoluteSize
		if v2_113.X <= 0 or v2_113.Y <= 0 then
			local v3_114 = workspace.CurrentCamera
			v2_113 = v3_114 and v3_114.ViewportSize or Vector2.new(1280, 720)
		end
		local v2_115, v2_116 = v1_109.X.Offset, v1_109.Y.Offset
		if v1_109.X.Scale == 0 then v2_115 = math.min(v2_115, math.max(v2_113.X - 20, 120)) end
		if v1_109.Y.Scale == 0 then v2_116 = math.min(v2_116, math.max(v2_113.Y - 20, 120)) end
		v1_110.Size = UDim2.new(v1_109.X.Scale, v2_115, v1_109.Y.Scale, v2_116)
		v1_110.Position = UDim2.new(0.5, 0, 0.5, 0)
	end
	v1_112()
	table.insert(v1_107._connections, v1_108:GetPropertyChangedSignal("AbsoluteSize"):Connect(v1_112))
	do
		local v2_117, v2_118, v2_119 = false, nil, nil
		local v2_120 = 50
		table.insert(v1_107._connections, v1_110.InputBegan:Connect(function(v3_121)
			if v3_121.UserInputType == Enum.UserInputType.MouseButton1 or v3_121.UserInputType == Enum.UserInputType.Touch then
				v2_117 = true
				v2_118 = v3_121.Position
				v2_119 = v1_110.AbsolutePosition + v1_110.AbsoluteSize / 2
				v3_121.Changed:Connect(function()
					if v3_121.UserInputState == Enum.UserInputState.End then v2_117 = false end
				end)
			end
		end))
		table.insert(v1_107._connections, v0_4.InputChanged:Connect(function(v3_122)
			if not v2_117 then return end
			if v3_122.UserInputType ~= Enum.UserInputType.MouseMovement and v3_122.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			local v3_123 = v3_122.Position - v2_118
			local v3_124 = v1_108.AbsoluteSize
			local v3_125 = v1_110.AbsoluteSize / 2
			local v3_126 = math.clamp(v2_119.X + v3_123.X, -v3_125.X + v2_120, v3_124.X + v3_125.X - v2_120)
			local v3_127 = math.clamp(v2_119.Y + v3_123.Y, v3_125.Y, math.max(v3_124.Y + v3_125.Y - v2_120, v3_125.Y))
			v1_110.Position = UDim2.fromOffset(v3_126, v3_127)
		end))
	end
	local v1_128 = Instance.new("Frame")
	v1_128.Name = "Sidebar"
	v1_128.Size = UDim2.new(0, v0_9, 1, 0)
	v1_128.BackgroundColor3 = v0_8.Sidebar
	v1_128.BorderSizePixel = 0
	v1_128.Parent = v1_110
	v0_63(v1_128, v0_11)
	local v1_129 = Instance.new("Frame")
	v1_129.Name = "SidebarFix"
	v1_129.Size = UDim2.new(0, v0_11, 1, 0)
	v1_129.Position = UDim2.new(0, v0_9 - v0_11, 0, 0)
	v1_129.BackgroundColor3 = v0_8.Sidebar
	v1_129.BorderSizePixel = 0
	v1_129.Parent = v1_110
	local v1_130 = Instance.new("UIPadding")
	v1_130.PaddingTop = UDim.new(0, 12)
	v1_130.Parent = v1_128
	local v1_131 = Instance.new("UIListLayout")
	v1_131.Padding = UDim.new(0, 8)
	v1_131.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v1_131.SortOrder = Enum.SortOrder.LayoutOrder
	v1_131.Parent = v1_128
	local v1_132 = v1_106.Footer ~= false and v0_10 or 0
	local v1_133 = Instance.new("Frame")
	v1_133.Name = "Content"
	v1_133.Size = UDim2.new(1, -v0_9, 1, -v1_132)
	v1_133.Position = UDim2.new(0, v0_9, 0, 0)
	v1_133.BackgroundTransparency = 1
	v1_133.BorderSizePixel = 0
	v1_133.ClipsDescendants = true
	v1_133.Parent = v1_110
	do
		local v2_134 = Instance.new("CanvasGroup")
		v2_134.Name = "ScrollHint"
		v2_134.AnchorPoint = Vector2.new(0.5, 1)
		v2_134.Position = UDim2.new(0.5, -1, 1, -6)
		v2_134.Size = UDim2.new(0, 22, 0, 22)
		v2_134.BackgroundTransparency = 1
		v2_134.BorderSizePixel = 0
		v2_134.GroupTransparency = 1
		v2_134.Visible = false
		v2_134.Active = false
		v2_134.ZIndex = 10
		v2_134.Parent = v1_133
		local v2_135 = Instance.new("ImageLabel")
		v2_135.Name = "Icon"
		v2_135.AnchorPoint = Vector2.new(0.5, 0.5)
		v2_135.Position = UDim2.new(0.5, 0, 0.5, -3)
		v2_135.Size = UDim2.new(0, 16, 0, 16)
		v2_135.BackgroundTransparency = 1
		v2_135.BorderSizePixel = 0
		v2_135.ImageColor3 = v0_8.SubText
		v2_135.ScaleType = Enum.ScaleType.Fit
		v2_135.Active = false
		v2_135.Parent = v2_134
		local v2_136 = Instance.new("TextLabel")
		v2_136.Name = "IconFallback"
		v2_136.Size = UDim2.new(1, 0, 1, 0)
		v2_136.BackgroundTransparency = 1
		v2_136.Text = "▼"
		v2_136.TextColor3 = v0_8.SubText
		v2_136.Font = Enum.Font.Gotham
		v2_136.TextSize = 11
		v2_136.Parent = v2_135
		v2_136.Visible = not v0_44(v2_135, "chevron-down", v1_107.Icons)
		local v2_137 = v0_5:Create(
			v2_135,
			TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Position = UDim2.new(0.5, 0, 0.5, 3) }
		)
		local v2_138 = Instance.new("TextButton")
		v2_138.Name = "Click"
		v2_138.Size = UDim2.new(1, 0, 1, 0)
		v2_138.BackgroundTransparency = 1
		v2_138.BorderSizePixel = 0
		v2_138.Text = ""
		v2_138.AutoButtonColor = false
		v2_138.ZIndex = 2
		v2_138.Parent = v2_134
		local v2_139 = UDim2.new(0.5, -1, 1, -34)
		local v2_140 = UDim2.new(0.5, -1, 1, -27)
		local v2_141 = Instance.new("CanvasGroup")
		v2_141.Name = "ScrollHintText"
		v2_141.AnchorPoint = Vector2.new(0.5, 1)
		v2_141.Position = v2_140
		v2_141.Size = UDim2.new(0, 0, 0, 0)
		v2_141.AutomaticSize = Enum.AutomaticSize.XY
		v2_141.BackgroundColor3 = v0_8.Sidebar
		v2_141.BorderSizePixel = 0
		v2_141.GroupTransparency = 1
		v2_141.Visible = false
		v2_141.Active = false
		v2_141.ZIndex = 10
		v2_141.Parent = v1_133
		v0_63(v2_141, 6)
		local v2_142 = Instance.new("UIStroke")
		v2_142.Color = v0_8.Element
		v2_142.Thickness = 1
		v2_142.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		v2_142.Parent = v2_141
		local v2_143 = Instance.new("UIPadding")
		v2_143.PaddingTop = UDim.new(0, 6)
		v2_143.PaddingBottom = UDim.new(0, 6)
		v2_143.PaddingLeft = UDim.new(0, 10)
		v2_143.PaddingRight = UDim.new(0, 10)
		v2_143.Parent = v2_141
		local v2_144 = Instance.new("TextLabel")
		v2_144.Name = "Text"
		v2_144.Size = UDim2.new(0, 0, 0, 0)
		v2_144.AutomaticSize = Enum.AutomaticSize.XY
		v2_144.BackgroundTransparency = 1
		v2_144.BorderSizePixel = 0
		v1_107:_track(v2_144, "Text", "Scroll To See More Features.")
		v2_144.TextColor3 = v0_8.Text
		v2_144.Font = Enum.Font.Gotham
		v2_144.TextSize = 12
		v2_144.Parent = v2_141
		local v2_145, v2_146, v2_147 = false, nil, nil
		local function v2_148(v3_149)
			if v2_146 and v2_146 ~= coroutine.running() then
				pcall(task.cancel, v2_146)
			end
			v2_146 = nil
			if not v2_145 then return end
			v2_145 = false
			if v2_147 then v2_147:Cancel() end
			if v3_149 then
				v2_141.GroupTransparency = 1
				v2_141.Visible = false
				return
			end
			local v3_150 = v0_12(v2_141, { GroupTransparency = 1, Position = v2_140 }, 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			v2_147 = v3_150
			v3_150.Completed:Connect(function(v4_151)
				if v4_151 == Enum.PlaybackState.Completed and not v2_145 then
					v2_141.Visible = false
				end
			end)
		end
		local function v2_152()
			if v2_145 then return end
			v2_145 = true
			if v2_147 then v2_147:Cancel() end
			if not v2_141.Visible then
				v2_141.Position = v2_140
				v2_141.Visible = true
			end
			v2_147 = v0_12(v2_141, { GroupTransparency = 0, Position = v2_139 }, 0.25, Enum.EasingStyle.Quint)
			v2_146 = task.spawn(function()
				task.wait(3.5)
				v2_146 = nil
				v2_148()
			end)
		end
		v2_138.MouseButton1Click:Connect(function()
			if v2_145 then v2_148() else v2_152() end
		end)
		v1_107._hint = { Frame = v2_134, Icon = v2_135, Bounce = v2_137, Shown = false, HideTip = v2_148 }
	end
	if v1_132 > 0 then
		local v2_153 = Instance.new("Frame")
		v2_153.Name = "Footer"
		v2_153.AnchorPoint = Vector2.new(0, 1)
		v2_153.Position = UDim2.new(0, 0, 1, 0)
		v2_153.Size = UDim2.new(1, 0, 0, v1_132)
		v2_153.BackgroundColor3 = v0_8.Sidebar
		v2_153.BorderSizePixel = 0
		v2_153.Parent = v1_110
		local v2_154 = Instance.new("Frame")
		v2_154.Name = "Divider"
		v2_154.Size = UDim2.new(1, 0, 0, 1)
		v2_154.BackgroundColor3 = v0_8.Element
		v2_154.BorderSizePixel = 0
		v2_154.Parent = v2_153
		local function v2_155(v3_156, v3_157, v3_158, v3_159, v3_160)
			local v3_161 = Instance.new("TextLabel")
			v3_161.Name = v3_156
			v3_161.AnchorPoint = v3_160
			v3_161.Position = v3_158
			v3_161.Size = v3_159
			v3_161.BackgroundTransparency = 1
			v3_161.BorderSizePixel = 0
			v3_161.Text = ""
			v3_161.TextColor3 = v0_8.SubText
			v3_161.Font = Enum.Font.Gotham
			v3_161.TextSize = 12
			v3_161.TextXAlignment = v3_157
			v3_161.TextTruncate = Enum.TextTruncate.AtEnd
			v3_161.Parent = v2_153
			return v3_161
		end
		local v2_162 = v2_155("Time", Enum.TextXAlignment.Left, UDim2.new(0, 12, 0, 0), UDim2.new(0, 100, 1, 0), Vector2.new(0, 0))
		local v2_163 = v2_155("Game", Enum.TextXAlignment.Center, UDim2.new(0, 112, 0, 0), UDim2.new(1, -224, 1, 0), Vector2.new(0, 0))
		local v2_164 = v2_155("Executor", Enum.TextXAlignment.Right, UDim2.new(1, -12, 0, 0), UDim2.new(0, 100, 1, 0), Vector2.new(1, 0))
		if type(v1_106.FooterLeft) == "string" then
			v2_162.Text = v1_106.FooterLeft
		else
			local function v3_165()
				local v4_166 = os.date("%I:%M %p")
				if v2_162.Text ~= v4_166 then v2_162.Text = v4_166 end
			end
			v3_165()
			v1_107._clock = task.spawn(function()
				while not v1_107._destroyed do
					task.wait(60 - (os.time() % 60) + 0.1)
					v3_165()
				end
			end)
		end
		if type(v1_106.FooterCenter) == "string" then
			v2_163.Text = v1_106.FooterCenter
		else
			v2_163.Text = v0_82("Loading...")
			task.spawn(function()
				local v4_167, v4_168 = pcall(function()
					return v0_7:GetProductInfo(game.PlaceId)
				end)
				if v1_107._destroyed then return end
				v2_163.Text = (v4_167 and v4_168 and v4_168.Name) or tostring(game.Name)
			end)
		end
		if type(v1_106.FooterRight) == "string" then
			v2_164.Text = v1_106.FooterRight
		else
			local v3_169
			if type(identifyexecutor) == "function" then
				local v4_170, v4_171 = pcall(identifyexecutor)
				if v4_170 and v4_171 then v3_169 = tostring(v4_171) end
			end
			v2_164.Text = v3_169 or "Roblox"
		end
	end
	if v1_106.Resizable ~= false then
		local v2_172 = v1_106.MinSize or Vector2.new(380, 260)
		local v2_173 = v1_106.MaxSize
		local v2_174 = Instance.new("TextButton")
		v2_174.Name = "ResizeGrip"
		v2_174.AnchorPoint = Vector2.new(1, 1)
		v2_174.Position = UDim2.new(1, -6, 1, -6 - v1_132)
		v2_174.Size = UDim2.new(0, 22, 0, 22)
		v2_174.BackgroundColor3 = v0_8.Main
		v2_174.BackgroundTransparency = 0.25
		v2_174.BorderSizePixel = 0
		v2_174.Text = ""
		v2_174.AutoButtonColor = false
		v2_174.Parent = v1_110
		v0_63(v2_174, 6)
		local v2_175 = Instance.new("ImageLabel")
		v2_175.Name = "Icon"
		v2_175.AnchorPoint = Vector2.new(0.5, 0.5)
		v2_175.Position = UDim2.new(0.5, 0, 0.5, 0)
		v2_175.Size = UDim2.new(0, 14, 0, 14)
		v2_175.BackgroundTransparency = 1
		v2_175.BorderSizePixel = 0
		v2_175.ImageColor3 = v0_8.IconOff
		v2_175.ScaleType = Enum.ScaleType.Fit
		v2_175.Parent = v2_174
		local v2_176 = Instance.new("TextLabel")
		v2_176.Name = "IconFallback"
		v2_176.Size = UDim2.new(1, 0, 1, 0)
		v2_176.BackgroundTransparency = 1
		v2_176.Text = "⤢"
		v2_176.TextColor3 = v0_8.IconOff
		v2_176.Font = Enum.Font.GothamBold
		v2_176.TextSize = 14
		v2_176.Parent = v2_175
		v2_176.Visible = not v0_44(v2_175, "expand", v1_107.Icons)
		local v2_177 = Instance.new("UIScale")
		v2_177.Parent = v2_174
		local v2_178, v2_179, v2_180 = false, false, nil
		local function v2_181()
			local v3_182 = v2_178 or v2_179
			local v3_183 = v3_182 and v0_8.IconOn or v0_8.IconOff
			v0_12(v2_175, { ImageColor3 = v3_183 }, 0.15)
			v0_12(v2_176, { TextColor3 = v3_183 }, 0.15)
			v0_12(v2_174, { BackgroundColor3 = v3_182 and v0_8.Hover or v0_8.Main }, 0.15)
		end
		local function v2_184()
			if v2_180 then
				for v5_185, v5_186 in ipairs(v2_180) do v5_186:Disconnect() end
				v2_180 = nil
			end
			if v2_179 then
				v2_179 = false
				v2_181()
				v0_12(v2_177, { Scale = v2_178 and 1.1 or 1 }, 0.18, Enum.EasingStyle.Back)
			end
		end
		local function v2_187(v3_188)
			v2_184()
			v2_179 = true
			v2_181()
			v0_12(v2_177, { Scale = 0.9 }, 0.08)
			local v3_189 = v1_111.Scale
			local v3_190 = v3_188.Position
			local v3_191 = v1_110.AbsoluteSize / v3_189
			local v3_192 = v1_110.AbsolutePosition
			v2_180 = {
				v0_4.InputChanged:Connect(function(v4_193)
					if v4_193.UserInputType ~= Enum.UserInputType.MouseMovement and v4_193 ~= v3_188 then return end
					local v4_194 = v4_193.Position - v3_190
					local v4_195 = v1_108.AbsoluteSize
					local v4_196 = math.max(v2_172.X, v4_195.X - v3_192.X - 4)
					local v4_197 = math.max(v2_172.Y, v4_195.Y - v3_192.Y - 4)
					if v2_173 then
						v4_196 = math.max(v2_172.X, math.min(v4_196, v2_173.X))
						v4_197 = math.max(v2_172.Y, math.min(v4_197, v2_173.Y))
					end
					local v4_198 = math.clamp(v3_191.X + v4_194.X / v3_189, v2_172.X, v4_196)
					local v4_199 = math.clamp(v3_191.Y + v4_194.Y / v3_189, v2_172.Y, v4_197)
					v1_109 = UDim2.fromOffset(v4_198, v4_199)
					v1_110.Size = v1_109
					v1_110.Position = UDim2.fromOffset(v3_192.X + v4_198 * v3_189 / 2, v3_192.Y + v4_199 * v3_189 / 2)
				end),
				v0_4.InputEnded:Connect(function(v4_200)
					if v4_200 == v3_188 or v4_200.UserInputType == Enum.UserInputType.MouseButton1 then
						v2_184()
					end
				end),
			}
		end
		v2_174.InputBegan:Connect(function(v3_201)
			if v0_19(v3_201) then v2_187(v3_201) end
		end)
		v2_174.MouseEnter:Connect(function()
			v2_178 = true
			v2_181()
			if not v2_179 then v0_12(v2_177, { Scale = 1.1 }, 0.12) end
		end)
		v2_174.MouseLeave:Connect(function()
			v2_178 = false
			v2_181()
			if not v2_179 then v0_12(v2_177, { Scale = 1 }, 0.12) end
		end)
		v1_107._cleanups[v2_174] = v2_184
	end
	v1_107.ScreenGui, v1_107.Main, v1_107.Sidebar, v1_107.Content = v1_108, v1_110, v1_128, v1_133
	if v1_106.Icon ~= nil then
		v1_107:SetIcon(v1_106.Icon, v1_106.IconColor)
	end
	v1_107._scale = v1_111
	v1_107._visible = false
	if v1_106.Watermark ~= false then
		v1_107:_buildWatermark(v1_106.Title or v1_106.Name or "RobloxUI")
	end
	table.insert(v1_107._connections, v0_4.InputBegan:Connect(function(v2_202, v2_203)
		local v2_204 = v1_107._listening
		if v2_204 then
			if v2_202.UserInputType == Enum.UserInputType.Keyboard then
				if not v0_4:GetFocusedTextBox() then
					v2_204:_capture(v2_202.KeyCode)
				end
			elseif v0_19(v2_202) and not v2_203 then
				v2_204:_stopListening()
			end
			return
		end
		if v2_203 or v2_202.UserInputType ~= Enum.UserInputType.Keyboard then return end
		local v2_205 = v2_202.KeyCode
		if #v1_107._dialogs > 0 then
			if v2_205 == Enum.KeyCode.Escape then
				local v4_206 = v1_107._dialogs[#v1_107._dialogs]
				if v4_206.Dismissable then v4_206.Close() end
			end
			return
		end
		if v1_107._toggleKey and v2_205 == v1_107._toggleKey then
			v1_107:Toggle()
			return
		end
		for v3_207, v3_208 in ipairs(table.clone(v1_107._binds)) do
			if v3_208._key == v2_205 and not v3_208._destroyed then
				v3_208._onPress()
			end
		end
	end))
	if v1_106.StartHidden then
		v1_110.Visible = false
		v1_107:_updateWatermark()
	else
		v1_107:Show()
	end
	return v1_107
end
function v0_1:SetIcon(v1_209, v1_210)
	local v1_211 = self._logo
	if not v1_211 then
		local v2_212 = Instance.new("Frame")
		v2_212.Name = "Logo"
		v2_212.Size = UDim2.new(0, 36, 0, 36)
		v2_212.BackgroundTransparency = 1
		v2_212.BorderSizePixel = 0
		v2_212.LayoutOrder = 0
		v2_212.Visible = false
		v2_212.Parent = self.Sidebar
		local v2_213 = Instance.new("ImageLabel")
		v2_213.Name = "Icon"
		v2_213.AnchorPoint = Vector2.new(0.5, 0.5)
		v2_213.Position = UDim2.new(0.5, 0, 0.5, 0)
		v2_213.Size = UDim2.new(0, 26, 0, 26)
		v2_213.BackgroundTransparency = 1
		v2_213.BorderSizePixel = 0
		v2_213.ScaleType = Enum.ScaleType.Fit
		v2_213.Parent = v2_212
		v1_211 = { Holder = v2_212, Img = v2_213 }
		self._logo = v1_211
	end
	if v1_209 == nil then
		v1_211.Holder.Visible = false
		return false
	end
	local v1_214 = v0_44(v1_211.Img, v1_209, self.Icons)
	v1_211.Holder.Visible = v1_214
	if v1_214 then
		local v2_215 = type(v1_209) == "string" and not v1_209:find("^rbx") and not v1_209:find("^https?://") and not v1_209:match("^%d+$")
		v1_211.Img.ImageColor3 = v1_210 or (v2_215 and v0_8.Accent or Color3.new(1, 1, 1))
	end
	return v1_214
end
function v0_1.CreateWindow(v1_216, v1_217)
	return v0_1.new(v1_216 == v0_1 and v1_217 or v1_216)
end
function v0_1:Destroy()
	for v2_218, v2_219 in ipairs(self._connections) do
		v2_219:Disconnect()
	end
	self._connections = {}
	self._destroyed = true
	if self._hint then pcall(self._hint.HideTip, true) end
	if self._clock then pcall(task.cancel, self._clock) end
	for v2_220, v2_221 in ipairs(table.clone(self._notifs or {})) do pcall(v2_221) end
	for v2_222, v2_223 in pairs(self._cleanups) do pcall(v2_223) end
	self._cleanups = {}
	self._binds = {}
	self._listening = nil
	self.ScreenGui:Destroy()
end
local v0_224, v0_225 = 0.35, 0.2
function v0_1:_cancelAnim()
	if self._anim then
		for v3_226, v3_227 in ipairs(self._anim) do v3_227:Cancel() end
		self._anim = nil
	end
end
function v0_1:Show()
	if self._destroyed then return end
	self._visible = true
	self:_cancelAnim()
	self.Main.Visible = true
	self._anim = {
		v0_12(self.Main, { GroupTransparency = 0 }, v0_224, Enum.EasingStyle.Quint),
		v0_12(self._scale, { Scale = 1 }, v0_224, Enum.EasingStyle.Back),
	}
	self:_updateWatermark()
	self:_setFloatVisible(true)
end
function v0_1:Hide()
	if self._destroyed or not self._visible then return end
	self._visible = false
	self:_cancelAnim()
	local v1_228 = v0_4:GetFocusedTextBox()
	if v1_228 and v1_228:IsDescendantOf(self.Main) then v1_228:ReleaseFocus() end
	local v1_229 = v0_12(self.Main, { GroupTransparency = 1 }, v0_225, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local v1_230 = v0_12(self._scale, { Scale = 0.92 }, v0_225, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	self._anim = { v1_229, v1_230 }
	v1_229.Completed:Connect(function(v2_231)
		if v2_231 == Enum.PlaybackState.Completed and not self._visible and not self._destroyed then
			self.Main.Visible = false
		end
	end)
	self:_updateWatermark()
	self:_setFloatVisible(false)
end
function v0_1:_setFloatVisible(v1_232)
	if v1_232 == nil then v1_232 = self._visible end
	for v2_233, v2_234 in pairs(self._floats) do
		if v2_234 then
			if v1_232 then
				v2_233.Visible = true
				v0_12(v2_233, { GroupTransparency = 0 }, v0_224, Enum.EasingStyle.Quint)
			else
				local v4_235 = v0_12(v2_233, { GroupTransparency = 1 }, v0_225, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				v4_235.Completed:Connect(function(v5_236)
					if v5_236 == Enum.PlaybackState.Completed and not self._visible then
						v2_233.Visible = false
					end
				end)
			end
		end
	end
end
function v0_1:Toggle()
	if self._visible then self:Hide() else self:Show() end
end
function v0_1:IsVisible()
	return self._visible == true
end
function v0_1:_updateScrollHint()
	local v1_237 = self._hint
	if not v1_237 or self._destroyed then return end
	local v1_238 = self.ActiveTab and self.ActiveTab.Page
	local v1_239 = false
	if v1_238 and v1_238.Visible then
		local v2_240 = v1_238.AbsoluteCanvasSize.Y - (v1_238.CanvasPosition.Y + v1_238.AbsoluteWindowSize.Y)
		v1_239 = v2_240 > 4
	end
	if v1_239 == v1_237.Shown then return end
	v1_237.Shown = v1_239
	if v1_237.Fade then v1_237.Fade:Cancel() end
	if v1_239 then
		v1_237.Frame.Visible = true
		v1_237.Icon.Position = UDim2.new(0.5, 0, 0.5, -3)
		v1_237.Bounce:Play()
		v1_237.Fade = v0_12(v1_237.Frame, { GroupTransparency = 0.15 }, 0.2)
	else
		v1_237.HideTip()
		local v2_241 = v0_12(v1_237.Frame, { GroupTransparency = 1 }, 0.2)
		v1_237.Fade = v2_241
		v2_241.Completed:Connect(function(v3_242)
			if v3_242 == Enum.PlaybackState.Completed and not v1_237.Shown then
				v1_237.Bounce:Cancel()
				v1_237.Frame.Visible = false
			end
		end)
	end
end
function v0_1:_keyTaken(v1_243, v1_244)
	if not v1_243 then return false end
	if v1_243 == self._toggleKey then return true end
	for v2_245, v2_246 in ipairs(self._binds) do
		if v2_246 ~= v1_244 and v2_246._key == v1_243 then return true end
	end
	return false
end
local v0_247, v0_248 = 280, 5
function v0_1:_getNotifyContainer()
	if self._notifyContainer and self._notifyContainer.Parent then
		return self._notifyContainer
	end
	local v1_249 = self.ScreenGui.AbsoluteSize
	local v1_250 = v1_249.X > 0 and math.min(v0_247, v1_249.X - 20) or v0_247
	local v1_251 = Instance.new("Frame")
	v1_251.Name = "Notifications"
	v1_251.AnchorPoint = Vector2.new(0.5, 0)
	v1_251.Position = UDim2.new(0.5, 0, 0, self._wm and 48 or 10)
	v1_251.Size = UDim2.new(0, v1_250, 0, 0)
	v1_251.AutomaticSize = Enum.AutomaticSize.Y
	v1_251.BackgroundTransparency = 1
	v1_251.BorderSizePixel = 0
	v1_251.Parent = self.ScreenGui
	local v1_252 = Instance.new("UIListLayout")
	v1_252.Padding = UDim.new(0, 6)
	v1_252.SortOrder = Enum.SortOrder.LayoutOrder
	v1_252.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v1_252.Parent = v1_251
	self._notifyContainer = v1_251
	return v1_251
end
function v0_1:Notify(v1_253)
	if self._destroyed then return end
	if type(v1_253) == "string" then v1_253 = { Content = v1_253 } end
	v1_253 = v1_253 or {}
	local v1_254 = tonumber(v1_253.Duration) or 4
	local v1_255 = self:_getNotifyContainer()
	self._notifyCount = (self._notifyCount or 0) + 1
	self._notifs = self._notifs or {}
	local v1_256 = false
	local v1_257 = Instance.new("Frame")
	v1_257.Name = "Notification"
	v1_257.Size = UDim2.new(1, 0, 0, 0)
	v1_257.BackgroundTransparency = 1
	v1_257.BorderSizePixel = 0
	v1_257.LayoutOrder = self._notifyCount
	v1_257.Parent = v1_255
	local v1_258 = Instance.new("CanvasGroup")
	v1_258.Name = "Card"
	v1_258.Size = UDim2.new(1, 0, 0, 0)
	v1_258.AutomaticSize = Enum.AutomaticSize.Y
	v1_258.BackgroundColor3 = v0_8.Sidebar
	v1_258.BorderSizePixel = 0
	v1_258.GroupTransparency = 1
	v1_258.Parent = v1_257
	v0_63(v1_258, 8)
	local v1_259 = Instance.new("UIStroke")
	v1_259.Color = v0_8.Element
	v1_259.Thickness = 1
	v1_259.Transparency = 1
	v1_259.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	v1_259.Parent = v1_258
	local v1_260 = Instance.new("Frame")
	v1_260.Name = "Body"
	v1_260.Size = UDim2.new(1, 0, 0, 0)
	v1_260.AutomaticSize = Enum.AutomaticSize.Y
	v1_260.BackgroundTransparency = 1
	v1_260.BorderSizePixel = 0
	v1_260.Parent = v1_258
	local v1_261 = Instance.new("UIPadding")
	v1_261.PaddingTop = UDim.new(0, 8)
	v1_261.PaddingBottom = UDim.new(0, 8)
	v1_261.PaddingLeft = UDim.new(0, 12)
	v1_261.PaddingRight = UDim.new(0, 12)
	v1_261.Parent = v1_260
	local v1_262 = Instance.new("UISizeConstraint")
	v1_262.MinSize = Vector2.new(0, 30)
	v1_262.Parent = v1_260
	local v1_263 = Instance.new("Frame")
	v1_263.Name = "Texts"
	v1_263.Position = UDim2.new(0, 0, 0, 0)
	v1_263.Size = UDim2.new(1, 0, 0, 0)
	v1_263.AutomaticSize = Enum.AutomaticSize.Y
	v1_263.BackgroundTransparency = 1
	v1_263.BorderSizePixel = 0
	v1_263.Parent = v1_260
	local v1_264 = Instance.new("UIListLayout")
	v1_264.Padding = UDim.new(0, 2)
	v1_264.SortOrder = Enum.SortOrder.LayoutOrder
	v1_264.Parent = v1_263
	local function v1_265(v2_266, v2_267, v2_268, v2_269, v2_270)
		local v2_271 = Instance.new("TextLabel")
		v2_271.Size = UDim2.new(1, 0, 0, 0)
		v2_271.AutomaticSize = Enum.AutomaticSize.Y
		v2_271.BackgroundTransparency = 1
		v2_271.BorderSizePixel = 0
		v2_271.Text = v2_266
		v2_271.TextColor3 = v2_269
		v2_271.Font = v2_267
		v2_271.TextSize = v2_268
		v2_271.TextWrapped = true
		v2_271.TextXAlignment = Enum.TextXAlignment.Left
		v2_271.TextYAlignment = Enum.TextYAlignment.Top
		v2_271.LayoutOrder = v2_270
		v2_271.Parent = v1_263
		return v2_271
	end
	if v1_253.Title and v1_253.Title ~= "" then
		v1_265(self:T(tostring(v1_253.Title)), Enum.Font.GothamBold, 13, v0_8.Text, 1).Name = "Title"
	end
	if v1_253.Content and v1_253.Content ~= "" then
		v1_265(self:T(tostring(v1_253.Content)), Enum.Font.Gotham, 12, v0_8.SubText, 2).Name = "Content"
	end
	local v1_272 = Instance.new("TextLabel")
	v1_272.Name = "Countdown"
	v1_272.AnchorPoint = Vector2.new(1, 0.5)
	v1_272.Position = UDim2.new(1, 0, 0.5, 0)
	v1_272.Size = UDim2.new(0, 18, 0, 18)
	v1_272.BackgroundTransparency = 1
	v1_272.BorderSizePixel = 0
	v1_272.Text = tostring(math.ceil(v1_254))
	v1_272.TextColor3 = v0_8.SubText
	v1_272.Font = Enum.Font.GothamBold
	v1_272.TextSize = 13
	v1_272.TextXAlignment = Enum.TextXAlignment.Right
	v1_272.Visible = v1_254 > 0
	v1_272.Parent = v1_260
	if v1_254 > 0 then
		v1_263.Size = UDim2.new(1, -24, 0, 0)
	end
	local v1_273 = Instance.new("TextButton")
	v1_273.Name = "Click"
	v1_273.Size = UDim2.new(1, 0, 1, 0)
	v1_273.BackgroundTransparency = 1
	v1_273.BorderSizePixel = 0
	v1_273.Text = ""
	v1_273.AutoButtonColor = false
	v1_273.Parent = v1_258
	local v1_274, v1_275 = nil, nil
	local v1_276 = {}
	local function v1_277()
		if v1_256 then return end
		v1_256 = true
		local v2_278 = table.find(self._notifs, v1_277)
		if v2_278 then table.remove(self._notifs, v2_278) end
		if v1_274 and v1_274 ~= coroutine.running() then
			pcall(task.cancel, v1_274)
		end
		v1_274 = nil
		if v1_275 then
			v1_275:Disconnect()
			v1_275 = nil
		end
		for v3_279, v3_280 in ipairs(v1_276) do v3_280:Cancel() end
		v1_276 = {}
		if self._destroyed then return end
		v0_12(v1_259, { Transparency = 1 }, 0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local v2_281 = v0_12(v1_258, {
			Position = UDim2.new(0, 0, 0, -20),
			GroupTransparency = 1,
		}, 0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		v2_281.Completed:Connect(function()
			local v3_282 = v0_12(v1_257, { Size = UDim2.new(1, 0, 0, 0) }, 0.2, Enum.EasingStyle.Quint)
			v3_282.Completed:Connect(function()
				v1_257:Destroy()
			end)
		end)
	end
	v1_273.MouseButton1Click:Connect(v1_277)
	table.insert(self._notifs, v1_277)
	while #self._notifs > v0_248 do
		self._notifs[1]()
	end
	local v1_283 = false
	v1_275 = v1_258:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if v1_256 then return end
		local v2_284 = v1_258.AbsoluteSize.Y
		if v2_284 <= 0 then return end
		if not v1_283 then
			v1_283 = true
			table.insert(v1_276, v0_12(v1_257, { Size = UDim2.new(1, 0, 0, v2_284) }, 0.3, Enum.EasingStyle.Quint))
		else
			v1_257.Size = UDim2.new(1, 0, 0, v2_284)
		end
	end)
	v1_258.Position = UDim2.new(0, 0, 0, -(v1_255.AbsolutePosition.Y + v1_255.AbsoluteSize.Y + 90))
	v1_276 = {
		v0_12(v1_258, { Position = UDim2.new(0, 0, 0, 0) }, 0.45, Enum.EasingStyle.Back),
		v0_12(v1_258, { GroupTransparency = 0 }, 0.25),
		v0_12(v1_259, { Transparency = 0 }, 0.25),
	}
	if v1_254 > 0 then
		v1_274 = task.spawn(function()
			local v3_285 = os.clock()
			local v3_286 = math.ceil(v1_254)
			while not v1_256 and not self._destroyed do
				local v4_287 = v1_254 - (os.clock() - v3_285)
				local v4_288 = math.max(math.ceil(v4_287), 0)
				if v4_288 ~= v3_286 then
					v3_286 = v4_288
					v1_272.Text = tostring(v4_288)
					v1_272.TextTransparency = 0.6
					v0_12(v1_272, { TextTransparency = 0 }, 0.2)
				end
				if v4_287 <= 0 then
					v1_274 = nil
					v1_277()
					return
				end
				task.wait(v4_287 - (v4_288 - 1))
			end
		end)
	end
	return { Dismiss = v1_277 }
end
function v0_1:Dialog(v1_289)
	if self._destroyed then return end
	v1_289 = v1_289 or {}
	local v1_290 = v1_289.Buttons
	if type(v1_290) ~= "table" or #v1_290 == 0 then
		v1_290 = { { Title = "OK", Primary = true } }
	end
	local v1_291 = false
	local v1_292 = {}
	local v1_293 = { Dismissable = v1_289.Dismissable ~= false }
	local v1_294 = Instance.new("Frame")
	v1_294.Name = "DialogOverlay"
	v1_294.Size = UDim2.new(1, 0, 1, 0)
	v1_294.BackgroundTransparency = 1
	v1_294.BorderSizePixel = 0
	v1_294.ZIndex = 100 + #self._dialogs
	v1_294.Parent = self.ScreenGui
	local v1_295 = Instance.new("TextButton")
	v1_295.Name = "Backdrop"
	v1_295.Size = UDim2.new(1, 0, 1, 0)
	v1_295.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	v1_295.BackgroundTransparency = 1
	v1_295.BorderSizePixel = 0
	v1_295.Text = ""
	v1_295.AutoButtonColor = false
	v1_295.Parent = v1_294
	local v1_296 = Instance.new("CanvasGroup")
	v1_296.Name = "Dialog"
	v1_296.AnchorPoint = Vector2.new(0.5, 0.5)
	v1_296.Position = UDim2.new(0.5, 0, 0.5, 0)
	v1_296.Size = UDim2.new(0.9, 0, 0, 0)
	v1_296.AutomaticSize = Enum.AutomaticSize.Y
	v1_296.BackgroundColor3 = v0_8.Sidebar
	v1_296.BorderSizePixel = 0
	v1_296.GroupTransparency = 1
	v1_296.Active = true
	v1_296.ZIndex = 2
	v1_296.Parent = v1_294
	v0_63(v1_296, 8)
	local v1_297 = Instance.new("UISizeConstraint")
	v1_297.MinSize = Vector2.new(200, 0)
	v1_297.MaxSize = Vector2.new(320, math.huge)
	v1_297.Parent = v1_296
	local v1_298 = Instance.new("UIScale")
	v1_298.Scale = 0.92
	v1_298.Parent = v1_296
	local v1_299 = Instance.new("UIStroke")
	v1_299.Color = v0_8.Element
	v1_299.Thickness = 1
	v1_299.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	v1_299.Parent = v1_296
	local v1_300 = Instance.new("Frame")
	v1_300.Name = "Body"
	v1_300.Size = UDim2.new(1, 0, 0, 0)
	v1_300.AutomaticSize = Enum.AutomaticSize.Y
	v1_300.BackgroundTransparency = 1
	v1_300.BorderSizePixel = 0
	v1_300.Parent = v1_296
	local v1_301 = Instance.new("UIPadding")
	v1_301.PaddingTop = UDim.new(0, 14)
	v1_301.PaddingBottom = UDim.new(0, 14)
	v1_301.PaddingLeft = UDim.new(0, 14)
	v1_301.PaddingRight = UDim.new(0, 14)
	v1_301.Parent = v1_300
	local v1_302 = Instance.new("UIListLayout")
	v1_302.Padding = UDim.new(0, 8)
	v1_302.SortOrder = Enum.SortOrder.LayoutOrder
	v1_302.Parent = v1_300
	local function v1_303(v2_304, v2_305, v2_306, v2_307, v2_308, v2_309)
		local v2_310 = Instance.new("TextLabel")
		v2_310.Name = v2_304
		v2_310.Size = UDim2.new(1, 0, 0, 0)
		v2_310.AutomaticSize = Enum.AutomaticSize.Y
		v2_310.BackgroundTransparency = 1
		v2_310.BorderSizePixel = 0
		v2_310.Text = v2_305
		v2_310.TextColor3 = v2_308
		v2_310.Font = v2_306
		v2_310.TextSize = v2_307
		v2_310.TextWrapped = true
		v2_310.TextXAlignment = Enum.TextXAlignment.Left
		v2_310.TextYAlignment = Enum.TextYAlignment.Top
		v2_310.LayoutOrder = v2_309
		v2_310.Parent = v1_300
		return v2_310
	end
	if v1_289.Title and v1_289.Title ~= "" then
		v1_303("Title", self:T(tostring(v1_289.Title)), Enum.Font.GothamBold, 15, v0_8.Text, 1)
	end
	if v1_289.Content and v1_289.Content ~= "" then
		v1_303("Content", self:T(tostring(v1_289.Content)), Enum.Font.Gotham, 13, v0_8.SubText, 2)
	end
	local v1_311 = Instance.new("Frame")
	v1_311.Name = "Buttons"
	v1_311.Size = UDim2.new(1, 0, 0, 30)
	v1_311.BackgroundTransparency = 1
	v1_311.BorderSizePixel = 0
	v1_311.LayoutOrder = 3
	v1_311.Parent = v1_300
	local v1_312 = Instance.new("UIListLayout")
	v1_312.FillDirection = Enum.FillDirection.Horizontal
	v1_312.HorizontalAlignment = Enum.HorizontalAlignment.Right
	v1_312.VerticalAlignment = Enum.VerticalAlignment.Center
	v1_312.Padding = UDim.new(0, 8)
	v1_312.SortOrder = Enum.SortOrder.LayoutOrder
	v1_312.Parent = v1_311
	local function v1_313()
		if v1_291 then return end
		v1_291 = true
		local v2_314 = table.find(self._dialogs, v1_293)
		if v2_314 then table.remove(self._dialogs, v2_314) end
		for v3_315, v3_316 in ipairs(v1_292) do v3_316:Cancel() end
		v1_292 = {}
		if self._destroyed or not v1_294.Parent then return end
		v0_12(v1_295, { BackgroundTransparency = 1 }, 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		v0_12(v1_298, { Scale = 0.94 }, 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local v2_317 = v0_12(v1_296, { GroupTransparency = 1 }, 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		v2_317.Completed:Connect(function()
			v1_294:Destroy()
		end)
	end
	v1_293.Close = v1_313
	for v2_318, v2_319 in ipairs(v1_290) do
		local v2_320 = v2_319.Primary == true
		local v2_321 = v2_320 and v0_8.Accent or v0_8.Element
		local v2_322 = v2_320 and v0_8.Accent:Lerp(v0_8.Text, 0.15) or v0_8.Hover
		local v2_323 = Instance.new("TextButton")
		v2_323.Name = "Button"
		v2_323.Size = UDim2.new(0, 0, 0, 30)
		v2_323.AutomaticSize = Enum.AutomaticSize.X
		v2_323.BackgroundColor3 = v2_321
		v2_323.BorderSizePixel = 0
		v2_323.Text = self:T(tostring(v2_319.Title or "OK"))
		v2_323.TextColor3 = v0_8.Text
		v2_323.Font = Enum.Font.Gotham
		v2_323.TextSize = 13
		v2_323.AutoButtonColor = false
		v2_323.LayoutOrder = v2_318
		v2_323.Parent = v1_311
		v0_63(v2_323, 6)
		local v2_324 = Instance.new("UIPadding")
		v2_324.PaddingLeft = UDim.new(0, 14)
		v2_324.PaddingRight = UDim.new(0, 14)
		v2_324.Parent = v2_323
		v0_21(v2_323, v2_321, v2_322)
		v2_323.MouseButton1Click:Connect(function()
			if v1_291 then return end
			v1_313()
			if v2_319.Callback then v2_319.Callback() end
		end)
	end
	v1_295.MouseButton1Click:Connect(function()
		if v1_293.Dismissable then v1_313() end
	end)
	table.insert(self._dialogs, v1_293)
	v1_292 = {
		v0_12(v1_295, { BackgroundTransparency = 0.45 }, 0.2),
		v0_12(v1_296, { GroupTransparency = 0 }, 0.22),
		v0_12(v1_298, { Scale = 1 }, 0.3, Enum.EasingStyle.Back),
	}
	return { Close = v1_313 }
end
function v0_1:_buildWatermark(v1_325)
	local v1_326 = Instance.new("Frame")
	v1_326.Name = "Watermark"
	v1_326.AnchorPoint = Vector2.new(0.5, 0)
	v1_326.Position = UDim2.new(0.5, 0, 0, -40)
	v1_326.Size = UDim2.new(0, 0, 0, 30)
	v1_326.AutomaticSize = Enum.AutomaticSize.X
	v1_326.BackgroundColor3 = v0_8.Sidebar
	v1_326.BorderSizePixel = 0
	v1_326.Parent = self.ScreenGui
	v0_63(v1_326, 8)
	local v1_327 = Instance.new("UIStroke")
	v1_327.Color = v0_8.Element
	v1_327.Thickness = 1
	v1_327.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	v1_327.Parent = v1_326
	local v1_328 = Instance.new("UIPadding")
	v1_328.PaddingLeft = UDim.new(0, 10)
	v1_328.PaddingRight = UDim.new(0, 4)
	v1_328.Parent = v1_326
	local v1_329 = Instance.new("UIListLayout")
	v1_329.FillDirection = Enum.FillDirection.Horizontal
	v1_329.VerticalAlignment = Enum.VerticalAlignment.Center
	v1_329.Padding = UDim.new(0, 8)
	v1_329.SortOrder = Enum.SortOrder.LayoutOrder
	v1_329.Parent = v1_326
	local v1_330 = Instance.new("TextLabel")
	v1_330.Name = "Title"
	v1_330.Size = UDim2.new(0, 0, 1, 0)
	v1_330.AutomaticSize = Enum.AutomaticSize.X
	v1_330.BackgroundTransparency = 1
	v1_330.BorderSizePixel = 0
	self:_track(v1_330, "Text", v1_325)
	v1_330.TextColor3 = v0_8.SubText
	v1_330.Font = Enum.Font.GothamBold
	v1_330.TextSize = 13
	v1_330.LayoutOrder = 1
	v1_330.Parent = v1_326
	local v1_331 = Instance.new("TextButton")
	v1_331.Name = "ToggleButton"
	v1_331.Size = UDim2.new(0, 22, 0, 22)
	v1_331.BackgroundColor3 = v0_8.Element
	v1_331.BorderSizePixel = 0
	v1_331.Text = ""
	v1_331.AutoButtonColor = false
	v1_331.LayoutOrder = 2
	v1_331.Parent = v1_326
	v0_63(v1_331, 6)
	local v1_332 = Instance.new("ImageLabel")
	v1_332.Name = "Icon"
	v1_332.AnchorPoint = Vector2.new(0.5, 0.5)
	v1_332.Position = UDim2.new(0.5, 0, 0.5, 0)
	v1_332.Size = UDim2.new(0, 14, 0, 14)
	v1_332.BackgroundTransparency = 1
	v1_332.BorderSizePixel = 0
	v1_332.ImageColor3 = v0_8.IconOn
	v1_332.ScaleType = Enum.ScaleType.Fit
	v1_332.Parent = v1_331
	local v1_333 = Instance.new("TextLabel")
	v1_333.Name = "IconFallback"
	v1_333.Size = UDim2.new(1, 0, 1, 0)
	v1_333.BackgroundTransparency = 1
	v1_333.TextColor3 = v0_8.IconOn
	v1_333.Font = Enum.Font.GothamBold
	v1_333.TextSize = 12
	v1_333.Visible = false
	v1_333.Parent = v1_332
	local v1_334 = Instance.new("UIScale")
	v1_334.Parent = v1_331
	v1_331.MouseEnter:Connect(function() v0_12(v1_334, { Scale = 1.1 }, 0.12) end)
	v1_331.MouseLeave:Connect(function() v0_12(v1_334, { Scale = 1 }, 0.12) end)
	v1_331.InputBegan:Connect(function(v2_335)
		if v0_19(v2_335) then v0_12(v1_334, { Scale = 0.9 }, 0.08) end
	end)
	v1_331.InputEnded:Connect(function(v2_336)
		if v0_19(v2_336) then v0_12(v1_334, { Scale = 1.1 }, 0.15, Enum.EasingStyle.Back) end
	end)
	v1_331.MouseButton1Click:Connect(function()
		self:Toggle()
	end)
	local v1_337, v1_338, v1_339 = false, nil, nil
	v1_330.InputBegan:Connect(function(v2_340)
		if v0_19(v2_340) then
			v1_337 = true
			v1_338 = v2_340.Position
			v1_339 = v1_326.AbsolutePosition + Vector2.new(v1_326.AbsoluteSize.X / 2, 0)
			v2_340.Changed:Connect(function()
				if v2_340.UserInputState == Enum.UserInputState.End then v1_337 = false end
			end)
		end
	end)
	table.insert(self._connections, v0_4.InputChanged:Connect(function(v2_341)
		if not v1_337 then return end
		if v2_341.UserInputType ~= Enum.UserInputType.MouseMovement and v2_341.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		local v2_342 = v2_341.Position - v1_338
		local v2_343 = self.ScreenGui.AbsoluteSize
		local v2_344 = v1_326.AbsoluteSize.X / 2
		local v2_345 = math.clamp(v1_339.X + v2_342.X, v2_344, math.max(v2_343.X - v2_344, v2_344))
		local v2_346 = math.clamp(v1_339.Y + v2_342.Y, 0, math.max(v2_343.Y - v1_326.AbsoluteSize.Y, 0))
		v1_326.Position = UDim2.fromOffset(v2_345, v2_346)
	end))
	self._wm = { Frame = v1_326, Button = v1_331, Icon = v1_332, Fallback = v1_333 }
	v0_12(v1_326, { Position = UDim2.new(0.5, 0, 0, 10) }, 0.5, Enum.EasingStyle.Back)
end
function v0_1:_updateWatermark()
	local v1_347 = self._wm
	if not v1_347 then return end
	local v1_348 = self._visible == true
	v0_12(v1_347.Button, { BackgroundColor3 = v1_348 and v0_8.Accent or v0_8.Element }, 0.2)
	local v1_349 = v0_44(v1_347.Icon, v1_348 and "eye" or "eye-off", self.Icons)
	if not v1_349 then v1_347.Icon.Image = "" end
	v1_347.Fallback.Visible = not v1_349
	v1_347.Fallback.Text = v1_348 and "●" or "○"
	v1_347.Icon.ImageTransparency = 1
	v0_12(v1_347.Icon, { ImageTransparency = 0 }, 0.2)
end
local function v0_350(v1_351, v1_352)
	local v1_353 = v1_351.Glow
	if not v1_353 then return end
	for v2_354, v2_355 in ipairs(v1_353.Layers) do
		v0_12(v2_355.Obj, { [v2_355.Prop] = v1_352 and v2_355.On or 1 }, 0.25, Enum.EasingStyle.Quad)
	end
end
local function v0_356(v1_357, v1_358)
	v0_12(v1_357.Icon, { ImageColor3 = v1_358 }, 0.2)
	if v1_357.Fallback then
		v0_12(v1_357.Fallback, { TextColor3 = v1_358 }, 0.2)
	end
end
function v0_1:AddTab(v1_359)
	v1_359 = v1_359 or {}
	local v1_360 = Instance.new("TextButton")
	v1_360.Name = "TabButton"
	v1_360.Size = UDim2.new(0, 36, 0, 36)
	v1_360.BackgroundColor3 = v0_8.Card
	v1_360.BorderSizePixel = 0
	v1_360.Text = ""
	v1_360.AutoButtonColor = false
	v1_360.LayoutOrder = #self.Tabs + 1
	v1_360.Parent = self.Sidebar
	v0_63(v1_360, 6)
	local v1_361 = Instance.new("ImageLabel")
	v1_361.Name = "Icon"
	v1_361.AnchorPoint = Vector2.new(0.5, 0.5)
	v1_361.Size = UDim2.new(0, 20, 0, 20)
	v1_361.Position = UDim2.new(0.5, 0, 0.5, 0)
	v1_361.BackgroundTransparency = 1
	v1_361.BorderSizePixel = 0
	v1_361.ImageColor3 = v0_8.IconOff
	v1_361.ScaleType = Enum.ScaleType.Fit
	v1_361.Parent = v1_360
	local v1_362
	if not v0_44(v1_361, v1_359.Icon, self.Icons) then
		v1_362 = Instance.new("TextLabel")
		v1_362.Name = "IconFallback"
		v1_362.Size = UDim2.new(1, 0, 1, 0)
		v1_362.BackgroundTransparency = 1
		v1_362.Text = string.upper(string.sub(tostring(v1_359.Name or v1_359.Icon or "?"), 1, 1))
		v1_362.TextColor3 = v0_8.IconOff
		v1_362.Font = Enum.Font.GothamBold
		v1_362.TextSize = 16
		v1_362.Parent = v1_361
	end
	local v1_363
	if self.IconGlow then
		v1_360.BackgroundTransparency = 1
		v1_361.ZIndex = 2
		v1_363 = { Layers = {} }
		if v1_361.Image ~= "" then
			for v4_364, v4_365 in ipairs({ { 26, 0.55 }, { 33, 0.82 } }) do
				local v4_366 = Instance.new("ImageLabel")
				v4_366.Name = "Glow"
				v4_366.AnchorPoint = Vector2.new(0.5, 0.5)
				v4_366.Position = UDim2.new(0.5, 0, 0.5, 0)
				v4_366.Size = UDim2.new(0, v4_365[1], 0, v4_365[1])
				v4_366.BackgroundTransparency = 1
				v4_366.BorderSizePixel = 0
				v4_366.Image = v1_361.Image
				v4_366.ImageRectSize = v1_361.ImageRectSize
				v4_366.ImageRectOffset = v1_361.ImageRectOffset
				v4_366.ImageColor3 = v0_8.Accent
				v4_366.ImageTransparency = 1
				v4_366.ScaleType = Enum.ScaleType.Fit
				v4_366.ZIndex = 1
				v4_366.Parent = v1_360
				table.insert(v1_363.Layers, { Obj = v4_366, Prop = "ImageTransparency", On = v4_365[2] })
			end
		elseif v1_362 then
			local v3_367 = Instance.new("UIStroke")
			v3_367.Color = v0_8.Accent
			v3_367.Thickness = 1
			v3_367.Transparency = 1
			v3_367.Parent = v1_362
			table.insert(v1_363.Layers, { Obj = v3_367, Prop = "Transparency", On = 0.45 })
		end
	end
	local v1_368 = Instance.new("ScrollingFrame")
	v1_368.Name = "Page"
	v1_368.Size = UDim2.new(1, 0, 1, 0)
	v1_368.BackgroundTransparency = 1
	v1_368.BorderSizePixel = 0
	v1_368.ScrollBarThickness = 3
	v1_368.ScrollBarImageColor3 = v0_8.IconOff
	v1_368.ScrollingDirection = Enum.ScrollingDirection.Y
	v1_368.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v1_368.CanvasSize = UDim2.new(0, 0, 0, 0)
	v1_368.Visible = false
	v1_368.Parent = self.Content
	local v1_369 = Instance.new("Frame")
	v1_369.Name = "Inner"
	v1_369.Size = UDim2.new(1, 0, 0, 0)
	v1_369.AutomaticSize = Enum.AutomaticSize.Y
	v1_369.BackgroundTransparency = 1
	v1_369.BorderSizePixel = 0
	v1_369.Parent = v1_368
	local v1_370 = Instance.new("UIPadding")
	v1_370.PaddingTop = UDim.new(0, 12)
	v1_370.PaddingBottom = UDim.new(0, 12)
	v1_370.Parent = v1_369
	local v1_371 = Instance.new("Frame")
	v1_371.Name = "Split"
	v1_371.Position = UDim2.new(0, 12, 0, 0)
	v1_371.Size = UDim2.new(1, -26, 0, 0)
	v1_371.AutomaticSize = Enum.AutomaticSize.Y
	v1_371.BackgroundTransparency = 1
	v1_371.BorderSizePixel = 0
	v1_371.Parent = v1_369
	local v1_372 = Instance.new("UIListLayout")
	v1_372.FillDirection = Enum.FillDirection.Horizontal
	v1_372.Padding = UDim.new(0, 8)
	v1_372.SortOrder = Enum.SortOrder.LayoutOrder
	v1_372.Parent = v1_371
	local function v1_373(v2_374)
		local v2_375 = Instance.new("Frame")
		v2_375.Name = v2_374 == 1 and "Left" or "Right"
		v2_375.Size = UDim2.new(0.5, -4, 0, 0)
		v2_375.AutomaticSize = Enum.AutomaticSize.Y
		v2_375.BackgroundTransparency = 1
		v2_375.BorderSizePixel = 0
		v2_375.LayoutOrder = v2_374
		v2_375.Parent = v1_371
		local v2_376 = Instance.new("UIListLayout")
		v2_376.Padding = UDim.new(0, 8)
		v2_376.SortOrder = Enum.SortOrder.LayoutOrder
		v2_376.Parent = v2_375
		return v2_375
	end
	local v1_377 = setmetatable({
		Page = v1_368,
		Button = v1_360,
		Icon = v1_361,
		Fallback = v1_362,
		Glow = v1_363,
		Inner = v1_369,
		_icons = self.Icons,
		_lib = self,
		Left = v1_373(1),
		Right = v1_373(2),
		_sectionCount = 0,
	}, v0_2)
	table.insert(self.Tabs, v1_377)
	for v2_378, v2_379 in ipairs({ "CanvasPosition", "AbsoluteCanvasSize", "AbsoluteWindowSize" }) do
		table.insert(self._connections, v1_368:GetPropertyChangedSignal(v2_379):Connect(function()
			if self.ActiveTab == v1_377 then self:_updateScrollHint() end
		end))
	end
	if self.IconGlow then
		v1_360.MouseEnter:Connect(function()
			if self.ActiveTab ~= v1_377 then v0_356(v1_377, v0_8.SubText) end
		end)
		v1_360.MouseLeave:Connect(function()
			if self.ActiveTab ~= v1_377 then v0_356(v1_377, v0_8.IconOff) end
		end)
	end
	v0_21(v1_360, v0_8.Card, v0_8.Element, function()
		return self.ActiveTab == v1_377
	end)
	v1_360.MouseButton1Click:Connect(function()
		self:SelectTab(v1_377)
	end)
	if not self.ActiveTab then self:SelectTab(v1_377) end
	return v1_377
end
function v0_1:SelectTab(v1_380)
	if self.ActiveTab == v1_380 then return end
	local v1_381 = self.ActiveTab
	self.ActiveTab = v1_380
	if v1_381 then
		v1_381.Page.Visible = false
		if self.IconGlow then
			v0_350(v1_381, false)
		else
			v0_12(v1_381.Button, { BackgroundColor3 = v0_8.Card }, 0.2)
		end
		v0_356(v1_381, v0_8.IconOff)
	end
	v1_380.Inner.Position = UDim2.new(0, 0, 0, 14)
	v1_380.Page.Visible = true
	v0_12(v1_380.Inner, { Position = UDim2.new(0, 0, 0, 0) }, 0.3, Enum.EasingStyle.Quint)
	if self.IconGlow then
		v0_350(v1_380, true)
	else
		v0_12(v1_380.Button, { BackgroundColor3 = v0_8.Accent }, 0.2)
	end
	v0_356(v1_380, v0_8.IconOn)
	self:_updateScrollHint()
end
function v0_2:AddSection(v1_382, v1_383, v1_384)
	local v1_385 = (v1_383 == "right") and self.Right or self.Left
	local v1_386 = self._lib
	self._sectionCount += 1
	local v1_387 = Instance.new("Frame")
	v1_387.Name = "Section"
	v1_387.Size = UDim2.new(1, 0, 0, 0)
	v1_387.AutomaticSize = Enum.AutomaticSize.Y
	v1_387.BackgroundColor3 = v0_8.Card
	v1_387.BorderSizePixel = 0
	v1_387.LayoutOrder = self._sectionCount
	v1_387.Parent = v1_385
	v0_63(v1_387, 6)
	local v1_388 = Instance.new("UIPadding")
	v1_388.PaddingTop = UDim.new(0, 8)
	v1_388.PaddingBottom = UDim.new(0, 8)
	v1_388.PaddingLeft = UDim.new(0, 8)
	v1_388.PaddingRight = UDim.new(0, 8)
	v1_388.Parent = v1_387
	local v1_389 = Instance.new("UIListLayout")
	v1_389.Padding = UDim.new(0, 6)
	v1_389.SortOrder = Enum.SortOrder.LayoutOrder
	v1_389.Parent = v1_387
	local v1_390 = Instance.new("Frame")
	v1_390.Name = "Body"
	v1_390.Size = UDim2.new(1, 0, 0, 0)
	v1_390.AutomaticSize = Enum.AutomaticSize.Y
	v1_390.BackgroundTransparency = 1
	v1_390.BorderSizePixel = 0
	v1_390.LayoutOrder = 1
	v1_390.Parent = v1_387
	local v1_391 = Instance.new("UIListLayout")
	v1_391.Padding = UDim.new(0, 6)
	v1_391.SortOrder = Enum.SortOrder.LayoutOrder
	v1_391.Parent = v1_390
	local v1_392 = false
	local v1_393 = false
	local v1_394
	local v1_395 = {}
	local v1_396, v1_397
	local function v1_398()
		local v2_399 = (not v1_393) and v1_386._scale and v1_386._scale.Scale or 1
		return math.max(v1_391.AbsoluteContentSize.Y / (v2_399 > 0 and v2_399 or 1), 0)
	end
	local function v1_400()
		v1_390.AutomaticSize = Enum.AutomaticSize.Y
		v1_390.Size = UDim2.new(1, 0, 0, 0)
		v1_390.ClipsDescendants = false
	end
	local function v1_401(v2_402, v2_403)
		if v2_402 == v1_392 and not v2_403 then return end
		v1_392 = v2_402
		for v3_404, v3_405 in ipairs(v1_395) do v3_405:Cancel() end
		v1_395 = {}
		if v1_396 then
			if v2_403 then
				v1_396.Rotation = v2_402 and -90 or 0
			else
				v0_12(v1_396, { Rotation = v2_402 and -90 or 0 }, 0.22, Enum.EasingStyle.Quint)
			end
		end
		if v2_403 then
			v1_390.Visible = not v2_402
			v1_389.Padding = UDim.new(0, v2_402 and 0 or 6)
			v1_400()
			return
		end
		v1_390.ClipsDescendants = true
		if v2_402 then
			if v1_390.AutomaticSize ~= Enum.AutomaticSize.None then
				local v4_406 = v1_398()
				v1_390.AutomaticSize = Enum.AutomaticSize.None
				v1_390.Size = UDim2.new(1, 0, 0, v4_406)
			end
			local v3_407 = v0_12(v1_390, { Size = UDim2.new(1, 0, 0, 0) }, 0.25, Enum.EasingStyle.Quint)
			v1_395 = { v3_407, v0_12(v1_389, { Padding = UDim.new(0, 0) }, 0.25, Enum.EasingStyle.Quint) }
			v3_407.Completed:Connect(function(v4_408)
				if v4_408 == Enum.PlaybackState.Completed and v1_392 then
					v1_390.Visible = false
					v1_390.ClipsDescendants = false
				end
			end)
		else
			v1_390.Visible = true
			local v3_409 = v1_398()
			if v3_409 <= 0 then
				v1_389.Padding = UDim.new(0, 6)
				v1_400()
				return
			end
			if v1_390.AutomaticSize ~= Enum.AutomaticSize.None then
				v1_390.AutomaticSize = Enum.AutomaticSize.None
				v1_390.Size = UDim2.new(1, 0, 0, 0)
			end
			local v3_410 = v0_12(v1_390, { Size = UDim2.new(1, 0, 0, v3_409) }, 0.28, Enum.EasingStyle.Quint)
			v1_395 = { v3_410, v0_12(v1_389, { Padding = UDim.new(0, 6) }, 0.28, Enum.EasingStyle.Quint) }
			v3_410.Completed:Connect(function(v4_411)
				if v4_411 == Enum.PlaybackState.Completed and not v1_392 then
					v1_400()
				end
			end)
		end
	end
	if v1_382 then
		local v2_412 = Instance.new("TextButton")
		v2_412.Name = "Header"
		v2_412.Size = UDim2.new(1, 0, 0, 16)
		v2_412.BackgroundTransparency = 1
		v2_412.BorderSizePixel = 0
		v2_412.Text = ""
		v2_412.AutoButtonColor = false
		v2_412.LayoutOrder = 0
		v2_412.Parent = v1_387
		local v2_413 = Instance.new("TextLabel")
		v2_413.Name = "Title"
		v2_413.Size = UDim2.new(1, -44, 1, 0)
		v2_413.BackgroundTransparency = 1
		v2_413.BorderSizePixel = 0
		v1_386:_track(v2_413, "Text", v1_382)
		v2_413.TextColor3 = v0_8.SubText
		v2_413.Font = Enum.Font.GothamBold
		v2_413.TextSize = 13
		v2_413.TextXAlignment = Enum.TextXAlignment.Left
		v2_413.TextTruncate = Enum.TextTruncate.AtEnd
		v2_413.Parent = v2_412
		v1_396 = Instance.new("ImageLabel")
		v1_396.Name = "Chevron"
		v1_396.AnchorPoint = Vector2.new(1, 0.5)
		v1_396.Position = UDim2.new(1, 0, 0.5, 0)
		v1_396.Size = UDim2.new(0, 14, 0, 14)
		v1_396.BackgroundTransparency = 1
		v1_396.BorderSizePixel = 0
		v1_396.ImageColor3 = v0_8.SubText
		v1_396.ScaleType = Enum.ScaleType.Fit
		v1_396.Parent = v2_412
		v1_397 = Instance.new("TextLabel")
		v1_397.Name = "ChevronFallback"
		v1_397.Size = UDim2.new(1, 0, 1, 0)
		v1_397.BackgroundTransparency = 1
		v1_397.Text = "▼"
		v1_397.TextColor3 = v0_8.SubText
		v1_397.Font = Enum.Font.Gotham
		v1_397.TextSize = 9
		v1_397.Parent = v1_396
		v1_397.Visible = not v0_44(v1_396, "chevron-down", self._icons)
		local v2_414 = Instance.new("TextButton")
		v2_414.Name = "MoveHandle"
		v2_414.AnchorPoint = Vector2.new(1, 0.5)
		v2_414.Position = UDim2.new(1, -22, 0.5, 0)
		v2_414.Size = UDim2.new(0, 16, 0, 16)
		v2_414.BackgroundTransparency = 1
		v2_414.BorderSizePixel = 0
		v2_414.Text = ""
		v2_414.AutoButtonColor = false
		v2_414.Parent = v2_412
		local v2_415 = Instance.new("ImageLabel")
		v2_415.Name = "Icon"
		v2_415.AnchorPoint = Vector2.new(0.5, 0.5)
		v2_415.Position = UDim2.new(0.5, 0, 0.5, 0)
		v2_415.Size = UDim2.new(0, 14, 0, 14)
		v2_415.BackgroundTransparency = 1
		v2_415.BorderSizePixel = 0
		v2_415.ImageColor3 = v0_8.SubText
		v2_415.ScaleType = Enum.ScaleType.Fit
		v2_415.Parent = v2_414
		local v2_416 = Instance.new("TextLabel")
		v2_416.Name = "IconFallback"
		v2_416.Size = UDim2.new(1, 0, 1, 0)
		v2_416.BackgroundTransparency = 1
		v2_416.Text = "✥"
		v2_416.TextColor3 = v0_8.SubText
		v2_416.Font = Enum.Font.Gotham
		v2_416.TextSize = 12
		v2_416.Parent = v2_415
		v2_416.Visible = not v0_44(v2_415, "move", self._icons)
		v2_414.MouseEnter:Connect(function()
			v0_12(v2_415, { ImageColor3 = v0_8.Text }, 0.12)
			v0_12(v2_416, { TextColor3 = v0_8.Text }, 0.12)
		end)
		v2_414.MouseLeave:Connect(function()
			v0_12(v2_415, { ImageColor3 = v0_8.SubText }, 0.15)
			v0_12(v2_416, { TextColor3 = v0_8.SubText }, 0.15)
		end)
		local v2_417, v2_418, v2_419
		local function v2_420()
			if v2_417 then return end
			v2_417 = Instance.new("CanvasGroup")
			v2_417.Name = "FloatingSection"
			v2_417.Size = UDim2.new(0, 200, 0, 0)
			v2_417.AutomaticSize = Enum.AutomaticSize.Y
			v2_417.BackgroundTransparency = 1
			v2_417.BorderSizePixel = 0
			v2_417.Active = true
			v2_417.Visible = false
			v2_417.Parent = v1_386.ScreenGui
			v0_63(v2_417, 6)
			v2_418 = Instance.new("ScrollingFrame")
			v2_418.Name = "Scroll"
			v2_418.Size = UDim2.new(1, 0, 0, 0)
			v2_418.AutomaticSize = Enum.AutomaticSize.Y
			v2_418.BackgroundTransparency = 1
			v2_418.BorderSizePixel = 0
			v2_418.ScrollBarThickness = 3
			v2_418.ScrollBarImageColor3 = v0_8.IconOff
			v2_418.ScrollingDirection = Enum.ScrollingDirection.Y
			v2_418.AutomaticCanvasSize = Enum.AutomaticSize.Y
			v2_418.CanvasSize = UDim2.new(0, 0, 0, 0)
			v2_418.Parent = v2_417
			v2_419 = Instance.new("UISizeConstraint")
			v2_419.Parent = v2_418
		end
		local function v2_421()
			v2_419.MaxSize = Vector2.new(math.huge, math.max(120, v1_386.ScreenGui.AbsoluteSize.Y * 0.7))
		end
		local function v2_422()
			local v3_423 = v2_417.AbsolutePosition + v2_417.AbsoluteSize / 2
			local v3_424, v3_425 = v1_386.Main.AbsolutePosition, v1_386.Main.AbsoluteSize
			return v3_423.X >= v3_424.X and v3_423.X <= v3_424.X + v3_425.X and v3_423.Y >= v3_424.Y and v3_423.Y <= v3_424.Y + v3_425.Y
		end
		local function v2_426(v3_427, v3_428, v3_429)
			v2_420()
			v2_421()
			v1_386._floatZ += 1
			v2_417.ZIndex = v1_386._floatZ
			v2_417.Size = UDim2.new(0, v3_429, 0, 0)
			v2_417.Position = UDim2.fromOffset(v3_427, v3_428)
			v1_387.Parent = v2_418
			v1_387.Size = UDim2.new(1, 0, 0, 0)
			v2_417.GroupTransparency = v1_386._visible == false and 1 or 0
			v2_417.Visible = v1_386._visible ~= false
			v1_393 = true
			v1_386._floats[v2_417] = true
		end
		v1_394 = function()
			if not v1_393 then return end
			v1_393 = false
			v1_386._floats[v2_417] = false
			v1_387.Parent = v1_385
			v1_387.Size = UDim2.new(1, 0, 0, 0)
			v2_417.Visible = false
		end
		local v2_430 = nil
		local function v2_431()
			if v2_430 then
				for v5_432, v5_433 in ipairs(v2_430) do v5_433:Disconnect() end
				v2_430 = nil
			end
		end
		v2_414.InputBegan:Connect(function(v3_434)
			if not v0_19(v3_434) then return end
			v2_431()
			local v3_435 = v3_434.Position
			local v3_436, v3_437 = false, nil
			v2_430 = {
				v0_4.InputChanged:Connect(function(v4_438)
					if v4_438.UserInputType ~= Enum.UserInputType.MouseMovement and v4_438 ~= v3_434 then return end
					local v4_439 = v4_438.Position - v3_435
					if not v3_436 then
						if v4_439.Magnitude < 4 then return end
						v3_436 = true
						if v1_393 then
							v3_437 = v2_417.AbsolutePosition
							v1_386._floatZ += 1
							v2_417.ZIndex = v1_386._floatZ
						else
							v3_437 = v1_387.AbsolutePosition
							v2_426(v3_437.X, v3_437.Y, v1_387.AbsoluteSize.X)
						end
					end
					local v4_440 = v1_386.ScreenGui.AbsoluteSize
					local v4_441 = v2_417.AbsoluteSize.X
					local v4_442 = math.clamp(v3_437.X + v4_439.X, 60 - v4_441, math.max(v4_440.X - 60, 60 - v4_441))
					local v4_443 = math.clamp(v3_437.Y + v4_439.Y, 0, math.max(v4_440.Y - 30, 0))
					v2_417.Position = UDim2.fromOffset(v4_442, v4_443)
					v2_421()
					v0_12(v2_417, { GroupTransparency = v2_422() and 0.25 or 0 }, 0.1)
				end),
				v0_4.InputEnded:Connect(function(v4_444)
					if v4_444 == v3_434 or v4_444.UserInputType == Enum.UserInputType.MouseButton1 then
						v2_431()
						if v3_436 and v1_393 then
							v0_12(v2_417, { GroupTransparency = 0 }, 0.1)
							if v1_386._visible ~= false and v2_422() then v1_394() end
						end
					end
				end),
			}
		end)
		v1_386._cleanups[v2_414] = v2_431
		v2_412.MouseEnter:Connect(function()
			v0_12(v2_413, { TextColor3 = v0_8.Text }, 0.12)
			v0_12(v1_396, { ImageColor3 = v0_8.Text }, 0.12)
			v0_12(v1_397, { TextColor3 = v0_8.Text }, 0.12)
		end)
		v2_412.MouseLeave:Connect(function()
			v0_12(v2_413, { TextColor3 = v0_8.SubText }, 0.15)
			v0_12(v1_396, { ImageColor3 = v0_8.SubText }, 0.15)
			v0_12(v1_397, { TextColor3 = v0_8.SubText }, 0.15)
		end)
		v2_412.MouseButton1Click:Connect(function()
			v1_401(not v1_392)
		end)
	end
	local v1_445 = setmetatable({
		Holder = v1_390,
		Card = v1_387,
		_count = 0,
		_icons = self._icons,
		_lib = self._lib,
		_setCollapsed = v1_401,
		_isCollapsed = function() return v1_392 end,
		_isFloating = function() return v1_393 end,
		_dock = function() if v1_394 then v1_394() end end,
	}, v0_3)
	if v1_382 and v1_384 == true then
		v1_401(true, true)
	end
	return v1_445
end
function v0_3:SetCollapsed(v1_446)
	self._setCollapsed(v1_446 == true)
end
function v0_3:ToggleCollapsed()
	self._setCollapsed(not self._isCollapsed())
end
function v0_3:IsFloating()
	return self._isFloating()
end
function v0_3:Dock()
	self._dock()
end
function v0_3:IsCollapsed()
	return self._isCollapsed()
end
local function v0_447(v1_448)
	if typeof(v1_448) == "EnumItem" and v1_448.EnumType == Enum.KeyCode then return v1_448 end
	if type(v1_448) == "string" then
		local v2_449, v2_450 = pcall(function() return Enum.KeyCode[v1_448] end)
		if v2_449 then return v2_450 end
	end
	return nil
end
local function v0_451(v1_452, v1_453, v1_454, v1_455, v1_456)
	v1_454 = v1_454 or {}
	local v1_457 = v1_454.CanBeChanged ~= false
	local v1_458 = {}
	local v1_459 = { _key = nil, _onPress = v1_456, _isListening = false, _destroyed = false }
	local v1_460 = Instance.new("TextButton")
	v1_460.Name = "Keybind"
	v1_460.AnchorPoint = Vector2.new(1, 0.5)
	v1_460.Position = v1_455
	v1_460.Size = UDim2.new(0, 0, 0, 20)
	v1_460.AutomaticSize = Enum.AutomaticSize.X
	v1_460.BackgroundColor3 = v0_8.Card
	v1_460.BorderSizePixel = 0
	v1_460.Text = v0_82("None")
	v1_460.TextColor3 = v0_8.SubText
	v1_460.Font = Enum.Font.Gotham
	v1_460.TextSize = 12
	v1_460.TextTruncate = Enum.TextTruncate.AtEnd
	v1_460.AutoButtonColor = false
	v1_460.Parent = v1_453
	v0_63(v1_460, 5)
	v1_459.Instance = v1_460
	local v1_461 = Instance.new("UIPadding")
	v1_461.PaddingLeft = UDim.new(0, 7)
	v1_461.PaddingRight = UDim.new(0, 7)
	v1_461.Parent = v1_460
	local v1_462 = Instance.new("UISizeConstraint")
	v1_462.MinSize = Vector2.new(30, 20)
	v1_462.MaxSize = Vector2.new(96, 20)
	v1_462.Parent = v1_460
	local function v1_463()
		if v1_459._isListening then
			v1_460.Text = "..."
		else
			v1_460.Text = v1_459._key and v1_459._key.Name or v0_82("None")
		end
	end
	v1_452:_onLang(v1_460, v1_463)
	local function v1_464()
		v1_460.BackgroundColor3 = v0_8.Danger
		v0_12(v1_460, { BackgroundColor3 = v0_8.Card }, 0.45)
	end
	function v1_459:Set(v2_465, v2_466)
		v2_465 = v0_447(v2_465)
		if v2_465 and v1_452:_keyTaken(v2_465, v1_459) then
			warn("[RobloxUI] key already in use:", v2_465.Name)
			v1_464()
			return false
		end
		v1_459._key = v2_465
		v1_463()
		if not v2_466 and v1_454.Callback then v1_454.Callback(v2_465) end
		return true
	end
	function v1_459:Get()
		return v1_459._key
	end
	function v1_459:_startListening()
		if v1_452._listening and v1_452._listening ~= v1_459 then
			v1_452._listening:_stopListening()
		end
		v1_452._listening = v1_459
		v1_459._isListening = true
		v0_12(v1_460, { BackgroundColor3 = v0_8.Accent }, 0.15)
		v1_463()
	end
	function v1_459:_stopListening()
		if v1_452._listening == v1_459 then v1_452._listening = nil end
		v1_459._isListening = false
		v0_12(v1_460, { BackgroundColor3 = v0_8.Card }, 0.15)
		v1_463()
	end
	function v1_459:_capture(v2_467)
		if v2_467 == Enum.KeyCode.Unknown then return end
		v1_459:_stopListening()
		if v2_467 == Enum.KeyCode.Escape then return end
		if v2_467 == Enum.KeyCode.Backspace or v2_467 == Enum.KeyCode.Delete then
			v1_459:Set(nil)
		else
			v1_459:Set(v2_467)
		end
	end
	function v1_459:Destroy()
		if v1_459._destroyed then return end
		v1_459._destroyed = true
		if v1_452._listening == v1_459 then v1_452._listening = nil end
		local v2_468 = table.find(v1_452._binds, v1_459)
		if v2_468 then table.remove(v1_452._binds, v2_468) end
		v1_452._cleanups[v1_459] = nil
		for v3_469, v3_470 in ipairs(v1_458) do v3_470:Disconnect() end
		v1_458 = {}
		v1_460:Destroy()
	end
	if v1_457 then
		v0_21(v1_460, v0_8.Card, v0_8.Sidebar, function() return v1_459._isListening end)
		table.insert(v1_458, v1_460.MouseButton1Click:Connect(function()
			if v1_459._isListening then v1_459:_stopListening() else v1_459:_startListening() end
		end))
		table.insert(v1_458, v1_460.MouseButton2Click:Connect(function()
			if v1_459._isListening then v1_459:_stopListening() end
			v1_459:Set(nil)
		end))
	end
	if v1_454.Key ~= nil then
		v1_459:Set(v1_454.Key, true)
	end
	table.insert(v1_452._binds, v1_459)
	v1_452._cleanups[v1_459] = function() v1_459:Destroy() end
	return v1_459
end
local function v0_471(v1_472, v1_473, v1_474)
	local v1_475 = v1_473.Instance
	local function v1_476()
		local v2_477 = math.clamp(v1_475.TextBounds.X + 14, 30, 96)
		v1_472.Size = UDim2.new(1, -(v1_474 + v2_477 + 6), 1, 0)
	end
	v1_476()
	v1_475:GetPropertyChangedSignal("TextBounds"):Connect(v1_476)
end
function v0_3:AddButton(v1_478)
	v1_478 = v1_478 or {}
	self._count += 1
	local v1_479 = Instance.new("TextButton")
	v1_479.Name = "Button"
	v1_479.Size = UDim2.new(1, 0, 0, 32)
	v1_479.BackgroundColor3 = v0_8.Element
	v1_479.BorderSizePixel = 0
	self._lib:_track(v1_479, "Text", v1_478.Name or "Button")
	v1_479.TextColor3 = v0_8.Text
	v1_479.Font = Enum.Font.Gotham
	v1_479.TextSize = 14
	v1_479.TextTruncate = Enum.TextTruncate.AtEnd
	v1_479.AutoButtonColor = false
	v1_479.LayoutOrder = self._count
	v1_479.Parent = self.Holder
	v0_63(v1_479, 6)
	local v1_480 = Instance.new("UIPadding")
	v1_480.PaddingLeft = UDim.new(0, 8)
	v1_480.PaddingRight = UDim.new(0, 8)
	v1_480.Parent = v1_479
	v0_21(v1_479, v0_8.Element, v0_8.Hover)
	v1_479.MouseButton1Click:Connect(function()
		v1_479.BackgroundColor3 = v0_8.Accent
		v0_12(v1_479, { BackgroundColor3 = v0_8.Hover }, 0.3)
		if v1_478.Callback then v1_478.Callback() end
	end)
	return v1_479
end
function v0_3:AddToggle(v1_481)
	v1_481 = v1_481 or {}
	self._count += 1
	local v1_482 = v1_481.Default == true
	local v1_483 = self
	local v1_484 = Instance.new("TextButton")
	v1_484.Name = "Toggle"
	v1_484.Size = UDim2.new(1, 0, 0, 32)
	v1_484.BackgroundColor3 = v0_8.Element
	v1_484.BorderSizePixel = 0
	v1_484.Text = ""
	v1_484.AutoButtonColor = false
	v1_484.LayoutOrder = self._count
	v1_484.Parent = self.Holder
	v0_63(v1_484, 6)
	v0_21(v1_484, v0_8.Element, v0_8.Hover)
	local v1_485 = Instance.new("TextLabel")
	v1_485.Name = "Label"
	v1_485.Position = UDim2.new(0, 8, 0, 0)
	v1_485.Size = UDim2.new(1, -60, 1, 0)
	v1_485.BackgroundTransparency = 1
	v1_485.BorderSizePixel = 0
	self._lib:_track(v1_485, "Text", v1_481.Name or "Toggle")
	v1_485.TextColor3 = v0_8.Text
	v1_485.Font = Enum.Font.Gotham
	v1_485.TextSize = 14
	v1_485.TextXAlignment = Enum.TextXAlignment.Left
	v1_485.TextTruncate = Enum.TextTruncate.AtEnd
	v1_485.Parent = v1_484
	local v1_486 = Instance.new("Frame")
	v1_486.Name = "Track"
	v1_486.AnchorPoint = Vector2.new(1, 0.5)
	v1_486.Position = UDim2.new(1, -8, 0.5, 0)
	v1_486.Size = UDim2.new(0, 34, 0, 18)
	v1_486.BackgroundColor3 = v0_8.Off
	v1_486.BorderSizePixel = 0
	v1_486.Parent = v1_484
	v0_63(v1_486, 9)
	local v1_487 = Instance.new("Frame")
	v1_487.Name = "Knob"
	v1_487.AnchorPoint = Vector2.new(0, 0.5)
	v1_487.Position = UDim2.new(0, 2, 0.5, 0)
	v1_487.Size = UDim2.new(0, 14, 0, 14)
	v1_487.BackgroundColor3 = v0_8.Text
	v1_487.BorderSizePixel = 0
	v1_487.Parent = v1_486
	v0_63(v1_487, 7)
	local function v1_488(v2_489)
		local v2_490 = TweenInfo.new(v2_489 and 0.15 or 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v0_5:Create(v1_486, v2_490, { BackgroundColor3 = v1_482 and v0_8.Accent or v0_8.Off }):Play()
		v0_5:Create(v1_487, v2_490, {
			Position = v1_482 and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
		}):Play()
	end
	v1_488(false)
	local v1_491 = { Instance = v1_484 }
	function v1_491:Set(v2_492, v2_493)
		v1_482 = v2_492 and true or false
		v1_488(true)
		if not v2_493 and v1_481.Callback then v1_481.Callback(v1_482) end
	end
	function v1_491:Get()
		return v1_482
	end
	v1_484.MouseButton1Click:Connect(function()
		v1_491:Set(not v1_482)
	end)
	function v1_491:AddKeybind(v2_494)
		if v1_491.Keybind then
			warn("[RobloxUI] this toggle already has a keybind")
			return v1_491.Keybind
		end
		local v2_495 = v0_451(v1_483._lib, v1_484, v2_494, UDim2.new(1, -48, 0.5, 0), function()
			v1_491:Set(not v1_482)
		end)
		v0_471(v1_485, v2_495, 60)
		local v2_496 = v2_495.Destroy
		function v2_495:Destroy()
			v2_496(v2_495)
			v1_491.Keybind = nil
			v1_485.Size = UDim2.new(1, -60, 1, 0)
		end
		v1_491.Keybind = v2_495
		return v2_495
	end
	function v1_491:Destroy()
		if v1_491._destroyed then return end
		v1_491._destroyed = true
		if v1_491.Keybind then v1_491.Keybind:Destroy() end
		v1_484:Destroy()
	end
	return v1_491
end
function v0_3:AddParagraph(v1_497)
	v1_497 = v1_497 or {}
	self._count += 1
	local v1_498 = v1_497.Title and tostring(v1_497.Title) or ""
	local v1_499 = v1_497.Content and tostring(v1_497.Content) or ""
	local v1_500 = Instance.new("Frame")
	v1_500.Name = "Paragraph"
	v1_500.Size = UDim2.new(1, 0, 0, 0)
	v1_500.AutomaticSize = Enum.AutomaticSize.Y
	v1_500.BackgroundColor3 = v0_8.Element
	v1_500.BorderSizePixel = 0
	v1_500.LayoutOrder = self._count
	v1_500.Parent = self.Holder
	v0_63(v1_500, 6)
	local v1_501 = Instance.new("UIPadding")
	v1_501.PaddingTop = UDim.new(0, 8)
	v1_501.PaddingBottom = UDim.new(0, 8)
	v1_501.PaddingLeft = UDim.new(0, 8)
	v1_501.PaddingRight = UDim.new(0, 8)
	v1_501.Parent = v1_500
	local v1_502 = Instance.new("UIListLayout")
	v1_502.Padding = UDim.new(0, 3)
	v1_502.SortOrder = Enum.SortOrder.LayoutOrder
	v1_502.Parent = v1_500
	local function v1_503(v2_504, v2_505, v2_506, v2_507, v2_508)
		local v2_509 = Instance.new("TextLabel")
		v2_509.Name = v2_504
		v2_509.Size = UDim2.new(1, 0, 0, 0)
		v2_509.AutomaticSize = Enum.AutomaticSize.Y
		v2_509.BackgroundTransparency = 1
		v2_509.BorderSizePixel = 0
		v2_509.TextColor3 = v2_507
		v2_509.Font = v2_505
		v2_509.TextSize = v2_506
		v2_509.TextWrapped = true
		v2_509.RichText = v1_497.RichText == true
		v2_509.TextXAlignment = Enum.TextXAlignment.Left
		v2_509.TextYAlignment = Enum.TextYAlignment.Top
		v2_509.LayoutOrder = v2_508
		v2_509.Parent = v1_500
		return v2_509
	end
	local v1_510 = v1_503("Title", Enum.Font.GothamBold, 14, v0_8.Text, 1)
	local v1_511 = v1_503("Content", Enum.Font.Gotham, 13, v0_8.SubText, 2)
	local v1_512 = self._lib:_track(v1_510, "Text", "")
	local v1_513 = self._lib:_track(v1_511, "Text", "")
	local function v1_514(v2_515)
		v1_512.key = v1_498
		v1_510.Text = v0_82(v1_498)
		v1_510.Visible = v1_498 ~= ""
		v1_513.key = v1_499
		v1_511.Text = v0_82(v1_499)
		v1_511.Visible = v1_499 ~= ""
		if v2_515 then
			v1_510.TextTransparency = 1
			v1_511.TextTransparency = 1
			v0_12(v1_510, { TextTransparency = 0 }, 0.2)
			v0_12(v1_511, { TextTransparency = 0 }, 0.2)
		end
	end
	v1_514(false)
	local v1_516 = { Instance = v1_500 }
	function v1_516:SetTitle(v2_517)
		v1_498 = v2_517 and tostring(v2_517) or ""
		v1_514(true)
	end
	function v1_516:SetContent(v2_518)
		v1_499 = v2_518 and tostring(v2_518) or ""
		v1_514(true)
	end
	function v1_516:Set(v2_519)
		v2_519 = v2_519 or {}
		if v2_519.Title ~= nil then v1_498 = tostring(v2_519.Title) end
		if v2_519.Content ~= nil then v1_499 = tostring(v2_519.Content) end
		v1_514(true)
	end
	function v1_516:Get()
		return v1_498, v1_499
	end
	function v1_516:Destroy()
		v1_500:Destroy()
	end
	return v1_516
end
function v0_3:AddTextbox(v1_520)
	v1_520 = v1_520 or {}
	self._count += 1
	local v1_521 = v1_520.Numeric == true
	local v1_522 = tonumber(v1_520.MaxLength)
	local v1_523 = v1_520.Name ~= nil and v1_520.Name ~= ""
	local v1_524, v1_525, v1_526 = false, false, false
	local function v1_527(v2_528)
		if v1_520.Min then v2_528 = math.max(v2_528, v1_520.Min) end
		if v1_520.Max then v2_528 = math.min(v2_528, v1_520.Max) end
		return v2_528
	end
	local v1_529
	if v1_521 then
		v1_529 = tonumber(v1_520.Default)
		if v1_529 then v1_529 = v1_527(v1_529) end
	else
		v1_529 = tostring(v1_520.Default or "")
	end
	local function v1_530(v2_531)
		return v2_531 == nil and "" or tostring(v2_531)
	end
	local function v1_532(v2_533)
		local v2_534 = v2_533:sub(1, 1) == "-"
		v2_533 = v2_533:gsub("[^%d%.]", "")
		local v2_535 = v2_533:find(".", 1, true)
		if v2_535 then
			local v3_536 = v2_533:sub(v2_535 + 1):gsub("%.", "")
			v2_533 = v2_533:sub(1, v2_535) .. v3_536
		end
		return (v2_534 and "-" or "") .. v2_533
	end
	local v1_537 = Instance.new("Frame")
	v1_537.Name = "Textbox"
	v1_537.Size = UDim2.new(1, 0, 0, 32)
	v1_537.BackgroundColor3 = v0_8.Element
	v1_537.BorderSizePixel = 0
	v1_537.LayoutOrder = self._count
	v1_537.Parent = self.Holder
	v0_63(v1_537, 6)
	if v1_523 then
		local v2_538 = Instance.new("TextLabel")
		v2_538.Name = "Label"
		v2_538.Position = UDim2.new(0, 8, 0, 0)
		v2_538.Size = UDim2.new(0.4, -8, 1, 0)
		v2_538.BackgroundTransparency = 1
		v2_538.BorderSizePixel = 0
		self._lib:_track(v2_538, "Text", v1_520.Name)
		v2_538.TextColor3 = v0_8.Text
		v2_538.Font = Enum.Font.Gotham
		v2_538.TextSize = 14
		v2_538.TextXAlignment = Enum.TextXAlignment.Left
		v2_538.TextTruncate = Enum.TextTruncate.AtEnd
		v2_538.Parent = v1_537
	end
	local v1_539 = Instance.new("Frame")
	v1_539.Name = "BoxHolder"
	v1_539.AnchorPoint = Vector2.new(1, 0.5)
	v1_539.Position = UDim2.new(1, -6, 0.5, 0)
	v1_539.Size = v1_523 and UDim2.new(0.6, -10, 0, 22) or UDim2.new(1, -12, 0, 22)
	v1_539.BackgroundColor3 = v0_8.Card
	v1_539.BorderSizePixel = 0
	v1_539.Parent = v1_537
	v0_63(v1_539, 5)
	local v1_540 = Instance.new("UIStroke")
	v1_540.Color = v0_8.Accent
	v1_540.Thickness = 1
	v1_540.Transparency = 1
	v1_540.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	v1_540.Parent = v1_539
	local v1_541 = Instance.new("TextBox")
	v1_541.Name = "Input"
	v1_541.Size = UDim2.new(1, 0, 1, 0)
	v1_541.BackgroundTransparency = 1
	v1_541.BorderSizePixel = 0
	v1_541.Text = v1_530(v1_529)
	self._lib:_track(v1_541, "PlaceholderText", v1_520.Placeholder or "")
	v1_541.PlaceholderColor3 = v0_8.IconOff
	v1_541.TextColor3 = v0_8.Text
	v1_541.Font = Enum.Font.Gotham
	v1_541.TextSize = 13
	v1_541.TextXAlignment = Enum.TextXAlignment.Left
	v1_541.ClearTextOnFocus = v1_520.ClearTextOnFocus == true
	v1_541.ClipsDescendants = true
	v1_541.Parent = v1_539
	local v1_542 = Instance.new("UIPadding")
	v1_542.PaddingLeft = UDim.new(0, 6)
	v1_542.PaddingRight = UDim.new(0, 6)
	v1_542.Parent = v1_541
	local function v1_543()
		v0_12(v1_539, { BackgroundColor3 = (v1_525 and not v1_524) and v0_8.Sidebar or v0_8.Card }, 0.12)
		v0_12(v1_540, { Transparency = v1_524 and 0 or 1 }, 0.15)
	end
	v1_541:GetPropertyChangedSignal("Text"):Connect(function()
		if v1_526 then return end
		local v2_544 = v1_541.Text
		if v1_521 then v2_544 = v1_532(v2_544) end
		if v1_522 and #v2_544 > v1_522 then v2_544 = v2_544:sub(1, v1_522) end
		if v2_544 ~= v1_541.Text then
			v1_526 = true
			v1_541.Text = v2_544
			v1_526 = false
		end
	end)
	v1_541.Focused:Connect(function()
		v1_524 = true
		v1_543()
	end)
	v1_541.FocusLost:Connect(function(v2_545)
		v1_524 = false
		v1_543()
		if v1_521 then
			local v3_546 = tonumber(v1_541.Text)
			if v3_546 == nil then
				v1_541.Text = v1_530(v1_529)
				return
			end
			v3_546 = v1_527(v3_546)
			v1_529 = v3_546
			v1_541.Text = v1_530(v3_546)
		else
			v1_529 = v1_541.Text
		end
		if v1_520.Callback then v1_520.Callback(v1_529, v2_545) end
	end)
	v1_539.MouseEnter:Connect(function()
		v1_525 = true
		v1_543()
	end)
	v1_539.MouseLeave:Connect(function()
		v1_525 = false
		v1_543()
	end)
	local v1_547 = { Instance = v1_537 }
	function v1_547:Set(v2_548, v2_549)
		if v1_521 then
			local v3_550 = tonumber(v2_548)
			if v3_550 == nil then return end
			v1_529 = v1_527(v3_550)
		else
			v1_529 = tostring(v2_548 == nil and "" or v2_548)
			if v1_522 then v1_529 = v1_529:sub(1, v1_522) end
		end
		v1_541.Text = v1_530(v1_529)
		if not v2_549 and v1_520.Callback then v1_520.Callback(v1_529, false) end
	end
	function v1_547:Get()
		return v1_529
	end
	function v1_547:Focus()
		v1_541:CaptureFocus()
	end
	function v1_547:Destroy()
		if v1_541:IsFocused() then v1_541:ReleaseFocus() end
		v1_537:Destroy()
	end
	return v1_547
end
function v0_3:AddKeybind(v1_551)
	v1_551 = v1_551 or {}
	self._count += 1
	local v1_552 = Instance.new("Frame")
	v1_552.Name = "KeybindRow"
	v1_552.Size = UDim2.new(1, 0, 0, 32)
	v1_552.BackgroundColor3 = v0_8.Element
	v1_552.BorderSizePixel = 0
	v1_552.LayoutOrder = self._count
	v1_552.Parent = self.Holder
	v0_63(v1_552, 6)
	local v1_553 = Instance.new("TextLabel")
	v1_553.Name = "Label"
	v1_553.Position = UDim2.new(0, 8, 0, 0)
	v1_553.Size = UDim2.new(1, -60, 1, 0)
	v1_553.BackgroundTransparency = 1
	v1_553.BorderSizePixel = 0
	self._lib:_track(v1_553, "Text", v1_551.Name or "Keybind")
	v1_553.TextColor3 = v0_8.Text
	v1_553.Font = Enum.Font.Gotham
	v1_553.TextSize = 14
	v1_553.TextXAlignment = Enum.TextXAlignment.Left
	v1_553.TextTruncate = Enum.TextTruncate.AtEnd
	v1_553.Parent = v1_552
	local v1_554 = v0_451(self._lib, v1_552, v1_551, UDim2.new(1, -8, 0.5, 0), function()
		if v1_551.OnPress then v1_551.OnPress() end
	end)
	v0_471(v1_553, v1_554, 16)
	v1_554.Row = v1_552
	local v1_555 = v1_554.Destroy
	function v1_554:Destroy()
		v1_555(v1_554)
		v1_552:Destroy()
	end
	return v1_554
end
function v0_3:AddSlider(v1_556)
	v1_556 = v1_556 or {}
	self._count += 1
	local v1_557 = self._lib
	local function v1_558(v2_559)
		return #(tostring(v2_559):match("%.(%d+)") or "")
	end
	local v1_560 = tonumber(v1_556.Min) or 0
	local v1_561 = tonumber(v1_556.Max) or 100
	if v1_561 < v1_560 then v1_560, v1_561 = v1_561, v1_560 end
	local v1_562 = tonumber(v1_556.Increment) or 1
	if v1_562 <= 0 then v1_562 = 1 end
	local v1_563 = math.max(v1_558(v1_562), v1_558(v1_560))
	local v1_564 = v1_556.ValueName
	local function v1_565(v2_566)
		v2_566 = math.clamp(v2_566, v1_560, v1_561)
		v2_566 = v1_560 + math.floor((v2_566 - v1_560) / v1_562 + 0.5) * v1_562
		v2_566 = math.clamp(v2_566, v1_560, v1_561)
		local v2_567 = 10 ^ v1_563
		return math.floor(v2_566 * v2_567 + 0.5) / v2_567
	end
	local function v1_568(v2_569)
		return v1_561 > v1_560 and (v2_569 - v1_560) / (v1_561 - v1_560) or 0
	end
	local function v1_570(v2_571)
		local v2_572 = v1_563 > 0 and string.format("%." .. v1_563 .. "f", v2_571) or tostring(v2_571)
		if v1_564 and v1_564 ~= "" then v2_572 = v2_572 .. " " .. v0_82(tostring(v1_564)) end
		return v2_572
	end
	local v1_573 = v1_565(tonumber(v1_556.Default) or v1_560)
	local v1_574, v1_575 = false, false
	local v1_576 = nil
	local v1_577 = Instance.new("Frame")
	v1_577.Name = "Slider"
	v1_577.Size = UDim2.new(1, 0, 0, 46)
	v1_577.BackgroundColor3 = v0_8.Element
	v1_577.BorderSizePixel = 0
	v1_577.LayoutOrder = self._count
	v1_577.Parent = self.Holder
	v0_63(v1_577, 6)
	local v1_578 = Instance.new("TextLabel")
	v1_578.Name = "Name"
	v1_578.Position = UDim2.new(0, 8, 0, 6)
	v1_578.Size = UDim2.new(0.6, -8, 0, 16)
	v1_578.BackgroundTransparency = 1
	v1_578.BorderSizePixel = 0
	v1_557:_track(v1_578, "Text", v1_556.Name or "Slider")
	v1_578.TextColor3 = v0_8.Text
	v1_578.Font = Enum.Font.Gotham
	v1_578.TextSize = 14
	v1_578.TextXAlignment = Enum.TextXAlignment.Left
	v1_578.TextTruncate = Enum.TextTruncate.AtEnd
	v1_578.Parent = v1_577
	local v1_579 = Instance.new("TextLabel")
	v1_579.Name = "Value"
	v1_579.Position = UDim2.new(0.6, 0, 0, 6)
	v1_579.Size = UDim2.new(0.4, -8, 0, 16)
	v1_579.BackgroundTransparency = 1
	v1_579.BorderSizePixel = 0
	v1_579.Text = v1_570(v1_573)
	v1_579.TextColor3 = v0_8.SubText
	v1_579.Font = Enum.Font.GothamBold
	v1_579.TextSize = 13
	v1_579.TextXAlignment = Enum.TextXAlignment.Right
	v1_579.TextTruncate = Enum.TextTruncate.AtEnd
	v1_579.Parent = v1_577
	v1_557:_onLang(v1_579, function() v1_579.Text = v1_570(v1_573) end)
	local v1_580 = Instance.new("Frame")
	v1_580.Name = "Track"
	v1_580.Position = UDim2.new(0, 8, 0, 31)
	v1_580.Size = UDim2.new(1, -16, 0, 6)
	v1_580.BackgroundColor3 = v0_8.Off
	v1_580.BorderSizePixel = 0
	v1_580.Parent = v1_577
	local v1_581 = Instance.new("Frame")
	v1_581.Name = "Fill"
	v1_581.Size = UDim2.new(v1_568(v1_573), 0, 1, 0)
	v1_581.BackgroundColor3 = v0_8.Accent
	v1_581.BorderSizePixel = 0
	v1_581.Parent = v1_580
	local v1_582 = v0_8.Accent
	local v1_583 = v0_8.Accent:Lerp(v0_8.Text, 0.25)
	local v1_584 = Instance.new("TextButton")
	v1_584.Name = "Hit"
	v1_584.Size = UDim2.new(1, 0, 1, 0)
	v1_584.BackgroundTransparency = 1
	v1_584.BorderSizePixel = 0
	v1_584.Text = ""
	v1_584.AutoButtonColor = false
	v1_584.Parent = v1_577
	local function v1_585()
		local v2_586 = v1_574 or v1_575
		v0_12(v1_577, { BackgroundColor3 = v2_586 and v0_8.Hover or v0_8.Element }, 0.12)
		v0_12(v1_581, { BackgroundColor3 = v2_586 and v1_583 or v1_582 }, 0.12)
	end
	local function v1_587(v2_588)
		local v2_589 = v1_568(v1_573)
		v0_12(v1_581, { Size = UDim2.new(v2_589, 0, 1, 0) }, v2_588)
		v1_579.Text = v1_570(v1_573)
	end
	local function v1_590(v2_591, v2_592, v2_593)
		v2_591 = v1_565(v2_591)
		local v2_594 = v2_591 ~= v1_573
		v1_573 = v2_591
		v1_587(v2_593)
		if v2_594 then
			v1_579.TextColor3 = v0_8.Text
			v0_12(v1_579, { TextColor3 = v0_8.SubText }, 0.3)
			if not v2_592 and v1_556.Callback then v1_556.Callback(v1_573) end
		end
	end
	local function v1_595(v2_596)
		local v2_597 = v1_580.AbsoluteSize.X
		if v2_597 <= 0 then return end
		v1_590(v1_560 + ((v2_596 - v1_580.AbsolutePosition.X) / v2_597) * (v1_561 - v1_560), false, 0.08)
	end
	local function v1_598()
		if v1_576 then
			for v4_599, v4_600 in ipairs(v1_576) do v4_600:Disconnect() end
			v1_576 = nil
		end
		if v1_575 then
			v1_575 = false
			v1_585()
		end
	end
	local function v1_601(v2_602)
		v1_598()
		v1_575 = true
		v1_585()
		v1_595(v2_602.Position.X)
		v1_576 = {
			v0_4.InputChanged:Connect(function(v3_603)
				if v3_603.UserInputType == Enum.UserInputType.MouseMovement or v3_603 == v2_602 then
					v1_595(v3_603.Position.X)
				end
			end),
			v0_4.InputEnded:Connect(function(v3_604)
				if v3_604 == v2_602 or v3_604.UserInputType == Enum.UserInputType.MouseButton1 then
					v1_598()
				end
			end),
		}
	end
	v1_584.InputBegan:Connect(function(v2_605)
		if v0_19(v2_605) then v1_601(v2_605) end
	end)
	v1_584.MouseEnter:Connect(function()
		v1_574 = true
		v1_585()
	end)
	v1_584.MouseLeave:Connect(function()
		v1_574 = false
		v1_585()
	end)
	local v1_606 = { Instance = v1_577 }
	function v1_606:Set(v2_607, v2_608)
		v1_590(tonumber(v2_607) or v1_573, v2_608, 0.2)
	end
	function v1_606:Get()
		return v1_573
	end
	function v1_606:Destroy()
		v1_598()
		v1_557._cleanups[v1_606] = nil
		v1_577:Destroy()
	end
	v1_557._cleanups[v1_606] = v1_598
	return v1_606
end
function v0_3:AddDropdown(v1_609)
	v1_609 = v1_609 or {}
	self._count += 1
	local v1_610 = v1_609.Options or {}
	local v1_611 = v1_609.Multi == true
	local v1_612 = 130
	local v1_613, v1_614 = 26, 4
	local v1_615 = nil
	local v1_616 = {}
	local v1_617 = {}
	local v1_618 = false
	local v1_619 = 0
	local v1_620 = nil
	local v1_621 = Instance.new("Frame")
	v1_621.Name = "Dropdown"
	v1_621.Size = UDim2.new(1, 0, 0, 32)
	v1_621.AutomaticSize = Enum.AutomaticSize.Y
	v1_621.BackgroundTransparency = 1
	v1_621.BorderSizePixel = 0
	v1_621.LayoutOrder = self._count
	v1_621.Parent = self.Holder
	local v1_622 = Instance.new("UIListLayout")
	v1_622.Padding = UDim.new(0, 4)
	v1_622.SortOrder = Enum.SortOrder.LayoutOrder
	v1_622.Parent = v1_621
	local v1_623 = Instance.new("TextButton")
	v1_623.Name = "Header"
	v1_623.Size = UDim2.new(1, 0, 0, 32)
	v1_623.BackgroundColor3 = v0_8.Element
	v1_623.BorderSizePixel = 0
	v1_623.Text = ""
	v1_623.AutoButtonColor = false
	v1_623.LayoutOrder = 1
	v1_623.Parent = v1_621
	v0_63(v1_623, 6)
	v0_21(v1_623, v0_8.Element, v0_8.Hover)
	local v1_624 = Instance.new("TextLabel")
	v1_624.Name = "Name"
	v1_624.Position = UDim2.new(0, 8, 0, 0)
	v1_624.Size = UDim2.new(0.5, -8, 1, 0)
	v1_624.BackgroundTransparency = 1
	v1_624.BorderSizePixel = 0
	self._lib:_track(v1_624, "Text", v1_609.Name or "Dropdown")
	v1_624.TextColor3 = v0_8.Text
	v1_624.Font = Enum.Font.Gotham
	v1_624.TextSize = 14
	v1_624.TextXAlignment = Enum.TextXAlignment.Left
	v1_624.TextTruncate = Enum.TextTruncate.AtEnd
	v1_624.Parent = v1_623
	local v1_625 = Instance.new("TextLabel")
	v1_625.Name = "Value"
	v1_625.Position = UDim2.new(0.5, 0, 0, 0)
	v1_625.Size = UDim2.new(0.5, -28, 1, 0)
	v1_625.BackgroundTransparency = 1
	v1_625.BorderSizePixel = 0
	v1_625.Text = v0_82("None")
	v1_625.TextColor3 = v0_8.SubText
	v1_625.Font = Enum.Font.Gotham
	v1_625.TextSize = 13
	v1_625.TextXAlignment = Enum.TextXAlignment.Right
	v1_625.TextTruncate = Enum.TextTruncate.AtEnd
	v1_625.Parent = v1_623
	local v1_626 = Instance.new("ImageLabel")
	v1_626.Name = "Arrow"
	v1_626.AnchorPoint = Vector2.new(1, 0.5)
	v1_626.Position = UDim2.new(1, -8, 0.5, 0)
	v1_626.Size = UDim2.new(0, 16, 0, 16)
	v1_626.BackgroundTransparency = 1
	v1_626.BorderSizePixel = 0
	v1_626.ImageColor3 = v0_8.SubText
	v1_626.ScaleType = Enum.ScaleType.Fit
	v1_626.Parent = v1_623
	local v1_627 = Instance.new("TextLabel")
	v1_627.Name = "ArrowFallback"
	v1_627.Size = UDim2.new(1, 0, 1, 0)
	v1_627.BackgroundTransparency = 1
	v1_627.Text = "▼"
	v1_627.TextColor3 = v0_8.SubText
	v1_627.Font = Enum.Font.Gotham
	v1_627.TextSize = 9
	v1_627.Visible = false
	v1_627.Parent = v1_626
	local function v1_628(v2_629)
		local v2_630 = v0_44(v1_626, v2_629 and "chevron-up" or "chevron-down", self._icons)
		if not v2_630 then v1_626.Image = "" end
		v1_627.Visible = not v2_630
		v1_627.Text = v2_629 and "▲" or "▼"
		v1_626.ImageTransparency = 1
		v1_627.TextTransparency = 1
		v0_12(v1_626, { ImageTransparency = 0 }, 0.18)
		v0_12(v1_627, { TextTransparency = 0 }, 0.18)
	end
	v1_628(false)
	local v1_631 = Instance.new("ScrollingFrame")
	v1_631.Name = "List"
	v1_631.Size = UDim2.new(1, 0, 0, 0)
	v1_631.BackgroundColor3 = v0_8.Sidebar
	v1_631.BorderSizePixel = 0
	v1_631.ScrollBarThickness = 3
	v1_631.ScrollBarImageColor3 = v0_8.IconOff
	v1_631.ScrollingDirection = Enum.ScrollingDirection.Y
	v1_631.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v1_631.CanvasSize = UDim2.new(0, 0, 0, 0)
	v1_631.Visible = false
	v1_631.LayoutOrder = 2
	v1_631.Parent = v1_621
	v0_63(v1_631, 6)
	local v1_632 = Instance.new("UIPadding")
	v1_632.PaddingTop = UDim.new(0, 4)
	v1_632.PaddingBottom = UDim.new(0, 4)
	v1_632.Parent = v1_631
	local v1_633 = Instance.new("UIListLayout")
	v1_633.Padding = UDim.new(0, v1_614)
	v1_633.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v1_633.SortOrder = Enum.SortOrder.LayoutOrder
	v1_633.Parent = v1_631
	local function v1_634(v2_635)
		if v1_611 then return v1_616[v2_635] == true end
		return v1_615 == v2_635
	end
	local function v1_636()
		local v2_637 = {}
		for v3_638, v3_639 in ipairs(v1_610) do
			if v1_616[v3_639] then table.insert(v2_637, v3_639) end
		end
		return v2_637
	end
	local function v1_640()
		for v3_641, v3_642 in pairs(v1_617) do
			local v3_643 = v1_634(v3_641)
			v3_642.BackgroundColor3 = v3_643 and v0_8.Accent or v0_8.Element
			v3_642.TextColor3 = v3_643 and v0_8.IconOn or v0_8.SubText
		end
		if v1_611 then
			local v3_644 = {}
			for v4_645, v4_646 in ipairs(v1_636()) do table.insert(v3_644, v0_82(tostring(v4_646))) end
			v1_625.Text = #v3_644 > 0 and table.concat(v3_644, ", ") or v0_82("None")
		else
			v1_625.Text = v1_615 ~= nil and v0_82(tostring(v1_615)) or v0_82("None")
		end
	end
	self._lib:_onLang(v1_625, v1_640)
	local function v1_647(v2_648)
		if v1_618 == v2_648 then return end
		v1_618 = v2_648
		if v1_620 then v1_620:Cancel() end
		v1_628(v2_648)
		if v2_648 then
			v1_631.Visible = true
			v1_620 = v0_12(v1_631, { Size = UDim2.new(1, 0, 0, v1_619) }, 0.22, Enum.EasingStyle.Quint)
		else
			local v3_649 = v0_12(v1_631, { Size = UDim2.new(1, 0, 0, 0) }, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			v1_620 = v3_649
			v3_649.Completed:Connect(function(v4_650)
				if v4_650 == Enum.PlaybackState.Completed and not v1_618 then
					v1_631.Visible = false
				end
			end)
		end
	end
	local v1_651 = { Instance = v1_621 }
	local function v1_652()
		if v1_609.Callback then
			v1_609.Callback(v1_611 and v1_636() or v1_615)
		end
	end
	local function v1_653()
		for v3_654, v3_655 in pairs(v1_617) do v3_655:Destroy() end
		v1_617 = {}
		for v3_656, v3_657 in ipairs(v1_610) do
			local v3_658 = Instance.new("TextButton")
			v3_658.Name = "Option"
			v3_658.Size = UDim2.new(1, -8, 0, v1_613)
			v3_658.BackgroundColor3 = v0_8.Element
			v3_658.BorderSizePixel = 0
			self._lib:_track(v3_658, "Text", tostring(v3_657))
			v3_658.TextColor3 = v0_8.SubText
			v3_658.Font = Enum.Font.Gotham
			v3_658.TextSize = 13
			v3_658.TextTruncate = Enum.TextTruncate.AtEnd
			v3_658.AutoButtonColor = true
			v3_658.LayoutOrder = v3_656
			v3_658.Parent = v1_631
			v0_63(v3_658, 5)
			v3_658.MouseButton1Click:Connect(function()
				if v1_611 then
					v1_616[v3_657] = not v1_616[v3_657] or nil
					v1_640()
					v1_652()
				else
					v1_615 = v3_657
					v1_640()
					v1_647(false)
					v1_652()
				end
			end)
			v1_617[v3_657] = v3_658
		end
		local v2_659 = #v1_610
		local v2_660 = v2_659 > 0 and (v2_659 * v1_613 + (v2_659 - 1) * v1_614 + 8) or 0
		v1_619 = math.min(v2_660, v1_612)
		v1_631.Size = UDim2.new(1, 0, 0, v1_618 and v1_619 or 0)
		v1_640()
	end
	function v1_651:Set(v2_661, v2_662)
		if v1_611 then
			v1_616 = {}
			for v4_663, v4_664 in ipairs(typeof(v2_661) == "table" and v2_661 or { v2_661 }) do
				v1_616[v4_664] = true
			end
		else
			v1_615 = v2_661
		end
		v1_640()
		if not v2_662 then v1_652() end
	end
	function v1_651:Get()
		return v1_611 and v1_636() or v1_615
	end
	function v1_651:Refresh(v2_665, v2_666)
		v1_610 = v2_665 or {}
		if v2_666 then
			local v3_667 = {}
			for v4_668, v4_669 in ipairs(v1_610) do v3_667[v4_669] = true end
			if v1_611 then
				for v5_670 in pairs(v1_616) do
					if not v3_667[v5_670] then v1_616[v5_670] = nil end
				end
			elseif not v3_667[v1_615] then
				v1_615 = nil
			end
		else
			v1_616, v1_615 = {}, nil
		end
		v1_653()
	end
	function v1_651:Open() v1_647(true) end
	function v1_651:Close() v1_647(false) end
	v1_623.MouseButton1Click:Connect(function()
		v1_647(not v1_618)
	end)
	v1_653()
	if v1_609.Default ~= nil then
		v1_651:Set(v1_609.Default, true)
	end
	return v1_651
end
return v0_1
