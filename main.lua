local RunService = game:GetService("RunService")
local Spring = require(game.ReplicatedStorage:WaitForChild("Spring"))

local SPRING_DAMPENING = 1
local SPRING_SPEED = 2.5
local FREQUENCY = 75
local MAX_ANGLE = 2
local RECOVERY_SPEED = 1.5

local CameraController = {}
CameraController.__index = CameraController

function CameraController.new()
    local self = setmetatable({
        _camera = game.Workspace.CurrentCamera,
        _trauma = 0,
        _spring = Spring.new(Vector3.new());
    }, CameraController)

    self._spring.d = SPRING_DAMPENING
    self._spring.s = SPRING_SPEED
    
    return self
end

function CameraController:AddTrauma(stress : number)
    self._trauma = math.clamp(self._trauma + stress, 0, 1)
end

function CameraController:CalculateTrauma(dt : number)
    local seed = math.random(0, 500)
    local transform = {
        (MAX_ANGLE * math.noise(seed, dt * FREQUENCY) * 2 - 1) * math.pow(self._trauma, 2),
        (MAX_ANGLE * math.noise(seed + 1, dt * FREQUENCY) * 2 - 1) * math.pow(self._trauma, 2),
        (MAX_ANGLE * math.noise(seed + 2, dt * FREQUENCY) * 2 - 1) * math.pow(self._trauma, 2),
     }

    self._trauma = math.clamp(self._trauma - RECOVERY_SPEED * dt, 0, 1)
    local angle = CFrame.fromEulerAnglesXYZ(math.rad(transform[1]), math.rad(transform[2]), math.rad(transform[3]))

    self._camera.CFrame = self._camera.CFrame * angle
end

return CameraController
