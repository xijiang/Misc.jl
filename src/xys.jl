"""
    function dl_xys_mj()
---
This function is to download all 新语丝·月刊.
"""
function dl_xys_mj()
    url = "http://www.xys.org/xys/magazine/GB"
    for year in 1994:2021
        page = parsehtml(read(download("$url/$year/"), String))
        for k in eachmatch(sel"li", page.root)
            file = Gumbo.text(k)
            if file[1:3] == "xys"
                download("$url/$year/$file", "tmp.txt") # man change save path
                run(`iconv -c -f gbk -t utf8 tmp.txt -o $file`)
            end
        end
    end
    #run(`tar jcvf xys.tar.bz2 xys*.txt`)
end
