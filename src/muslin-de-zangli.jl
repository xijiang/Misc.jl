function dl_msldzl()
    url = "http://www.dushu369.com/zhongguomingzhu/HTML"
    pf = open("msl.md", "w")
    for page in 61706:-1:61685
        download("$url/$page.html", "tmp.txt")
        run(`iconv -cf gbk -t utf8 tmp.txt -o page.txt`)
        chapter = parsehtml(read("page.txt", String))
        for t in eachmatch(sel"title", chapter.root)
            println(pf, "## ", text(t), "\n\n")
        end

        for c in eachmatch(Selector(".content"), chapter.root)
            println(pf, text(c), "\n")
        end
    end
    close(pf)
end
