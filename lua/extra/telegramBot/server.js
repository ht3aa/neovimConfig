const net = require("net");

// Create a TCP server
const server = net.createServer((socket) => {
  console.log("Client connected.");

  // Handle data from the client
  socket.on("data", (data) => {
    console.log(data.toString());
  });

  socket.on("end", () => {
    server.close(() => console.log("Server disconnected."));
  })
  // Send data to the client
  socket.write("Hello from Neovim!");
});

// Listen for incoming connections
server.listen(8000, "localhost", () => {
  console.log("Server bound to port 3000.");
});


