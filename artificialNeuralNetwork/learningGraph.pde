class GraphPoint
{
  final float x, y;
  GraphPoint(float x, float y) {this.x=x;this.y=y;}
}

class LearningGraph
{
  ArrayList<GraphPoint> data;
  float xMin = 0, xMax = 0, yMin = 0, yMax = 0; 
  
  LearningGraph()
  {
    this.data = new ArrayList<GraphPoint>();
  }
  
  void set(float x, float y)
  {
    for(GraphPoint p:this.data)
    {
      if(p.x==x)
      {
        this.data.remove(p);
      }
    }
    add(x,y);
  }
  
  void add(float x, float y)
  {
    this.data.add(new GraphPoint(x,y));
    updateBounds();
  }
  
  void updateBounds()
  {
    if(this.data.size()>0)
    {
      GraphPoint p = this.data.get(0);
      xMin = p.x;
      xMax = p.x;
      yMin = p.y;
      yMax = p.y;
    }
    
    // find extrema
    for(GraphPoint p:this.data)
    {
      xMin = p.x<xMin?p.x:xMin;
      xMax = p.x>xMax?p.x:xMax;
      yMin = p.y<yMin?p.y:yMin;
      yMax = p.y>yMax?p.y:yMax;
    }
  }
  
  void draw(float x, float y, float w, float h)
  {
    draw(x, y, w, h, xMin, xMax, yMin, yMax);
  }
  
  void draw(float x, float y, float w, float h, float xMin, float xMax, float yMin, float yMax)
  {
    fill(255);
    rect(x,y,w,h);
    
    // draw
    stroke(0);
    line(x,y,x,y+h);
    line(x,y+h,x+w,y+h);
    line(x-5,y+5,x,y);
    line(x+5,y+5,x,y);
    line(x+w-5,y+h-5,x+w,y+h);
    line(x+w-5,y+h+5,x+w,y+h);
    
    fill(0,0,0,50);
    
    float px,py;
    
    float lpx = map(0, xMin, xMax, x, x+w);
    float lpy = map(0, yMin, yMax, y+h, y);
    
    // TODO sort data before graphing
    for(GraphPoint p:this.data)
    {
      stroke(0);
      px = map(p.x, xMin, xMax, x, x+w);
      py = map(p.y, yMin, yMax, y+h, y);
      
      line(lpx,lpy,px,py);
      lpx=px;
      lpy=py;
      
      noStroke();
      ellipse(px,py,10,10);
    }
    
    fill(0);
    textFont(font, 10);
    if(this.data.size()>0)
    {
      text(str(this.data.get(this.data.size()-1).y),x+w+5,lpy);
      if(xMin==yMin)
      {
        text(str(floor(xMin)),x-15,y+h+15);
      }
      else
      {
        text(str(floor(xMin)),x-5,y+h+20);
        text(str(floor(yMin)),x-15,y+h+5);
      }
      
      text(str(floor(xMax)),x+w,y+h+20);
      text(str(floor(yMax)),x-15,y+5);
    }
  }
}
