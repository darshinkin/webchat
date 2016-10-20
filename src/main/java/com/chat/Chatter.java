package com.chat;

/**
 * Class the <class>{@link Chatter}</class> defines chatter of the chat.
 */
public class Chatter {
    private String name;
    private Color color;
    private long loginTime = -1;

    public Chatter(String name, String color, long loginTime) {
        this.name = name;
        this.color = Color.valueOf(color.toUpperCase());
        this.loginTime = loginTime;
    }

    public Chatter(String name, Color color, long loginTime) {
        this.name = name;
        this.color = color;
        this.loginTime = loginTime;
    }

    public String getName() {
        return name;
    }

    public Color getColor() {
        return color;
    }

    public long getLoginTime() {
        return loginTime;
    }
}
