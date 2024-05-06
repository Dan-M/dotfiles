function splitpdfs -d "Split all pdfs in a folder into single page pdfs" -a path
    if not type --quiet qpdf
        echo "splitpfds requires qpdf to work"
        exit 1
    end
    if not test -d $path
        echo "Usage: splitpds ./path/to/dir"
        exit 2
    end
    for file in $path/*.pdf
        set pageName $(string replace '.pdf' '_%d.pdf' $file)
        echo Splitting $file...
        qpdf --split-pages $file $pageName
    end
end
