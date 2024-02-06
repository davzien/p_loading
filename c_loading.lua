if getElementData(localPlayer, "player:logging") then return end

local loading = {}

local font = {}

function loadingFont()
    font["font"] = dxCreateFont("font.ttf", 15)
end

loadingFont()

local screen = {x = 1920, y = 1080} 

local px, py = screen.x / 1920, screen.y / 1080 

loading.pos = {
    ["bg"] = {x = 0, y = 0, w = screen.x, h = screen.y},
    ["bgtext"] = {x = 0, y = 0, w = screen.x, h = screen.y},
    ["text"] = {x = 401*px, y = 1384*py, w = 1520*px, h = 597*py},
}

loading.tex = {
    ["bg"] = dxCreateTexture("files/images/bg.png", "argb", false, "clamp"),
    ["bgtext"] = dxCreateTexture("files/images/bgtext.png", "argb", false, "clamp"),
}

loading.drawRender = function()
    dxDrawImage(loading.pos["bg"].x, loading.pos["bg"].y, loading.pos["bg"].w, loading.pos["bg"].h, loading.tex["bg"], 0, 0, 0, 0xFFFFFFFF)
    dxDrawImage(loading.pos["bgtext"].x, loading.pos["bgtext"].y, loading.pos["bgtext"].w, loading.pos["bgtext"].h, loading.tex["bgtext"], 0, 0, 0, 0xFFFFFFFF)

    dxDrawText("[System] Trwa pobieranie zasobów serwera...", loading.pos["text"].x + 1, loading.pos["text"].y + 1, loading.pos["text"].w + 1, loading.pos["text"].h + 1, 0xFF000000, 1, font["font"], "center", "center")
    dxDrawText("[System] Trwa pobieranie zasobów serwera...", loading.pos["text"].x, loading.pos["text"].y, loading.pos["text"].w, loading.pos["text"].h, 0xFFFFFFFF, 1, font["font"], "center", "center")
end

loading.delete = function()
    stopSound(loading.intro)
    loading.intro = nil
    loading.gui = nil
    removeEventHandler("onClientRender", root, loading.drawRender)
    for _,v in pairs(loading.tex) do
        destroyElement(v)
    end
    loading.dots = nil
    loading = nil
end
addEvent("loading.client:delete", true)
addEventHandler("loading.client:delete", root, loading.delete)

addEventHandler("onClientResourceStart", resourceRoot, function()
    showChat(false)
    loading.gui = true
    loading.intro = playSound("files/sounds/intro.mp3", true)
    addEventHandler("onClientRender", root, loading.drawRender)
end)
