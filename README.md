
https://user-images.githubusercontent.com/80429347/110708142-2e130800-81f2-11eb-8ac0-cbb6d5cc3e5f.mp4

# camera-trauma
Camera shake based on perlin noise.

Based on this: https://www.youtube.com/watch?v=tu-Qe66AvtY

## Usage
```lua

local Camera = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CameraController"))
local Maid = require(game.ReplicatedStorage:WaitForChild("Maid"))

local RunService = game:GetService("RunService")

local PlayerController = {}
PlayerController.__index = PlayerController

function PlayerController.new()
    local self = setmetatable({
        _maid = Maid.new(),
        _camera = Camera.new(),
        _health = 100
    }, PlayerController)

    local function Update(dt : number)
        self._camera:CalculateTrauma(dt)
    end

    self._maid:GiveTask(RunService.RenderStepped:Connect(Update))

    return self
end

return PlayerController
```
