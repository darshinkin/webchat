package com.chat;

/**
 * Class the <class>{@link Message}</class> defines message.
 */
public class Message {
    /**
     * Chatter
     */
    private Chatter chatter;
    /**
     * String containing message
     */
    private String message;

    /**
     * long containing the time when message was delivered
     */
    private long timeStamp;

    /**
     * This constructor accepts a name of the chatterand the message.
     *
     * @param chatter   the chatter
     * @param message   message of the chatter
     * @param timeStamp time of the message
     */
    public Message(Chatter chatter, String message, long timeStamp) {
        this.chatter = chatter;
        this.message = message;
        this.timeStamp = timeStamp;
    }

    /**
     * Returns the Chatter
     *
     * @return <class>{@link Chatter}</class>
     */
    public Chatter getChatter() {
        return chatter;
    }

    /**
     * Returns message of the chatter
     *
     * @return String
     */
    public String getMessage() {
        return message;
    }

    /**
     * Returns time of the message
     *
     * @return long
     */
    public long getTimeStamp() {
        return timeStamp;
    }
}
