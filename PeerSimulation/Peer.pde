class Peer
{
  private static final int PEER_DIAMETER = 30;
  
  String session;
  String identifier;
  Integer port;
  Boolean discoverable = false;
  
  final ArrayList<Peer> outlinks = new ArrayList<Peer>();
  final ArrayList<Message> outbox = new ArrayList<Message>();
  SimuListener listener;
  
  public float x, y;
  
  // Constructors
  Peer(String identifier)
  {
     this.identifier = identifier;
     this.listener = new SimuListener(this);
  }
  
  Peer(String identifier, String session, Integer port)
  {
     this.identifier = identifier;
     this.session = session;
     this.port = port;
     this.listener = new SimuListener(this);
  }
  
  void display()
  {
    if(discoverable)
    {
      float theta;
      
      stroke(255);
      
      synchronized(outlinks)
      {
        for(Peer p : outlinks)
        {
          theta = (float)Math.atan2( (p.y-y), (p.x-x) )%(2*PI); //from us
          float x1, y1, x2, y2;
          x1 = x + PEER_DIAMETER/2*cos(theta);
          y1 = y + PEER_DIAMETER/2*sin(theta);
          x2 = p.x + PEER_DIAMETER/2*cos(theta+PI);
          y2 = p.y + PEER_DIAMETER/2*sin(theta+PI);
          line(x1, y1, x2, y2);
          line(x2, y2, x2+10*cos(theta+7*PI/8), y2+10*sin(theta+7*PI/8));
          line(x2, y2, x2+10*cos(theta-7*PI/8), y2+10*sin(theta-7*PI/8));
        }
      }
      
      synchronized(outbox)
      {
        fill(255);
        for(Message m : outbox)
        {
          if(m.getProgress()<1)
          {
            Peer p = m.to;
            theta = (float)Math.atan2( (p.y-y), (p.x-x) )%(2*PI); //from us
            float x1, y1, x2, y2;
            x1 = x + PEER_DIAMETER/2*cos(theta);
            y1 = y + PEER_DIAMETER/2*sin(theta);
            x2 = p.x + PEER_DIAMETER/2*cos(theta+PI);
            y2 = p.y + PEER_DIAMETER/2*sin(theta+PI);
            
            ellipse(x1+(x2-x1)*m.getProgress(), y1+(y2-y1)*m.getProgress(), 5,5);
  //          line(x1, y1, x2, y2);
  //          line(x2, y2, x2+10*cos(theta+7*PI/8), y2+10*sin(theta+7*PI/8));
  //          line(x2, y2, x2+10*cos(theta-7*PI/8), y2+10*sin(theta-7*PI/8));
          }
        }
      }
      
      if(session == null || port == null)
      {
        fill(255,195,125);
      }
      else
      {
        fill(195,255,125);
      }
      
      ellipse(x, y, PEER_DIAMETER, PEER_DIAMETER);
      text(this.identifier, x, y+35);
    
//      fill(128,255,128);
    }
    else
    {
      fill(255,128,128);    
      ellipse(x, y, 10, 10);
    }
  }
  
  public void makeDiscoverable()
  {
    this.discoverable = true;
    net.discoveryEvent(this);
  }
  
  public void makeDiscoverable(int minDelay, int additionalDelay)
  {
    Timer t = new Timer("");
    final int originalSimu = simu;
    t.schedule(new TimerTask()
    {
        @Override
        public void run()
        {
          if(originalSimu == simu)
          {
            Peer.this.makeDiscoverable();
          }      
        }
    }, minDelay+additionalDelay);
  }
  
  public void discover(Peer p)
  { 
      synchronized(outlinks)
      {
        outlinks.add(p);
      }
      synchronized(outbox)
      {
        outbox.add(new Message(p, "Hello !"));
      }
  }
  
  public void discover(final Peer p, int minDelay, int additionalDelay)
  {
    println("Got it, connecting in " + (minDelay+additionalDelay) + "ms ! ("+identifier+")");
    Timer t = new Timer("");
    final int originalSimu = simu;
    t.schedule(new TimerTask()
    {
        @Override
        public void run()
        {
          if(originalSimu == simu)
          {
            Peer.this.discover(p);
          }      
        }
    }, minDelay+additionalDelay);
  }
  
  public void sendAll()
  {
    synchronized(outlinks)
    {
      for(Peer p: outlinks)
      {
        synchronized(outbox)
        {
          outbox.add(new Message(p, "Hello !"));
        }
      }
    }
  }
  
  public void onIncomingConnection(Peer p)
  {
    this.outlinks.add(p); // connection to our serverSocket
  }
  
  public void onOutgoingConnection(Peer p)
  {
    this.outlinks.add(p); // connection to peer's serverSocket
  }
}
