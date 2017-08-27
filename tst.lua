
function printTable (tbl)
  for k,v in pairs(tbl) do
    print(k,v)
  end
end


begyearmonth = "2017-08"
endyearmonth = "2017-08"
begday = "14"
endday = "15"
suri = "http://voip.2gis.local/cisco-stat/cdr.php?s=1&t=&order=dateTimeOrigination&sens=DESC&current_page=0&posted=1&current_page=0&fromstatsmonth="..begyearmonth.."&tostatsmonth="..endyearmonth.."&Period=Day&fromday=true&fromstatsday_sday="..begday.."&fromstatsmonth_sday="..begyearmonth.."&today=true&tostatsday_sday="..endday.."&tostatsmonth_sday="..endyearmonth.. "&callingPartyNumber=&callingPartyNumbertype=2&originalCalledPartyNumber=%2B7&originalCalledPartyNumbertype=2&origDeviceName=&origDeviceNametype=1&destDeviceName=&destDeviceNametype=1&resulttype=min&image16.x=28&image16.y=8"
suri2 = "http://voip.2gis.local/cisco-stat/export_csv.php"
-- print(suri)

-- load the http module
local io = require("io")
local http = require("socket.http")
local ltn12 = require("ltn12")

function printTable (tbl)
  for k,v in pairs(tbl) do
    print(k,v)
  end
end

-- connect to server "www.cs.princeton.edu" and retrieves this manual
-- file from "~diego/professional/luasocket/http.html" and print it to stdout

print(suri)

a,b,c = http.request{
    method = "HEAD",
    url = suri,
    sink = ltn12.sink.file(io.stdout),
    headers = {      
      ["connection"] = "upgrade",
      ["timeout"] = 300,
      ["User-Agent"] = "Mozilla/5.0",
      ["version"] = "HTTP/1.1"
    }
  }

print(a)
print(b)
printTable(c)

print("Cookie 1:",c["set-cookie"])

a2,b2,c2 = http.request{
    method = "GET",
    url = suri2,
    sink = ltn12.sink.file(io.stdout),
    headers = {
--      ["connection"] = "Keep-Alive",
      ["Keep-Alive"] = 300,
      ["User-Agent"] = "Mozilla/5.0",
      ["cookie"]=c["set-cookie"]
    }
  }

print(a2)
print(b2)
printTable(c2)
