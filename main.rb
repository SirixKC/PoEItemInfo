require 'win32/clipboard'
require 'green_shoes'
include Win32

def findDps(min, max, spd)
	avg = (min.to_i + max.to_i)/2
	avgg = (avg * spd.to_f)
	return avgg
end

def findMin(info)

	if info.include?('Physical Damage: ')
		line1 = info.split('Physical Damage: ')
		line2 = line1[1].split('-')
		return line2[0]
	else 
		return 1
	end

end

def findMax(info)
	if info.include?('Physical Damage: ')
		line1 = info.split('Physical Damage: ')
		line2 = line1[1].split('-')
		line3 = line2[1].split(' (')
		return line3[0]
	else 
		return 1
	end
end

def findSpd(info)
	if info.include?('Attacks per Second: ')
		line1 = info.split('Attacks per Second: ')
		line2 = line1[1].split(' (')
		return line2[0]
	else 
		return 1
	end
end

def printDps()

	rawinfo = Clipboard.data

	min = findMin(rawinfo)
	max = findMax(rawinfo)
	spd = findSpd(rawinfo)
	if( min == 1 )
		return "Please copy a weapon!"
	else
		truedps = findDps(min.to_i, max.to_i, spd.to_f).round
		return "Your weapon has #{truedps} damage per second."
	end
	
end

Shoes.app width: 600, height: 900, title: "PoEItemInfo" do
	img = image "data/poelogo.jpg"
	background background(img) 
	eb1 = edit_box width: 300, height: 600, background: black
	eb1.text = Clipboard.data
	eb2 = edit_box width: 250, height: 25, background: black
	@button1 = button "Calculate dps"
	@button1.move(400, 400)
		@button1.click{ eb2.text = printDps
			eb1.text = Clipboard.data}
end
