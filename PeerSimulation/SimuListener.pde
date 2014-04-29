class SimuListener
{
  Peer me;
  
  SimuListener(Peer p)
{
  me = p;
}
  
  public synchronized void discoveryEvent(Peer p)
  {
    if(!me.equals(p))
    {
//      net.links.add(new Link(me, p));
      me.discover(p, DISCOVER_MIN, (int)(DISCOVER_ADD*Math.random()));
    }
    else
    {
      println("Got it, but it's me ! ("+me.identifier+")");
    }
  }
  
  public void sendAll()
  {
    me.sendAll();
  }
}
