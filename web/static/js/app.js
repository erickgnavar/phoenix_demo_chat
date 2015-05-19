import {Socket} from 'phoenix'

let chatBox = document.querySelector('#chat-box')
let messageForm = document.querySelector('#message-form')
let messageBox = document.querySelector('#message-box')

let socket = new Socket('/ws')

socket.connect()

let chan = socket.chan('rooms:lobby', {})

chan.on('new_message', payload => {
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

    chan.push('new_message', {
        message: messageBox.value
    })

    messageBox.value = ''
    messageBox.scrollTop = messageBox.scrollHeight
})

chan.join().receive('ok', chan => {
    console.log('Welcome to Phoenix Chat!')
})

let App = {
}

export default App
