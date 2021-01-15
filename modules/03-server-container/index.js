const express = require('express')
const app = express()

// :: ---

const HOSTNAME = process.env.HOSTNAME
const HOST = process.env.HOST || '0.0.0.0'
const PORT = process.env.PORT || 8080

// :: ---

// :: log all requests coming into the server
app.use((request, _, next) => {
  const timestamp = new Date().toISOString()
  const message = `${timestamp} Request received for [${request.path}].`

  console.log(message)

  next()
})

// :: let's be really friendly
app.get('/hello', (_, response) => {
  const message = `Hi there from ${HOSTNAME}!`
  response.send(message)
})

// :: ---
// :: start the server
app.listen(PORT, HOST, err => {
  if (err) {
    console.error(`Error starting server at ${HOST}:${PORT}.`)
    process.exit(1)
  } else {
    console.log(`App server is listening in at ${HOST}:${PORT}.`)
  }
})
