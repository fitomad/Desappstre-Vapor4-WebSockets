var ws = new WebSocket("ws://localhost:8080/chat")

var searchParams = new URLSearchParams(window.location.search)
var nickname = searchParams.get("nick")
var room = searchParams.get("room")
var isPrivateRoom = searchParams.get("private") == true

// Mostramos el nombre de la sala
id("titleRoomName").innerText = "Bienvenido a " + room + ", " + nickname

//
// WebSocket Events
//

// Abierta conexión con el servidor
ws.onopen = function() {
    var json_str = composeConnectionMessage()
    ws.send(json_str)

    id("textareaChat").value += "Conectado a la sala"
};

// Mensaje por parte del servidor
ws.onmessage = function (evt) {
    message = JSON.parse(evt.data)

    var newmsg = "\n[" + message["sender"]  + "] " + message["text"]
    id("textareaChat").value += (newmsg)
};

//
// Widgets Events
//

// Enviamos el mensaje si la tecla pulsada es `Enter`
id("inputMessage").addEventListener("keypress", function (e) {
    if (e.keyCode === 13) 
    { 
        if(isPrivateRoom)
        {
            privateSend(e.target.value, this.room)
        }
        else
        {
            send(e.target.value)
        }
        
        // Dejamos la caja de texto lista para 
        // enviar otro mensaje
        id("inputMessage").value = ""
    }
});

/*
    Helper function - Devuelve el elemento del árbol DOM
    en base a su id
*/
function id(id) {
    return document.getElementById(id);
}

/*

*/
function send(message)
{
    json_str = composePublic(message)
    ws.send(json_str)
}

/*

*/
function privateSend(message, user)
{
    json_str = composePrivate(message)
    ws.send(json_str)
}

/**
 * 
 * 
 * @param message 
 * @param room 
 */
function composePublic(message)
{
    var json_message = {
        "message_type" : "public",
        "sender" : this.nickname,
        "room" : this.room,
        "text" : message
    }

    return JSON.stringify(json_message)
}

/**
 * 
 * 
 * @param message 
 * @param user 
 */
function composePrivate(message)
{
    var json_message = {
        "type" : "private",
        "from" : nickname,
        "to" : user,
        "text" : message
    }

    return JSON.stringify(json_message)
}

/**
 * Mensaje que enviamos al servidor para
 * que gestione una nueva conexion
 */
function composeConnectionMessage()
{
    var json_message = {
        "type" : "login",
        "nickname" : this.nickname,
        "room" : this.room
    }

    return JSON.stringify(json_message)
}