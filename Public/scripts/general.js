/**
 * Evento `click` del boton de login
 */
id("buttonLogin").addEventListener("click", function(e) {
    var private = false

    var loginMessage = {
        "nickname" : id("txtUsername").value,
        "room" : id("txtRoom").value,
    }

    var loginJSON = JSON.stringify(loginMessage)

    var httpRequest = new XMLHttpRequest();
    httpRequest.open('POST', "/login", true);

    httpRequest.setRequestHeader('Content-type', 'application/json');

    httpRequest.onreadystatechange = function() {
        if(httpRequest.readyState == 4 && httpRequest.status == 200) 
        {
            var newURI = "chat.html?nick=" + id("txtUsername").value + "&room=" + id("txtRoom").value + "&private=" + false
            window.location.replace(newURI)
        }
        else if(httpRequest.readyState == 4 && httpRequest.status == 302) // Nick en uso
        {
            alert("Nickname en uso. Busca otro.")
        }
    }
    
    httpRequest.send(loginJSON);
})

/**
 * Helper method.
 * Recupera un elemento del arbol DOM en base a su
 * identificador `id`
 * 
 * @param {*} identifier 
 */
function id(identifier)
{
    return document.getElementById(identifier)
}