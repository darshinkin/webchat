package com.chat;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Class the <class>{@link ChatRoom}</class> defines the chat room.
 */
public class ChatRoom {
    /*
    * Map to store Chatter objects
	*/
    private Map<String, Chatter> chatters = new ConcurrentHashMap<>();

    /*
    * Linked list to store Message object
    */
    private List<Message> messages = new LinkedList<>();

    /*
	* Used to set the maximum no of messages
	*/
    private int messages_size = 25;

    /**
     * adds a Chatter object to list of Chatters
     *
     * @param chatter Chatter object
     * @return void
     */
    public void addChatter(Chatter chatter) {
        chatters.put(chatter.getName(), chatter);
    }

    /**
     * removes a Chatter object from list of Chatters
     *
     * @param chatterName name of the chatter.
     * @return void
     */
    public Object removeChatter(String chatterName) {
        return chatters.remove(chatterName);
    }

    /**
     * returns a Chatter object from chatters list.
     *
     * @param chatterName name of the chatter
     * @return com.chat.Chatter
     */
    public Chatter getChatter(String chatterName) {
        return chatters.get(chatterName);
    }

    /**
     * checks whether a chatter exists or not
     *
     * @param chatterName name of the chatter to check
     * @return boolean
     */

    public boolean chatterExists(String chatterName) {
        return chatters.containsKey(chatterName);
    }

    /**
     * returns total number of chatters in this room
     *
     * @return int
     */
    public int getNoOfChatters() {
        return chatters.size();
    }

    /**
     * returns a Set containing all the Chatters in the room
     *
     * @return java.util.Set
     */
    public Set<Map.Entry<String, Chatter>> getChatters() {
        return chatters.entrySet();
    }

    /**
     * adds the message to the messages list
     *
     * @param msg A Message Object
     * @return void
     */
    public synchronized void addMessage(Message msg) {
        if (messages.size() == messages_size) {
            ((LinkedList) messages).removeFirst();
        }
        messages.add(msg);
    }

    /**
     * returns an array of messages sent after given time
     *
     * @param afterTimeStamp Time in milliseconds.
     * @return array
     */
    public List<Message> getMessages(long afterTimeStamp) {
        List<Message> resultList = new LinkedList<>();
        for (Message message : messages) {
            if (message.getTimeStamp() >= afterTimeStamp) {
                resultList.add(message);
            }
        }
        return resultList;
    }

    /**
     * sets maxmium number of messages to this number.
     *
     * @param size the maximum no of messages to hold at a time.
     * @return void
     */
    public void setMaximumNoOfMessages(int size) {
        messages_size = size;
    }
}
