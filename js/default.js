
function isChinese(c) {
    return c.charCodeAt(0) > 255;
}

function clearSpace() {
    var paras = document.getElementsByTagName("p");
    var i;
    for (i = 0; i < paras.length; i++) {
        if (isChinese(paras[i].innerHTML.charAt(0)))
        {
            paras[i].innerHTML = paras[i].innerHTML.replace(/\n/g, '').replace(/ /g, '');
        }
    }
}

