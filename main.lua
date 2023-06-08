local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

local Player = game:GetService("Players").LocalPlayer

repeat task.wait() until Player.Character ~= nil and Player.Character:FindFirstChild("Head")

local Asset = Instance.new("Folder", workspace)
Asset.Name = "Asset"

local Using = false
local HL
local WHS

local function SetAction(boolen)
	if boolen then
		if not Asset:FindFirstChild("OnErase") then
			local SFX = Instance.new("Sound", workspace)
			SFX.Volume = 1
			SFX.SoundId = "rbxassetid://3431631978"
			SFX:Play()
			game.Debris:AddItem(SFX, 2)
			local SavePos = Player.Character.HumanoidRootPart.CFrame
			local Pos = Player.Character.HumanoidRootPart.Position
			Player.Character:MoveTo(Pos)
			local Seat = Instance.new('Seat', Asset)
			Seat.Anchored = false
			Seat.CanCollide = false
			Seat.Name = 'OnErase'
			Seat.Transparency = 1
			Seat.Position = Vector3.new(Pos + Vector3.new(0, 1555, 0))
			local Weld = Instance.new("Weld", Seat)
			Weld.Part0 = Seat
			Weld.Part1 = Player.Character.HumanoidRootPart
    			wait(0)
			Seat.CFrame = SavePos
			Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	else
		if Asset:FindFirstChild("OnErase") then
			local SFX = Instance.new("Sound", workspace)
			SFX.Volume = 1
			SFX.SoundId = "rbxassetid://3373991228"
			SFX:Play()
			game.Debris:AddItem(SFX, 2)
			Asset.OnErase:Destroy()
		end
	end
end

UIS.InputBegan:Connect(function(In, Ha)
	if Ha then return end
	if In.KeyCode == Enum.KeyCode.R then
		local CE = Instance.new("ColorCorrectionEffect", game.Lighting)
		CE.Contrast = 3
		CE.TintColor = Color3.new(1, 0.576471, 0.576471)
		TS:Create(CE, TweenInfo.new(.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{
				Contrast = 0,
				TintColor = Color3.new(1, 1, 1)
			}
		):Play()
		local Blur = Instance.new("BlurEffect", game.Lighting)
		Blur.Size = 65
		TS:Create(Blur, TweenInfo.new(.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{
				Size = 0
			}
		):Play()
		task.spawn(function()
			task.wait(.45)
			Blur:Destroy()
		end)
		local Effect = game:GetObjects("rbxassetid://12883456856")[1]
		Effect.Parent = workspace.Camera

		WHS = Instance.new("Highlight", workspace)
		WHS.Name = "WHS"
		WHS.OutlineTransparency = 1
		WHS.FillTransparency = 1
		WHS.Adornee = workspace
		WHS.OutlineColor = Color3.new(0.756863, 0.137255, 0.137255)
		TS:Create(WHS, TweenInfo.new(.67, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{
				FillTransparency = .55
			}
		):Play()
		if not game.Lighting:FindFirstChild("EffectEffect") then
			Using = true
			SetAction(true)
			HL = Instance.new("Highlight", Player.Character)
			HL.OutlineTransparency = 0
			HL.FillTransparency = 1
			HL.Adornee = Player.Character
			HL.OutlineColor = Color3.new(1, 0, 0)
			local Sky = game:GetObjects("rbxassetid://10374721339")[1]
			Sky.Name = "EffectEffect"
			Sky.Parent = game.Lighting
			Effect:SetPrimaryPartCFrame(Player.Character.HumanoidRootPart.CFrame * CFrame.new(23, 0, -6.8))
		else
			Using = false
			SetAction(false)
			if HL then
				HL:Destroy()
			end
			if WHS then
				WHS:Destroy()
			end
			game.Lighting.EffectEffect:Destroy()
			Effect:SetPrimaryPartCFrame(Player.Character.HumanoidRootPart.CFrame * CFrame.new(-23, 0, -7.6) * CFrame.Angles(0, math.rad(180), 0))
		end
		task.spawn(function()
			TS:Create(workspace.Camera, TweenInfo.new(.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
				{
					FieldOfView = 55
				}
			):Play()
			task.wait(.1)
			TS:Create(workspace.Camera, TweenInfo.new(.9, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
				{
					FieldOfView = 70
				}
			):Play()
		end)
		task.spawn(function()
			for i, part in pairs(Effect:GetChildren()) do
				if not part:FindFirstChildOfClass("BoolValue") then
					local Bool = Instance.new("BoolValue", part)
					task.wait(.01)
					TS:Create(part, TweenInfo.new(.34, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
						{
							Size = Vector3.new(math.random(4, 7), math.random(.1, 2), 0.797),
							CFrame = part.CFrame + part.CFrame.rightVector * -25, 
							Transparency = 1
						}
					):Play()
				end
			end
		end)
		task.spawn(function()
			for i, part in pairs(Effect:GetChildren()) do
				if not part:FindFirstChildOfClass("BoolValue") then
					local Bool = Instance.new("BoolValue", part)
					task.wait(.001)
					TS:Create(part, TweenInfo.new(.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
						{
							Size = Vector3.new(math.random(4, 7), math.random(.1, 2), 0.797),
							CFrame = part.CFrame + part.CFrame.rightVector * -25, 
							Transparency = 1
						}
					):Play()
				end
			end
		end)
	end
end)

local past = Vector3.new()

while task.wait(.3) do
	if Using then
		for i, v in pairs(workspace:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") and v.Name ~= Player.Name then
				local mbp2 = v:GetChildren()
				for i, v in pairs(mbp2) do
					if v.ClassName == "Part" or v.ClassName == "MeshPart" then
						task.spawn(function()
						    current = v.Position
						    if (current - past).Magnitude > 0.5 then
							local r = v:Clone()
							for i, obj in ipairs(r:GetChildren()) do
								if obj:IsA("BillboardGui") then
									obj:Destroy()
								end
								if obj:IsA("Sound") then
									obj:Destroy()
								end
								if obj:IsA("Motor6D") then
									obj:Destroy()
								end
								if obj:IsA("ParticleEmitter") then
									obj:Destroy()
								end	
								if obj:IsA("Weld") then
									obj:Destroy()
								end	
								if obj:IsA("Attachment") then
									obj:Destroy()
								end	
								if obj:IsA("Decal") then
									obj:Destroy()
								end	
							end
							r.Parent = Asset
							r.CFrame = v.CFrame
							r.Anchored = true
							r.CanCollide = false
							r.CastShadow = false
							r.Transparency = 0.4
							r.Color = Color3.fromRGB(255,0,0)
							r.CollisionGroupId = 2
							r.Material = "SmoothPlastic"
							TS:Create(r, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
								{
									Transparency = 1
								}
							):Play() 
							game.Debris:AddItem(r, 1)
							past = v.Position
						end
						end)
					end
				end
			end
		end
	else
		if workspace:FindFirstChild("WHS") then
			workspace:FindFirstChild("WHS"):Destroy()
		end
		if HL then
			HL:Destroy()
		end
	end
end
