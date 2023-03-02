const express = require('express')
const fetch = require('node-fetch')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
    setInterval(()=>{
        fetch('https://illusto.onrender.com')
    },2500)
  console.log(`Example app listening on port ${port}`)
})
