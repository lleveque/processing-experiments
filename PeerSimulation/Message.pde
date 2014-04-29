class Message
{
  public Peer to;
  public String payload;
  public int delay;
  public long time_sent;
  
  public Message(Peer to, String payload)
  {
    this.to = to;
    this.payload = payload;
    this.delay = SEND_MIN + (int)(SEND_ADD*Math.random());
    this.time_sent = millis();
  }
  
  public float getProgress()
  {
    return min(1, (float)(millis()-time_sent)/(float)delay);
  }
}
