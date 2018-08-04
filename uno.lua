function clear() if os.getenv("APPDATA") then os.execute("cls") else os.execute("clear") end end clear()

math.randomseed(os.time())

cartas = {}


--atribui os numeros as cartas
for i=1,10 do
	if i ~= 10 then
		cartas[i] = i
	else
		cartas[10] = 0
	end
end

--atribui +4 e +2 as cartas
cartas[11] = "+2"
cartas[12] = "+4"

cores = {"\27[31m", "\27[32m", "\27[93m", "\27[34m"}

--cria o deck
deck = {}
corDeck = {}

function getcards(q)
	local i = 1
	while i <= q  do
		if not deck[i] then
			deck[i] = cartas[math.random(1,12)]
			corDeck[i] = cores[math.random(1,4)]
		else
			q = q + 1
		end
		i = i + 1
	end
end

function userwin()
	print("Você venceu!")
	print("Parabéns")
	os.exit()
end

function checkwin()
	if not next(deck) then
		userwin()
	end
end

function lostgame()
	clear()
	print("Você perdeu!")
	print("O oponente venceu!")
	os.exit()
end

function jogar(carta)
	carta = tonumber(carta)
	if (corDeck[carta] == lastcolor) or (deck[carta] == lastcard) then
		if deck[carta] == "+2" then
			cartasoponente = cartasoponente + 2
		elseif deck[carta] == "+4" then
			cartasoponente = cartasoponente + 4
		end
		if deck[carta] == lastcard then
			lastcolor = corDeck[carta]
		end
		deck[carta] = nil
		corDeck[carta] = nil
		startgame(true)
	else
		startgame()
	end
end

getcards(8)
cartasoponente = 8

function startgame(valid)

	clear()

	if valid then
		if not lastcolor then
			lastcolor = cores[math.random(1,4)]
		end
		lastcard = cartas[math.random(1,10)]
		cartasoponente = cartasoponente - 1
	end
	
	if cartasoponente == 0 then
		lostgame()
	end

	checkwin()

	print("O oponente jogou um " .. lastcolor .. "[" .. lastcard .. "]" .. "\27[0m")
	
	print("O oponente ainda possui " .. cartasoponente .. " cartas")

	print("Suas cartas: ")

	for k,v in pairs(deck) do
		io.write(k .. ". " .. corDeck[k] .. "[" .. v .. "]\27[0m\n")
	end

	io.write("Insira a carta que deseja jogar ou \"comprar\" para comprar uma carta: ")
	escolha = io.read()
	if (tonumber(escolha)) and (deck[tonumber(escolha)]) then
		jogar(escolha)
	elseif string.lower(escolha) == "comprar" then
		getcards(1)
		startgame(true)
	else
		startgame()
	end
end

print("Seja bem vindo ao jogo!")
io.read("Para jogar, digite \"jogar\", ou <enter> para sair\n>>")
sstr = io.read()
if string.lower(sstr) == "jogar" then
	startgame(true)
end
