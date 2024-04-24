const { Telegraf } = require("telegraf");
const bot = new Telegraf("6955295791:AAEBY6cOFr1gPtLez6UNr4_0Vvo2yh36Ao0");

const net = require("net");

// Connect to Neovim server
const client = net.createConnection({ port: 8000, host: "localhost" }, () => {
  console.log("Connected to Neovim server!");
});

// Handle incoming data from Neovim server
client.on("data", (data) => {
  console.log("Received from Neovim:", data.toString());
});

// Handle server connection closed
client.on("end", () => {
  console.log("Disconnected from Neovim server");
});

bot.mention("ht3aa", (ctx) => {
  try {
    if (ctx.message.text.includes("@ht3aa")) {
      client.write(`
telegram bot message
from:${ctx.from.first_name} @${ctx.from.username}
msg: ${ctx.message.text}
`);
    }
  } catch (error) {
    console.log(error);
  }
});

bot.launch();
