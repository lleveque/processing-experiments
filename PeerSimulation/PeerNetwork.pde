class PeerNetwork
{ 
  private PeerNetwork instance;
  
  public ArrayList<Peer> peers = new ArrayList<Peer>();
  public ArrayList<Link> links = new ArrayList<Link>();
  public ArrayList<SimuListener> listeners = new ArrayList<SimuListener>();
  
  PeerNetwork()
  {}
  
//  void addPeer(Peer peer)
//  {
////    if(peers.size() > 0)
////    {
////      Peer rndPeer = peers.get((int)(Math.random()*peers.size()));
////      links.add(new Link(peer, rndPeer));
////    }
//    
//    peers.add(peer);
//    
//    placePeers();
//  }
  
  void discoveryEvent(Peer p)
  {
    if(p.discoverable)
    {
      println("Peer "+p.identifier+" is now discoverable");
    }
    else
    {
      println("Peer "+p.identifier+" is not discoverable anymore");
    }
    
    for(SimuListener listener: listeners)
    {
      listener.discoveryEvent(p);
    }
  }
  
  void allSendAll()
  {
    for(SimuListener listener: listeners)
    {
      listener.sendAll();
    }
  }
  
  public void placePeers()
  {
    float r = 0.3*Math.min(width,height);
    int n = peers.size();
    int i = 0;
    
    for(Peer p:peers)
    {
      float phase = 2*PI*((float)i/(float)n);
      p.x = (float)(r*Math.cos(phase));
      p.y = (float)(r*Math.sin(phase));
//      println(p.identifier+" : "+p.x+", "+p.y);
      i++;
    }
  }
  
  synchronized void display()
  {
    for(Link l:links)
    {
      l.display();
    }
    
    for(Peer p:peers)
    {
      p.display();
    }
  }
}
