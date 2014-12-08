import java.util.Timer;
import java.util.TimerTask;

private static final int
WIDTH = 800,
HEIGHT = 800,
NB_INITIAL_PEERS = 10,
PUBLISH_MIN = 2000,
PUBLISH_ADD = 5000,
DISCOVER_MIN = 1000,
DISCOVER_ADD = 3000,
SEND_MIN = 500,
SEND_ADD = 2000;

int nb_peers = NB_INITIAL_PEERS;
int simu = 0;
boolean rotateOn = false;
float speed = 0.01;
float offset = 0f;

PeerNetwork net;

void setup()
{
  size(WIDTH, HEIGHT);
  background(0);
  smooth();
  
  net = new PeerNetwork();
  
  for(int i=0; i<nb_peers; i++)
  {
    Peer p;
    if(Math.random()>0.5)
    {
      p = new Peer("Peer "+i, "Session "+(int)(2*Math.random()), (int)(255*Math.random()));
    }
    else
    {
      p = new Peer("Peer "+i);
    }
    net.peers.add(p);
    net.listeners.add(p.listener);
    p.makeDiscoverable(PUBLISH_MIN, (int)(PUBLISH_ADD*Math.random()));
  }
}

void draw()
{
  background(0);
  
  float unspeed = (1000/speed);
  float phase = millis()%unspeed/unspeed;
  
  drawInfo();
  
  net.placePeers();
  
  translate(width/2, height/2);
  
  float angle;
  
  if(rotateOn)
  {
    angle = (float)(2*Math.PI*phase+offset);
  }
  else
  {
    angle = 0;
  }
  
  rotate(angle);
  net.display(angle);
}

void keyPressed() {
  int keyIndex = -1;
  switch(key)
  {
    case 'w':
      simu++;
      nb_peers++;
      setup();
      break;
    case 's':
      simu++;
      nb_peers=max(0,nb_peers-1);
      setup();
      break;
    case 'm':
      net.allSendAll();
      break;
    case 'r':
      rotateOn = !rotateOn;
      break;
    case 'q':
      speed = speed/2f;
      break;
    case 'e':
      speed = speed*2f;
      break;
    case 'a':
      offset -= 0.05;
      break;
    case 'd':
      offset += 0.05;
      break;
    case ' ':
      simu++;
      setup();
      break;
  }
}

void drawInfo()
{
  fill(255);
  
  textAlign(LEFT,BASELINE);
  text(
  "Simulation with "+nb_peers+" peers\n"+
  "Peers will publish between " + PUBLISH_MIN + " and " + (PUBLISH_MIN+PUBLISH_ADD) + " ms,\n"+
  "discover between " + DISCOVER_MIN + " and " + (DISCOVER_MIN + DISCOVER_ADD) + " ms\n"+
  "and send between " + SEND_MIN + " and " + (SEND_MIN + SEND_ADD) + " ms\n" +
  "Press <Space> to restart simulation, <w>/<s> to add/remove peer"
  , 10, 15);
}
