SCREEN="web-mirror"
PORT=9999
REFRESH_DELAY=4

TEMPHARDCOPY=/tmp/web-mirror.txt
TEMPHEADER=/tmp/web-mirror-header.html
TEMPFOOTER=/tmp/web-mirror-footer.html

TEMPHTML=/tmp/web-mirror.html

cat>$TEMPHEADER<<END
<html>
<meta http-equiv="Refresh" content="${REFRESH_DELAY}">
<pre>
END

cat>$TEMPFOOTER<<END
</pre>
</html>
END

HEADER=$TEMPHEADER
FOOTER=$TEMPFOOTER

while [ 1 ]; do
    screen -x web-mirror -X hardcopy $TEMPHARDCOPY
    BODY=$TEMPHARDCOPY
    cat $HEADER \
        $BODY \
        $FOOTER > $TEMPHTML
    nc -l 9999 < $TEMPHTML
done
