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
		local v2_417, v2_418
		local function v2_419()
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
			v2_418 = Instance.new("UIStroke")
			v2_418.Color = v0_8.Accent
			v2_418.Thickness = 1
			v2_418.Transparency = 0.45
			v2_418.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			v2_418.Parent = v2_417
		end
		local function v2_420()
			local v3_421 = v2_417.AbsolutePosition + v2_417.AbsoluteSize / 2
			local v3_422, v3_423 = v1_386.Main.AbsolutePosition, v1_386.Main.AbsoluteSize
			return v3_421.X >= v3_422.X and v3_421.X <= v3_422.X + v3_423.X and v3_421.Y >= v3_422.Y and v3_421.Y <= v3_422.Y + v3_423.Y
		end
		local function v2_424(v3_425, v3_426, v3_427)
			v2_419()
			v1_386._floatZ += 1
			v2_417.ZIndex = v1_386._floatZ
			v2_417.Size = UDim2.new(0, v3_427, 0, 0)
			v2_417.Position = UDim2.fromOffset(v3_425, v3_426)
			v1_387.Parent = v2_417
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
		local v2_428 = nil
		local function v2_429()
			if v2_428 then
				for v5_430, v5_431 in ipairs(v2_428) do v5_431:Disconnect() end
				v2_428 = nil
			end
		end
		v2_414.InputBegan:Connect(function(v3_432)
			if not v0_19(v3_432) then return end
			v2_429()
			local v3_433 = v3_432.Position
			local v3_434, v3_435 = false, nil
			v2_428 = {
				v0_4.InputChanged:Connect(function(v4_436)
					if v4_436.UserInputType ~= Enum.UserInputType.MouseMovement and v4_436 ~= v3_432 then return end
					local v4_437 = v4_436.Position - v3_433
					if not v3_434 then
						if v4_437.Magnitude < 4 then return end
						v3_434 = true
						if v1_393 then
							v3_435 = v2_417.AbsolutePosition
							v1_386._floatZ += 1
							v2_417.ZIndex = v1_386._floatZ
						else
							v3_435 = v1_387.AbsolutePosition
							v2_424(v3_435.X, v3_435.Y, v1_387.AbsoluteSize.X)
						end
					end
					local v4_438 = v1_386.ScreenGui.AbsoluteSize
					local v4_439 = v2_417.AbsoluteSize.X
					local v4_440 = math.clamp(v3_435.X + v4_437.X, 60 - v4_439, math.max(v4_438.X - 60, 60 - v4_439))
					local v4_441 = math.clamp(v3_435.Y + v4_437.Y, 0, math.max(v4_438.Y - 30, 0))
					v2_417.Position = UDim2.fromOffset(v4_440, v4_441)
					v2_418.Transparency = v2_420() and 0 or 0.45
				end),
				v0_4.InputEnded:Connect(function(v4_442)
					if v4_442 == v3_432 or v4_442.UserInputType == Enum.UserInputType.MouseButton1 then
						v2_429()
						if v3_434 and v1_393 then
							v2_418.Transparency = 0.45
							if v1_386._visible ~= false and v2_420() then v1_394() end
						end
					end
				end),
			}
		end)
		v1_386._cleanups[v2_414] = v2_429
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
	local v1_443 = setmetatable({
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
	return v1_443
end
function v0_3:SetCollapsed(v1_444)
	self._setCollapsed(v1_444 == true)
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
local function v0_445(v1_446)
	if typeof(v1_446) == "EnumItem" and v1_446.EnumType == Enum.KeyCode then return v1_446 end
	if type(v1_446) == "string" then
		local v2_447, v2_448 = pcall(function() return Enum.KeyCode[v1_446] end)
		if v2_447 then return v2_448 end
	end
	return nil
end
local function v0_449(v1_450, v1_451, v1_452, v1_453, v1_454)
	v1_452 = v1_452 or {}
	local v1_455 = v1_452.CanBeChanged ~= false
	local v1_456 = {}
	local v1_457 = { _key = nil, _onPress = v1_454, _isListening = false, _destroyed = false }
	local v1_458 = Instance.new("TextButton")
	v1_458.Name = "Keybind"
	v1_458.AnchorPoint = Vector2.new(1, 0.5)
	v1_458.Position = v1_453
	v1_458.Size = UDim2.new(0, 0, 0, 20)
	v1_458.AutomaticSize = Enum.AutomaticSize.X
	v1_458.BackgroundColor3 = v0_8.Card
	v1_458.BorderSizePixel = 0
	v1_458.Text = v0_82("None")
	v1_458.TextColor3 = v0_8.SubText
	v1_458.Font = Enum.Font.Gotham
	v1_458.TextSize = 12
	v1_458.TextTruncate = Enum.TextTruncate.AtEnd
	v1_458.AutoButtonColor = false
	v1_458.Parent = v1_451
	v0_63(v1_458, 5)
	v1_457.Instance = v1_458
	local v1_459 = Instance.new("UIPadding")
	v1_459.PaddingLeft = UDim.new(0, 7)
	v1_459.PaddingRight = UDim.new(0, 7)
	v1_459.Parent = v1_458
	local v1_460 = Instance.new("UISizeConstraint")
	v1_460.MinSize = Vector2.new(30, 20)
	v1_460.MaxSize = Vector2.new(96, 20)
	v1_460.Parent = v1_458
	local function v1_461()
		if v1_457._isListening then
			v1_458.Text = "..."
		else
			v1_458.Text = v1_457._key and v1_457._key.Name or v0_82("None")
		end
	end
	v1_450:_onLang(v1_458, v1_461)
	local function v1_462()
		v1_458.BackgroundColor3 = v0_8.Danger
		v0_12(v1_458, { BackgroundColor3 = v0_8.Card }, 0.45)
	end
	function v1_457:Set(v2_463, v2_464)
		v2_463 = v0_445(v2_463)
		if v2_463 and v1_450:_keyTaken(v2_463, v1_457) then
			warn("[RobloxUI] key already in use:", v2_463.Name)
			v1_462()
			return false
		end
		v1_457._key = v2_463
		v1_461()
		if not v2_464 and v1_452.Callback then v1_452.Callback(v2_463) end
		return true
	end
	function v1_457:Get()
		return v1_457._key
	end
	function v1_457:_startListening()
		if v1_450._listening and v1_450._listening ~= v1_457 then
			v1_450._listening:_stopListening()
		end
		v1_450._listening = v1_457
		v1_457._isListening = true
		v0_12(v1_458, { BackgroundColor3 = v0_8.Accent }, 0.15)
		v1_461()
	end
	function v1_457:_stopListening()
		if v1_450._listening == v1_457 then v1_450._listening = nil end
		v1_457._isListening = false
		v0_12(v1_458, { BackgroundColor3 = v0_8.Card }, 0.15)
		v1_461()
	end
	function v1_457:_capture(v2_465)
		if v2_465 == Enum.KeyCode.Unknown then return end
		v1_457:_stopListening()
		if v2_465 == Enum.KeyCode.Escape then return end
		if v2_465 == Enum.KeyCode.Backspace or v2_465 == Enum.KeyCode.Delete then
			v1_457:Set(nil)
		else
			v1_457:Set(v2_465)
		end
	end
	function v1_457:Destroy()
		if v1_457._destroyed then return end
		v1_457._destroyed = true
		if v1_450._listening == v1_457 then v1_450._listening = nil end
		local v2_466 = table.find(v1_450._binds, v1_457)
		if v2_466 then table.remove(v1_450._binds, v2_466) end
		v1_450._cleanups[v1_457] = nil
		for v3_467, v3_468 in ipairs(v1_456) do v3_468:Disconnect() end
		v1_456 = {}
		v1_458:Destroy()
	end
	if v1_455 then
		v0_21(v1_458, v0_8.Card, v0_8.Sidebar, function() return v1_457._isListening end)
		table.insert(v1_456, v1_458.MouseButton1Click:Connect(function()
			if v1_457._isListening then v1_457:_stopListening() else v1_457:_startListening() end
		end))
		table.insert(v1_456, v1_458.MouseButton2Click:Connect(function()
			if v1_457._isListening then v1_457:_stopListening() end
			v1_457:Set(nil)
		end))
	end
	if v1_452.Key ~= nil then
		v1_457:Set(v1_452.Key, true)
	end
	table.insert(v1_450._binds, v1_457)
	v1_450._cleanups[v1_457] = function() v1_457:Destroy() end
	return v1_457
end
local function v0_469(v1_470, v1_471, v1_472)
	local v1_473 = v1_471.Instance
	local function v1_474()
		local v2_475 = math.clamp(v1_473.TextBounds.X + 14, 30, 96)
		v1_470.Size = UDim2.new(1, -(v1_472 + v2_475 + 6), 1, 0)
	end
	v1_474()
	v1_473:GetPropertyChangedSignal("TextBounds"):Connect(v1_474)
end
function v0_3:AddButton(v1_476)
	v1_476 = v1_476 or {}
	self._count += 1
	local v1_477 = Instance.new("TextButton")
	v1_477.Name = "Button"
	v1_477.Size = UDim2.new(1, 0, 0, 32)
	v1_477.BackgroundColor3 = v0_8.Element
	v1_477.BorderSizePixel = 0
	self._lib:_track(v1_477, "Text", v1_476.Name or "Button")
	v1_477.TextColor3 = v0_8.Text
	v1_477.Font = Enum.Font.Gotham
	v1_477.TextSize = 14
	v1_477.TextTruncate = Enum.TextTruncate.AtEnd
	v1_477.AutoButtonColor = false
	v1_477.LayoutOrder = self._count
	v1_477.Parent = self.Holder
	v0_63(v1_477, 6)
	local v1_478 = Instance.new("UIPadding")
	v1_478.PaddingLeft = UDim.new(0, 8)
	v1_478.PaddingRight = UDim.new(0, 8)
	v1_478.Parent = v1_477
	v0_21(v1_477, v0_8.Element, v0_8.Hover)
	v1_477.MouseButton1Click:Connect(function()
		v1_477.BackgroundColor3 = v0_8.Accent
		v0_12(v1_477, { BackgroundColor3 = v0_8.Hover }, 0.3)
		if v1_476.Callback then v1_476.Callback() end
	end)
	return v1_477
end
function v0_3:AddToggle(v1_479)
	v1_479 = v1_479 or {}
	self._count += 1
	local v1_480 = v1_479.Default == true
	local v1_481 = self
	local v1_482 = Instance.new("TextButton")
	v1_482.Name = "Toggle"
	v1_482.Size = UDim2.new(1, 0, 0, 32)
	v1_482.BackgroundColor3 = v0_8.Element
	v1_482.BorderSizePixel = 0
	v1_482.Text = ""
	v1_482.AutoButtonColor = false
	v1_482.LayoutOrder = self._count
	v1_482.Parent = self.Holder
	v0_63(v1_482, 6)
	v0_21(v1_482, v0_8.Element, v0_8.Hover)
	local v1_483 = Instance.new("TextLabel")
	v1_483.Name = "Label"
	v1_483.Position = UDim2.new(0, 8, 0, 0)
	v1_483.Size = UDim2.new(1, -60, 1, 0)
	v1_483.BackgroundTransparency = 1
	v1_483.BorderSizePixel = 0
	self._lib:_track(v1_483, "Text", v1_479.Name or "Toggle")
	v1_483.TextColor3 = v0_8.Text
	v1_483.Font = Enum.Font.Gotham
	v1_483.TextSize = 14
	v1_483.TextXAlignment = Enum.TextXAlignment.Left
	v1_483.TextTruncate = Enum.TextTruncate.AtEnd
	v1_483.Parent = v1_482
	local v1_484 = Instance.new("Frame")
	v1_484.Name = "Track"
	v1_484.AnchorPoint = Vector2.new(1, 0.5)
	v1_484.Position = UDim2.new(1, -8, 0.5, 0)
	v1_484.Size = UDim2.new(0, 34, 0, 18)
	v1_484.BackgroundColor3 = v0_8.Off
	v1_484.BorderSizePixel = 0
	v1_484.Parent = v1_482
	v0_63(v1_484, 9)
	local v1_485 = Instance.new("Frame")
	v1_485.Name = "Knob"
	v1_485.AnchorPoint = Vector2.new(0, 0.5)
	v1_485.Position = UDim2.new(0, 2, 0.5, 0)
	v1_485.Size = UDim2.new(0, 14, 0, 14)
	v1_485.BackgroundColor3 = v0_8.Text
	v1_485.BorderSizePixel = 0
	v1_485.Parent = v1_484
	v0_63(v1_485, 7)
	local function v1_486(v2_487)
		local v2_488 = TweenInfo.new(v2_487 and 0.15 or 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v0_5:Create(v1_484, v2_488, { BackgroundColor3 = v1_480 and v0_8.Accent or v0_8.Off }):Play()
		v0_5:Create(v1_485, v2_488, {
			Position = v1_480 and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
		}):Play()
	end
	v1_486(false)
	local v1_489 = { Instance = v1_482 }
	function v1_489:Set(v2_490, v2_491)
		v1_480 = v2_490 and true or false
		v1_486(true)
		if not v2_491 and v1_479.Callback then v1_479.Callback(v1_480) end
	end
	function v1_489:Get()
		return v1_480
	end
	v1_482.MouseButton1Click:Connect(function()
		v1_489:Set(not v1_480)
	end)
	function v1_489:AddKeybind(v2_492)
		if v1_489.Keybind then
			warn("[RobloxUI] this toggle already has a keybind")
			return v1_489.Keybind
		end
		local v2_493 = v0_449(v1_481._lib, v1_482, v2_492, UDim2.new(1, -48, 0.5, 0), function()
			v1_489:Set(not v1_480)
		end)
		v0_469(v1_483, v2_493, 60)
		local v2_494 = v2_493.Destroy
		function v2_493:Destroy()
			v2_494(v2_493)
			v1_489.Keybind = nil
			v1_483.Size = UDim2.new(1, -60, 1, 0)
		end
		v1_489.Keybind = v2_493
		return v2_493
	end
	function v1_489:Destroy()
		if v1_489._destroyed then return end
		v1_489._destroyed = true
		if v1_489.Keybind then v1_489.Keybind:Destroy() end
		v1_482:Destroy()
	end
	return v1_489
end
function v0_3:AddParagraph(v1_495)
	v1_495 = v1_495 or {}
	self._count += 1
	local v1_496 = v1_495.Title and tostring(v1_495.Title) or ""
	local v1_497 = v1_495.Content and tostring(v1_495.Content) or ""
	local v1_498 = Instance.new("Frame")
	v1_498.Name = "Paragraph"
	v1_498.Size = UDim2.new(1, 0, 0, 0)
	v1_498.AutomaticSize = Enum.AutomaticSize.Y
	v1_498.BackgroundColor3 = v0_8.Element
	v1_498.BorderSizePixel = 0
	v1_498.LayoutOrder = self._count
	v1_498.Parent = self.Holder
	v0_63(v1_498, 6)
	local v1_499 = Instance.new("UIPadding")
	v1_499.PaddingTop = UDim.new(0, 8)
	v1_499.PaddingBottom = UDim.new(0, 8)
	v1_499.PaddingLeft = UDim.new(0, 8)
	v1_499.PaddingRight = UDim.new(0, 8)
	v1_499.Parent = v1_498
	local v1_500 = Instance.new("UIListLayout")
	v1_500.Padding = UDim.new(0, 3)
	v1_500.SortOrder = Enum.SortOrder.LayoutOrder
	v1_500.Parent = v1_498
	local function v1_501(v2_502, v2_503, v2_504, v2_505, v2_506)
		local v2_507 = Instance.new("TextLabel")
		v2_507.Name = v2_502
		v2_507.Size = UDim2.new(1, 0, 0, 0)
		v2_507.AutomaticSize = Enum.AutomaticSize.Y
		v2_507.BackgroundTransparency = 1
		v2_507.BorderSizePixel = 0
		v2_507.TextColor3 = v2_505
		v2_507.Font = v2_503
		v2_507.TextSize = v2_504
		v2_507.TextWrapped = true
		v2_507.RichText = v1_495.RichText == true
		v2_507.TextXAlignment = Enum.TextXAlignment.Left
		v2_507.TextYAlignment = Enum.TextYAlignment.Top
		v2_507.LayoutOrder = v2_506
		v2_507.Parent = v1_498
		return v2_507
	end
	local v1_508 = v1_501("Title", Enum.Font.GothamBold, 14, v0_8.Text, 1)
	local v1_509 = v1_501("Content", Enum.Font.Gotham, 13, v0_8.SubText, 2)
	local v1_510 = self._lib:_track(v1_508, "Text", "")
	local v1_511 = self._lib:_track(v1_509, "Text", "")
	local function v1_512(v2_513)
		v1_510.key = v1_496
		v1_508.Text = v0_82(v1_496)
		v1_508.Visible = v1_496 ~= ""
		v1_511.key = v1_497
		v1_509.Text = v0_82(v1_497)
		v1_509.Visible = v1_497 ~= ""
		if v2_513 then
			v1_508.TextTransparency = 1
			v1_509.TextTransparency = 1
			v0_12(v1_508, { TextTransparency = 0 }, 0.2)
			v0_12(v1_509, { TextTransparency = 0 }, 0.2)
		end
	end
	v1_512(false)
	local v1_514 = { Instance = v1_498 }
	function v1_514:SetTitle(v2_515)
		v1_496 = v2_515 and tostring(v2_515) or ""
		v1_512(true)
	end
	function v1_514:SetContent(v2_516)
		v1_497 = v2_516 and tostring(v2_516) or ""
		v1_512(true)
	end
	function v1_514:Set(v2_517)
		v2_517 = v2_517 or {}
		if v2_517.Title ~= nil then v1_496 = tostring(v2_517.Title) end
		if v2_517.Content ~= nil then v1_497 = tostring(v2_517.Content) end
		v1_512(true)
	end
	function v1_514:Get()
		return v1_496, v1_497
	end
	function v1_514:Destroy()
		v1_498:Destroy()
	end
	return v1_514
end
function v0_3:AddTextbox(v1_518)
	v1_518 = v1_518 or {}
	self._count += 1
	local v1_519 = v1_518.Numeric == true
	local v1_520 = tonumber(v1_518.MaxLength)
	local v1_521 = v1_518.Name ~= nil and v1_518.Name ~= ""
	local v1_522, v1_523, v1_524 = false, false, false
	local function v1_525(v2_526)
		if v1_518.Min then v2_526 = math.max(v2_526, v1_518.Min) end
		if v1_518.Max then v2_526 = math.min(v2_526, v1_518.Max) end
		return v2_526
	end
	local v1_527
	if v1_519 then
		v1_527 = tonumber(v1_518.Default)
		if v1_527 then v1_527 = v1_525(v1_527) end
	else
		v1_527 = tostring(v1_518.Default or "")
	end
	local function v1_528(v2_529)
		return v2_529 == nil and "" or tostring(v2_529)
	end
	local function v1_530(v2_531)
		local v2_532 = v2_531:sub(1, 1) == "-"
		v2_531 = v2_531:gsub("[^%d%.]", "")
		local v2_533 = v2_531:find(".", 1, true)
		if v2_533 then
			local v3_534 = v2_531:sub(v2_533 + 1):gsub("%.", "")
			v2_531 = v2_531:sub(1, v2_533) .. v3_534
		end
		return (v2_532 and "-" or "") .. v2_531
	end
	local v1_535 = Instance.new("Frame")
	v1_535.Name = "Textbox"
	v1_535.Size = UDim2.new(1, 0, 0, 32)
	v1_535.BackgroundColor3 = v0_8.Element
	v1_535.BorderSizePixel = 0
	v1_535.LayoutOrder = self._count
	v1_535.Parent = self.Holder
	v0_63(v1_535, 6)
	if v1_521 then
		local v2_536 = Instance.new("TextLabel")
		v2_536.Name = "Label"
		v2_536.Position = UDim2.new(0, 8, 0, 0)
		v2_536.Size = UDim2.new(0.4, -8, 1, 0)
		v2_536.BackgroundTransparency = 1
		v2_536.BorderSizePixel = 0
		self._lib:_track(v2_536, "Text", v1_518.Name)
		v2_536.TextColor3 = v0_8.Text
		v2_536.Font = Enum.Font.Gotham
		v2_536.TextSize = 14
		v2_536.TextXAlignment = Enum.TextXAlignment.Left
		v2_536.TextTruncate = Enum.TextTruncate.AtEnd
		v2_536.Parent = v1_535
	end
	local v1_537 = Instance.new("Frame")
	v1_537.Name = "BoxHolder"
	v1_537.AnchorPoint = Vector2.new(1, 0.5)
	v1_537.Position = UDim2.new(1, -6, 0.5, 0)
	v1_537.Size = v1_521 and UDim2.new(0.6, -10, 0, 22) or UDim2.new(1, -12, 0, 22)
	v1_537.BackgroundColor3 = v0_8.Card
	v1_537.BorderSizePixel = 0
	v1_537.Parent = v1_535
	v0_63(v1_537, 5)
	local v1_538 = Instance.new("UIStroke")
	v1_538.Color = v0_8.Accent
	v1_538.Thickness = 1
	v1_538.Transparency = 1
	v1_538.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	v1_538.Parent = v1_537
	local v1_539 = Instance.new("TextBox")
	v1_539.Name = "Input"
	v1_539.Size = UDim2.new(1, 0, 1, 0)
	v1_539.BackgroundTransparency = 1
	v1_539.BorderSizePixel = 0
	v1_539.Text = v1_528(v1_527)
	self._lib:_track(v1_539, "PlaceholderText", v1_518.Placeholder or "")
	v1_539.PlaceholderColor3 = v0_8.IconOff
	v1_539.TextColor3 = v0_8.Text
	v1_539.Font = Enum.Font.Gotham
	v1_539.TextSize = 13
	v1_539.TextXAlignment = Enum.TextXAlignment.Left
	v1_539.ClearTextOnFocus = v1_518.ClearTextOnFocus == true
	v1_539.ClipsDescendants = true
	v1_539.Parent = v1_537
	local v1_540 = Instance.new("UIPadding")
	v1_540.PaddingLeft = UDim.new(0, 6)
	v1_540.PaddingRight = UDim.new(0, 6)
	v1_540.Parent = v1_539
	local function v1_541()
		v0_12(v1_537, { BackgroundColor3 = (v1_523 and not v1_522) and v0_8.Sidebar or v0_8.Card }, 0.12)
		v0_12(v1_538, { Transparency = v1_522 and 0 or 1 }, 0.15)
	end
	v1_539:GetPropertyChangedSignal("Text"):Connect(function()
		if v1_524 then return end
		local v2_542 = v1_539.Text
		if v1_519 then v2_542 = v1_530(v2_542) end
		if v1_520 and #v2_542 > v1_520 then v2_542 = v2_542:sub(1, v1_520) end
		if v2_542 ~= v1_539.Text then
			v1_524 = true
			v1_539.Text = v2_542
			v1_524 = false
		end
	end)
	v1_539.Focused:Connect(function()
		v1_522 = true
		v1_541()
	end)
	v1_539.FocusLost:Connect(function(v2_543)
		v1_522 = false
		v1_541()
		if v1_519 then
			local v3_544 = tonumber(v1_539.Text)
			if v3_544 == nil then
				v1_539.Text = v1_528(v1_527)
				return
			end
			v3_544 = v1_525(v3_544)
			v1_527 = v3_544
			v1_539.Text = v1_528(v3_544)
		else
			v1_527 = v1_539.Text
		end
		if v1_518.Callback then v1_518.Callback(v1_527, v2_543) end
	end)
	v1_537.MouseEnter:Connect(function()
		v1_523 = true
		v1_541()
	end)
	v1_537.MouseLeave:Connect(function()
		v1_523 = false
		v1_541()
	end)
	local v1_545 = { Instance = v1_535 }
	function v1_545:Set(v2_546, v2_547)
		if v1_519 then
			local v3_548 = tonumber(v2_546)
			if v3_548 == nil then return end
			v1_527 = v1_525(v3_548)
		else
			v1_527 = tostring(v2_546 == nil and "" or v2_546)
			if v1_520 then v1_527 = v1_527:sub(1, v1_520) end
		end
		v1_539.Text = v1_528(v1_527)
		if not v2_547 and v1_518.Callback then v1_518.Callback(v1_527, false) end
	end
	function v1_545:Get()
		return v1_527
	end
	function v1_545:Focus()
		v1_539:CaptureFocus()
	end
	function v1_545:Destroy()
		if v1_539:IsFocused() then v1_539:ReleaseFocus() end
		v1_535:Destroy()
	end
	return v1_545
end
function v0_3:AddKeybind(v1_549)
	v1_549 = v1_549 or {}
	self._count += 1
	local v1_550 = Instance.new("Frame")
	v1_550.Name = "KeybindRow"
	v1_550.Size = UDim2.new(1, 0, 0, 32)
	v1_550.BackgroundColor3 = v0_8.Element
	v1_550.BorderSizePixel = 0
	v1_550.LayoutOrder = self._count
	v1_550.Parent = self.Holder
	v0_63(v1_550, 6)
	local v1_551 = Instance.new("TextLabel")
	v1_551.Name = "Label"
	v1_551.Position = UDim2.new(0, 8, 0, 0)
	v1_551.Size = UDim2.new(1, -60, 1, 0)
	v1_551.BackgroundTransparency = 1
	v1_551.BorderSizePixel = 0
	self._lib:_track(v1_551, "Text", v1_549.Name or "Keybind")
	v1_551.TextColor3 = v0_8.Text
	v1_551.Font = Enum.Font.Gotham
	v1_551.TextSize = 14
	v1_551.TextXAlignment = Enum.TextXAlignment.Left
	v1_551.TextTruncate = Enum.TextTruncate.AtEnd
	v1_551.Parent = v1_550
	local v1_552 = v0_449(self._lib, v1_550, v1_549, UDim2.new(1, -8, 0.5, 0), function()
		if v1_549.OnPress then v1_549.OnPress() end
	end)
	v0_469(v1_551, v1_552, 16)
	v1_552.Row = v1_550
	local v1_553 = v1_552.Destroy
	function v1_552:Destroy()
		v1_553(v1_552)
		v1_550:Destroy()
	end
	return v1_552
end
function v0_3:AddSlider(v1_554)
	v1_554 = v1_554 or {}
	self._count += 1
	local v1_555 = self._lib
	local function v1_556(v2_557)
		return #(tostring(v2_557):match("%.(%d+)") or "")
	end
	local v1_558 = tonumber(v1_554.Min) or 0
	local v1_559 = tonumber(v1_554.Max) or 100
	if v1_559 < v1_558 then v1_558, v1_559 = v1_559, v1_558 end
	local v1_560 = tonumber(v1_554.Increment) or 1
	if v1_560 <= 0 then v1_560 = 1 end
	local v1_561 = math.max(v1_556(v1_560), v1_556(v1_558))
	local v1_562 = v1_554.ValueName
	local function v1_563(v2_564)
		v2_564 = math.clamp(v2_564, v1_558, v1_559)
		v2_564 = v1_558 + math.floor((v2_564 - v1_558) / v1_560 + 0.5) * v1_560
		v2_564 = math.clamp(v2_564, v1_558, v1_559)
		local v2_565 = 10 ^ v1_561
		return math.floor(v2_564 * v2_565 + 0.5) / v2_565
	end
	local function v1_566(v2_567)
		return v1_559 > v1_558 and (v2_567 - v1_558) / (v1_559 - v1_558) or 0
	end
	local function v1_568(v2_569)
		local v2_570 = v1_561 > 0 and string.format("%." .. v1_561 .. "f", v2_569) or tostring(v2_569)
		if v1_562 and v1_562 ~= "" then v2_570 = v2_570 .. " " .. v0_82(tostring(v1_562)) end
		return v2_570
	end
	local v1_571 = v1_563(tonumber(v1_554.Default) or v1_558)
	local v1_572, v1_573 = false, false
	local v1_574 = nil
	local v1_575 = Instance.new("Frame")
	v1_575.Name = "Slider"
	v1_575.Size = UDim2.new(1, 0, 0, 46)
	v1_575.BackgroundColor3 = v0_8.Element
	v1_575.BorderSizePixel = 0
	v1_575.LayoutOrder = self._count
	v1_575.Parent = self.Holder
	v0_63(v1_575, 6)
	local v1_576 = Instance.new("TextLabel")
	v1_576.Name = "Name"
	v1_576.Position = UDim2.new(0, 8, 0, 6)
	v1_576.Size = UDim2.new(0.6, -8, 0, 16)
	v1_576.BackgroundTransparency = 1
	v1_576.BorderSizePixel = 0
	v1_555:_track(v1_576, "Text", v1_554.Name or "Slider")
	v1_576.TextColor3 = v0_8.Text
	v1_576.Font = Enum.Font.Gotham
	v1_576.TextSize = 14
	v1_576.TextXAlignment = Enum.TextXAlignment.Left
	v1_576.TextTruncate = Enum.TextTruncate.AtEnd
	v1_576.Parent = v1_575
	local v1_577 = Instance.new("TextLabel")
	v1_577.Name = "Value"
	v1_577.Position = UDim2.new(0.6, 0, 0, 6)
	v1_577.Size = UDim2.new(0.4, -8, 0, 16)
	v1_577.BackgroundTransparency = 1
	v1_577.BorderSizePixel = 0
	v1_577.Text = v1_568(v1_571)
	v1_577.TextColor3 = v0_8.SubText
	v1_577.Font = Enum.Font.GothamBold
	v1_577.TextSize = 13
	v1_577.TextXAlignment = Enum.TextXAlignment.Right
	v1_577.TextTruncate = Enum.TextTruncate.AtEnd
	v1_577.Parent = v1_575
	v1_555:_onLang(v1_577, function() v1_577.Text = v1_568(v1_571) end)
	local v1_578 = Instance.new("Frame")
	v1_578.Name = "Track"
	v1_578.Position = UDim2.new(0, 8, 0, 31)
	v1_578.Size = UDim2.new(1, -16, 0, 6)
	v1_578.BackgroundColor3 = v0_8.Off
	v1_578.BorderSizePixel = 0
	v1_578.Parent = v1_575
	local v1_579 = Instance.new("Frame")
	v1_579.Name = "Fill"
	v1_579.Size = UDim2.new(v1_566(v1_571), 0, 1, 0)
	v1_579.BackgroundColor3 = v0_8.Accent
	v1_579.BorderSizePixel = 0
	v1_579.Parent = v1_578
	local v1_580 = v0_8.Accent
	local v1_581 = v0_8.Accent:Lerp(v0_8.Text, 0.25)
	local v1_582 = Instance.new("TextButton")
	v1_582.Name = "Hit"
	v1_582.Size = UDim2.new(1, 0, 1, 0)
	v1_582.BackgroundTransparency = 1
	v1_582.BorderSizePixel = 0
	v1_582.Text = ""
	v1_582.AutoButtonColor = false
	v1_582.Parent = v1_575
	local function v1_583()
		local v2_584 = v1_572 or v1_573
		v0_12(v1_575, { BackgroundColor3 = v2_584 and v0_8.Hover or v0_8.Element }, 0.12)
		v0_12(v1_579, { BackgroundColor3 = v2_584 and v1_581 or v1_580 }, 0.12)
	end
	local function v1_585(v2_586)
		local v2_587 = v1_566(v1_571)
		v0_12(v1_579, { Size = UDim2.new(v2_587, 0, 1, 0) }, v2_586)
		v1_577.Text = v1_568(v1_571)
	end
	local function v1_588(v2_589, v2_590, v2_591)
		v2_589 = v1_563(v2_589)
		local v2_592 = v2_589 ~= v1_571
		v1_571 = v2_589
		v1_585(v2_591)
		if v2_592 then
			v1_577.TextColor3 = v0_8.Text
			v0_12(v1_577, { TextColor3 = v0_8.SubText }, 0.3)
			if not v2_590 and v1_554.Callback then v1_554.Callback(v1_571) end
		end
	end
	local function v1_593(v2_594)
		local v2_595 = v1_578.AbsoluteSize.X
		if v2_595 <= 0 then return end
		v1_588(v1_558 + ((v2_594 - v1_578.AbsolutePosition.X) / v2_595) * (v1_559 - v1_558), false, 0.08)
	end
	local function v1_596()
		if v1_574 then
			for v4_597, v4_598 in ipairs(v1_574) do v4_598:Disconnect() end
			v1_574 = nil
		end
		if v1_573 then
			v1_573 = false
			v1_583()
		end
	end
	local function v1_599(v2_600)
		v1_596()
		v1_573 = true
		v1_583()
		v1_593(v2_600.Position.X)
		v1_574 = {
			v0_4.InputChanged:Connect(function(v3_601)
				if v3_601.UserInputType == Enum.UserInputType.MouseMovement or v3_601 == v2_600 then
					v1_593(v3_601.Position.X)
				end
			end),
			v0_4.InputEnded:Connect(function(v3_602)
				if v3_602 == v2_600 or v3_602.UserInputType == Enum.UserInputType.MouseButton1 then
					v1_596()
				end
			end),
		}
	end
	v1_582.InputBegan:Connect(function(v2_603)
		if v0_19(v2_603) then v1_599(v2_603) end
	end)
	v1_582.MouseEnter:Connect(function()
		v1_572 = true
		v1_583()
	end)
	v1_582.MouseLeave:Connect(function()
		v1_572 = false
		v1_583()
	end)
	local v1_604 = { Instance = v1_575 }
	function v1_604:Set(v2_605, v2_606)
		v1_588(tonumber(v2_605) or v1_571, v2_606, 0.2)
	end
	function v1_604:Get()
		return v1_571
	end
	function v1_604:Destroy()
		v1_596()
		v1_555._cleanups[v1_604] = nil
		v1_575:Destroy()
	end
	v1_555._cleanups[v1_604] = v1_596
	return v1_604
end
function v0_3:AddDropdown(v1_607)
	v1_607 = v1_607 or {}
	self._count += 1
	local v1_608 = v1_607.Options or {}
	local v1_609 = v1_607.Multi == true
	local v1_610 = 130
	local v1_611, v1_612 = 26, 4
	local v1_613 = nil
	local v1_614 = {}
	local v1_615 = {}
	local v1_616 = false
	local v1_617 = 0
	local v1_618 = nil
	local v1_619 = Instance.new("Frame")
	v1_619.Name = "Dropdown"
	v1_619.Size = UDim2.new(1, 0, 0, 32)
	v1_619.AutomaticSize = Enum.AutomaticSize.Y
	v1_619.BackgroundTransparency = 1
	v1_619.BorderSizePixel = 0
	v1_619.LayoutOrder = self._count
	v1_619.Parent = self.Holder
	local v1_620 = Instance.new("UIListLayout")
	v1_620.Padding = UDim.new(0, 4)
	v1_620.SortOrder = Enum.SortOrder.LayoutOrder
	v1_620.Parent = v1_619
	local v1_621 = Instance.new("TextButton")
	v1_621.Name = "Header"
	v1_621.Size = UDim2.new(1, 0, 0, 32)
	v1_621.BackgroundColor3 = v0_8.Element
	v1_621.BorderSizePixel = 0
	v1_621.Text = ""
	v1_621.AutoButtonColor = false
	v1_621.LayoutOrder = 1
	v1_621.Parent = v1_619
	v0_63(v1_621, 6)
	v0_21(v1_621, v0_8.Element, v0_8.Hover)
	local v1_622 = Instance.new("TextLabel")
	v1_622.Name = "Name"
	v1_622.Position = UDim2.new(0, 8, 0, 0)
	v1_622.Size = UDim2.new(0.5, -8, 1, 0)
	v1_622.BackgroundTransparency = 1
	v1_622.BorderSizePixel = 0
	self._lib:_track(v1_622, "Text", v1_607.Name or "Dropdown")
	v1_622.TextColor3 = v0_8.Text
	v1_622.Font = Enum.Font.Gotham
	v1_622.TextSize = 14
	v1_622.TextXAlignment = Enum.TextXAlignment.Left
	v1_622.TextTruncate = Enum.TextTruncate.AtEnd
	v1_622.Parent = v1_621
	local v1_623 = Instance.new("TextLabel")
	v1_623.Name = "Value"
	v1_623.Position = UDim2.new(0.5, 0, 0, 0)
	v1_623.Size = UDim2.new(0.5, -28, 1, 0)
	v1_623.BackgroundTransparency = 1
	v1_623.BorderSizePixel = 0
	v1_623.Text = v0_82("None")
	v1_623.TextColor3 = v0_8.SubText
	v1_623.Font = Enum.Font.Gotham
	v1_623.TextSize = 13
	v1_623.TextXAlignment = Enum.TextXAlignment.Right
	v1_623.TextTruncate = Enum.TextTruncate.AtEnd
	v1_623.Parent = v1_621
	local v1_624 = Instance.new("ImageLabel")
	v1_624.Name = "Arrow"
	v1_624.AnchorPoint = Vector2.new(1, 0.5)
	v1_624.Position = UDim2.new(1, -8, 0.5, 0)
	v1_624.Size = UDim2.new(0, 16, 0, 16)
	v1_624.BackgroundTransparency = 1
	v1_624.BorderSizePixel = 0
	v1_624.ImageColor3 = v0_8.SubText
	v1_624.ScaleType = Enum.ScaleType.Fit
	v1_624.Parent = v1_621
	local v1_625 = Instance.new("TextLabel")
	v1_625.Name = "ArrowFallback"
	v1_625.Size = UDim2.new(1, 0, 1, 0)
	v1_625.BackgroundTransparency = 1
	v1_625.Text = "▼"
	v1_625.TextColor3 = v0_8.SubText
	v1_625.Font = Enum.Font.Gotham
	v1_625.TextSize = 9
	v1_625.Visible = false
	v1_625.Parent = v1_624
	local function v1_626(v2_627)
		local v2_628 = v0_44(v1_624, v2_627 and "chevron-up" or "chevron-down", self._icons)
		if not v2_628 then v1_624.Image = "" end
		v1_625.Visible = not v2_628
		v1_625.Text = v2_627 and "▲" or "▼"
		v1_624.ImageTransparency = 1
		v1_625.TextTransparency = 1
		v0_12(v1_624, { ImageTransparency = 0 }, 0.18)
		v0_12(v1_625, { TextTransparency = 0 }, 0.18)
	end
	v1_626(false)
	local v1_629 = Instance.new("ScrollingFrame")
	v1_629.Name = "List"
	v1_629.Size = UDim2.new(1, 0, 0, 0)
	v1_629.BackgroundColor3 = v0_8.Sidebar
	v1_629.BorderSizePixel = 0
	v1_629.ScrollBarThickness = 3
	v1_629.ScrollBarImageColor3 = v0_8.IconOff
	v1_629.ScrollingDirection = Enum.ScrollingDirection.Y
	v1_629.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v1_629.CanvasSize = UDim2.new(0, 0, 0, 0)
	v1_629.Visible = false
	v1_629.LayoutOrder = 2
	v1_629.Parent = v1_619
	v0_63(v1_629, 6)
	local v1_630 = Instance.new("UIPadding")
	v1_630.PaddingTop = UDim.new(0, 4)
	v1_630.PaddingBottom = UDim.new(0, 4)
	v1_630.Parent = v1_629
	local v1_631 = Instance.new("UIListLayout")
	v1_631.Padding = UDim.new(0, v1_612)
	v1_631.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v1_631.SortOrder = Enum.SortOrder.LayoutOrder
	v1_631.Parent = v1_629
	local function v1_632(v2_633)
		if v1_609 then return v1_614[v2_633] == true end
		return v1_613 == v2_633
	end
	local function v1_634()
		local v2_635 = {}
		for v3_636, v3_637 in ipairs(v1_608) do
			if v1_614[v3_637] then table.insert(v2_635, v3_637) end
		end
		return v2_635
	end
	local function v1_638()
		for v3_639, v3_640 in pairs(v1_615) do
			local v3_641 = v1_632(v3_639)
			v3_640.BackgroundColor3 = v3_641 and v0_8.Accent or v0_8.Element
			v3_640.TextColor3 = v3_641 and v0_8.IconOn or v0_8.SubText
		end
		if v1_609 then
			local v3_642 = {}
			for v4_643, v4_644 in ipairs(v1_634()) do table.insert(v3_642, v0_82(tostring(v4_644))) end
			v1_623.Text = #v3_642 > 0 and table.concat(v3_642, ", ") or v0_82("None")
		else
			v1_623.Text = v1_613 ~= nil and v0_82(tostring(v1_613)) or v0_82("None")
		end
	end
	self._lib:_onLang(v1_623, v1_638)
	local function v1_645(v2_646)
		if v1_616 == v2_646 then return end
		v1_616 = v2_646
		if v1_618 then v1_618:Cancel() end
		v1_626(v2_646)
		if v2_646 then
			v1_629.Visible = true
			v1_618 = v0_12(v1_629, { Size = UDim2.new(1, 0, 0, v1_617) }, 0.22, Enum.EasingStyle.Quint)
		else
			local v3_647 = v0_12(v1_629, { Size = UDim2.new(1, 0, 0, 0) }, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			v1_618 = v3_647
			v3_647.Completed:Connect(function(v4_648)
				if v4_648 == Enum.PlaybackState.Completed and not v1_616 then
					v1_629.Visible = false
				end
			end)
		end
	end
	local v1_649 = { Instance = v1_619 }
	local function v1_650()
		if v1_607.Callback then
			v1_607.Callback(v1_609 and v1_634() or v1_613)
		end
	end
	local function v1_651()
		for v3_652, v3_653 in pairs(v1_615) do v3_653:Destroy() end
		v1_615 = {}
		for v3_654, v3_655 in ipairs(v1_608) do
			local v3_656 = Instance.new("TextButton")
			v3_656.Name = "Option"
			v3_656.Size = UDim2.new(1, -8, 0, v1_611)
			v3_656.BackgroundColor3 = v0_8.Element
			v3_656.BorderSizePixel = 0
			self._lib:_track(v3_656, "Text", tostring(v3_655))
			v3_656.TextColor3 = v0_8.SubText
			v3_656.Font = Enum.Font.Gotham
			v3_656.TextSize = 13
			v3_656.TextTruncate = Enum.TextTruncate.AtEnd
			v3_656.AutoButtonColor = true
			v3_656.LayoutOrder = v3_654
			v3_656.Parent = v1_629
			v0_63(v3_656, 5)
			v3_656.MouseButton1Click:Connect(function()
				if v1_609 then
					v1_614[v3_655] = not v1_614[v3_655] or nil
					v1_638()
					v1_650()
				else
					v1_613 = v3_655
					v1_638()
					v1_645(false)
					v1_650()
				end
			end)
			v1_615[v3_655] = v3_656
		end
		local v2_657 = #v1_608
		local v2_658 = v2_657 > 0 and (v2_657 * v1_611 + (v2_657 - 1) * v1_612 + 8) or 0
		v1_617 = math.min(v2_658, v1_610)
		v1_629.Size = UDim2.new(1, 0, 0, v1_616 and v1_617 or 0)
		v1_638()
	end
	function v1_649:Set(v2_659, v2_660)
		if v1_609 then
			v1_614 = {}
			for v4_661, v4_662 in ipairs(typeof(v2_659) == "table" and v2_659 or { v2_659 }) do
				v1_614[v4_662] = true
			end
		else
			v1_613 = v2_659
		end
		v1_638()
		if not v2_660 then v1_650() end
	end
	function v1_649:Get()
		return v1_609 and v1_634() or v1_613
	end
	function v1_649:Refresh(v2_663, v2_664)
		v1_608 = v2_663 or {}
		if v2_664 then
			local v3_665 = {}
			for v4_666, v4_667 in ipairs(v1_608) do v3_665[v4_667] = true end
			if v1_609 then
				for v5_668 in pairs(v1_614) do
					if not v3_665[v5_668] then v1_614[v5_668] = nil end
				end
			elseif not v3_665[v1_613] then
				v1_613 = nil
			end
		else
			v1_614, v1_613 = {}, nil
		end
		v1_651()
	end
	function v1_649:Open() v1_645(true) end
	function v1_649:Close() v1_645(false) end
	v1_621.MouseButton1Click:Connect(function()
		v1_645(not v1_616)
	end)
	v1_651()
	if v1_607.Default ~= nil then
		v1_649:Set(v1_607.Default, true)
	end
	return v1_649
end
return v0_1
