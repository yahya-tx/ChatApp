
// app/javascript/application.js
import "@hotwired/turbo-rails";
import "controllers";
import "channels"; // This imports all channel files, including consumer.js
import "channels/conversation_channel";  // Ensure this import is correct
import "chartkick"
import "Chart.bundle"
import { consumer } from "channels/consumer"; // Ensure the correct import

document.addEventListener("turbo:load", () => {
  const conversationWindow = document.getElementById("conversation-window");

  if (conversationWindow) {
    const conversationWindowId = conversationWindow.dataset.id;

    // Check if we have a valid conversation window ID
    if (!conversationWindowId) {
      console.error("No conversation window ID found.");
      return;
    }

    // Log connection attempt
    console.log(`Attempting to create subscription for conversation window ID: ${conversationWindowId}`);

    // Create WebSocket connection
    consumer.subscriptions.create(
      {
        channel: "ConversationChannel",
        conversation_window_id: conversationWindowId,
      },
      {
        connected() {
          console.log(`Connected to conversation channel with window ID: ${conversationWindowId}`);
        },
        disconnected() {
          console.log("Disconnected from conversation channel");
        },
        received(data) {
          console.log("Received data:", data);

          const chatMessages = document.getElementById("chat-messages");
          if (chatMessages) {
            const newMessage = `
              <div class="mb-2 ${data.sender_id === currentUser.id ? "bg-green-100" : "bg-blue-100"} p-2 rounded-lg">
                <p><strong>${data.sender}:</strong> ${data.message}</p>
                ${
                  data.attachment_url
                    ? `<img src="${data.attachment_url}" class="w-32 h-32 object-cover rounded shadow-md mt-2" />`
                    : ""
                }
                <span class="text-xs text-gray-500">${data.created_at}</span>
              </div>
            `;
            chatMessages.insertAdjacentHTML("beforeend", newMessage);
            chatMessages.scrollTop = chatMessages.scrollHeight;
          }
        },
      }
    );
  } else {
    console.error("Element with ID 'conversation-window' not found in the DOM.");
  }
});

// You can add the WebSocket connection logic here:

document.addEventListener("turbo:load", () => {
  const conversationWindow = document.getElementById("conversation-window");

  if (conversationWindow) {
    const conversationWindowId = conversationWindow.dataset.id;

    // Check if we have a valid conversation window ID
    if (!conversationWindowId) {
      console.error("No conversation window ID found.");
      return;
    }

    // Log connection attempt
    console.log(`Attempting to create subscription for conversation window ID: ${conversationWindowId}`);

    // Create WebSocket connection
    consumer.subscriptions.create(
      {
        channel: "ConversationChannel",
        conversation_window_id: conversationWindowId,
      },
      {
        connected() {
          console.log(`Connected to conversation channel with window ID: ${conversationWindowId}`);
        },
        disconnected() {
          console.log("Disconnected from conversation channel");
        },
        received(data) {
          console.log("Received data:", data);

          const chatMessages = document.getElementById("chat-messages");
          if (chatMessages) {
            const newMessage = `
              <div class="mb-2 ${data.sender_id === currentUser.id ? "bg-green-100" : "bg-blue-100"} p-2 rounded-lg">
                <p><strong>${data.sender}:</strong> ${data.message}</p>
                ${
                  data.attachment_url
                    ? `<img src="${data.attachment_url}" class="w-32 h-32 object-cover rounded shadow-md mt-2" />`
                    : ""
                }
                <span class="text-xs text-gray-500">${data.created_at}</span>
              </div>
            `;
            chatMessages.insertAdjacentHTML("beforeend", newMessage);
            chatMessages.scrollTop = chatMessages.scrollHeight;
          }
        },
      }
    );
  } else {
    console.error("Element with ID 'conversation-window' not found in the DOM.");
  }
});

console.log("Hello from application.js");
