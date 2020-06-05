local myseat = nil
local viewlock = false

AddEvent("OnKeyPress",function(key)
    if key == "J" then
        EnableFirstPersonCamera(not IsFirstPersonCamera())
        if IsFirstPersonCamera() then
            SetNearClipPlane(20)
        else
            SetCameraLocation(0, 0, 0 ,false)
            SetCameraRotation(0, 0, 0 ,false)
            SetNearClipPlane(0)
        end
    end
    if key == "N" then
       viewlock = not viewlock
       if not viewlock then
          SetCameraLocation(0, 0, 0 ,false)
          SetCameraRotation(0, 0, 0 ,false)
       end
    end
end)

AddEvent("OnPlayerLeaveVehicle",function(ply,veh,seat)
    if ply == GetPlayerId() then
        myseat = nil
        SetCameraLocation(0, 0, 0 ,false)
        SetCameraRotation(0, 0, 0 ,false)
    end
end)

AddEvent("OnPlayerEnterVehicle",function(ply,veh,seat)
    if ply == GetPlayerId() then
       myseat = seat
       SetCameraLocation(0, 0, 0 ,false)
       SetCameraRotation(0, 0, 0 ,false)
    end
end)

AddEvent("OnGameTick",function()
    if (IsPlayerInVehicle() and IsFirstPersonCamera() and myseat) then
        local veh = GetPlayerVehicle(GetPlayerId())
        local plyactor = GetPlayerActor(GetPlayerId())
        local loc = plyactor:GetActorLocation()
        local x = loc.X 
        local y = loc.Y
        local z = loc.Z
        local ux,uy,uz = GetPlayerUpVector(GetPlayerId())
        local fx,fy,fz = GetPlayerForwardVector(GetPlayerId())
        local rx,ry,rz = GetPlayerRightVector(GetPlayerId())
        local height = 31
        local decal = -20
        local decal_r = 0
        if (GetVehicleModel(veh) == 10 or GetVehicleModel(veh) == 20) then
           height = 75
           decal = -50
           decal_r = -10
        elseif (GetVehicleModel(veh) == 4 and (myseat == 2 or myseat == 3 or myseat == 4)) then
            height = 51
        elseif ((GetVehicleModel(veh) == 7 or GetVehicleModel(veh) == 8) and (myseat == 2 or myseat == 3 or myseat == 4)) then
           height = 75
        elseif ((GetVehicleModel(veh) == 9 or GetVehicleModel(veh) == 17 or GetVehicleModel(veh) == 18 or GetVehicleModel(veh) == 22 or GetVehicleModel(veh) == 23 or GetVehicleModel(veh) == 24) and myseat == 2) then
            height = 137
            decal_r = 20
            decal = -15
        elseif ((GetVehicleModel(veh) == 11 or GetVehicleModel(veh) == 12 or GetVehicleModel(veh) == 25) and (myseat == 2 or myseat == 3 or myseat == 4)) then
           height = 39
        elseif GetVehicleModel(veh) == 26 then
            height = 110
            decal_r = 39
            decal = 15
        elseif ((GetVehicleModel(veh) == 27) and (myseat == 2)) then
            decal = -55
            height = 52
        elseif ((GetVehicleModel(veh) == 28) and (myseat == 1)) then
            height = 33
            decal = -25
        elseif ((GetVehicleModel(veh) == 28) and (myseat == 2)) then
            decal = -45
            height = 59
        elseif ((GetVehicleModel(veh) == 29 or GetVehicleModel(veh) == 33 or GetVehicleModel(veh) == 34) and (myseat == 2)) then
            decal = -45
            height = 56
        elseif ((GetVehicleModel(veh) == 29) and (myseat == 3 or myseat == 4)) then
            decal = -55
            height = 56
        elseif ((GetVehicleModel(veh) == 30 or GetVehicleModel(veh) == 31) and (myseat == 1 or myseat == 2)) then
            decal = -45
            height = 56
        end
        SetCameraLocation(x+ux*height+fx*decal+rx*decal_r, y+uy*height+fy*decal+ry*decal_r, z+uz*height+fz*decal+rz*decal_r ,true)
        if viewlock then
            local vrotx,vroty,vrotz = GetVehicleRotation(veh)
            SetCameraRotation(vrotx, vroty, vrotz ,true)
        end
    end
end)