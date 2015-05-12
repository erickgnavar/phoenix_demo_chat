import {Socket} from 'phoenix'

let chatBox = document.querySelector('#chat-box')
let messageForm = document.querySelector('#message-form')
let messageBox = document.querySelector('#message-box')

let socket = new Socket('/ws')

socket.connect()

socket.join('rooms:lobby', {}).receive('ok', channel => {
    channel.push('new_message', {
        message: 'hello there'
    })
    channel.on('new_message', payload => {
        var li = document.createElement('li')
        li.className = 'list-group-item'
        li.innerHTML = payload.message
        if (chatBox.children.length) {
            chatBox.insertBefore(li, chatBox.firstChild)
        } else {
            chatBox.appendChild(li)
        }
        messageBox.value = ''
    })

    messageForm.addEventListener('submit', event => {
        event.preventDefault();
        channel.push('new_message', {
            message: messageBox.value
        })

        messageBox.value = ''
        messageBox.scrollTop = messageBox.scrollHeight
    })
})



let App = {
}

export default App
