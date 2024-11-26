# Create Users
alice = User.create!(name: "Alice", email: "alice@example.com", password: "password")
bob = User.create!(name: "Bob", email: "bob@example.com", password: "password")
charlie = User.create!(name: "Charlie", email: "charlie@example.com", password: "password")

# Create a Conversation Window for group chat
group_conversation = ConversationWindow.create!(name: "Project Chat", chat_type: "group_chat", user_ids: [alice.id, bob.id, charlie.id])

# Create a Group associated with the Conversation Window
group = Group.create!(
  title: "Project Team",
  description: "Discussion for the project.",
  user_ids: [alice.id, bob.id, charlie.id],
  conversation_window_id: group_conversation.id
)

# Add users to the group_users table
GroupUser.create!(group: group, user: alice)
GroupUser.create!(group: group, user: bob)
GroupUser.create!(group: group, user: charlie)

# Add users to the conversation_window_users join table
ConversationWindowUser.create!(conversation_window: group_conversation, user: alice)
ConversationWindowUser.create!(conversation_window: group_conversation, user: bob)
ConversationWindowUser.create!(conversation_window: group_conversation, user: charlie)

# Create Messages for the group conversation
Message.create!(sender_id: alice.id, content: "Hello Team!", conversation_window_id: group_conversation.id)
Message.create!(sender_id: bob.id, content: "Hi Alice!", conversation_window_id: group_conversation.id)
Message.create!(sender_id: charlie.id, content: "Hey everyone!", conversation_window_id: group_conversation.id)

# Create a Conversation Window for personal chat between Alice and Bob
personal_conversation = ConversationWindow.create!(name: "Alice and Bob", chat_type: "personal", user_ids: [alice.id, bob.id])

# Create Messages in the personal conversation
Message.create!(sender_id: alice.id, receiver_id: bob.id, content: "Hi Bob!", conversation_window_id: personal_conversation.id)
Message.create!(sender_id: bob.id, receiver_id: alice.id, content: "Hello Alice!", conversation_window_id: personal_conversation.id)

# Add users to the conversation_window_users table for personal chat
ConversationWindowUser.create!(conversation_window: personal_conversation, user: alice)
ConversationWindowUser.create!(conversation_window: personal_conversation, user: bob)
