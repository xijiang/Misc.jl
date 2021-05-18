"""
    function dl_pfdsj()
---
## Prepare a template
```bash
pandoc -D latex >template.tex
```
Insert
```latex
\\XeTeXlinebreaklocale "zh"
```
after
```latex
\$if(mathfont)\$
% blah blah
\$endif\$

## Compile to pdf
```bash
pandoc pf.md
    -V 'mainfont:FangSong'
    -V papersize:a5
    --pdf-engine=xelatex
    --template=template.tex
    -o pf.pdf
```
"""
function dl_pfdsj()
    url = "http://www.dushu369.com/zhongguomingzhu/HTML"
    pf = open("pf.md", "w")
    for page in 12349:-1:12188
        page == 12213 && continue
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
