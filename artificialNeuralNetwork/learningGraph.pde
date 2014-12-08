class GraphPoint
{
  final float x, y;
  GraphPoint(float x, float y) {this.x=x;this.y=y;}
}

class LearningGraph
{
  ArrayList<GraphPoint> data;
  float xMin = 0, xMax = 0, yMin = 0, yMax = 0; 
  String title;
  
  LearningGraph(String title)
  {
    this.title = title;
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
    
    // Axis and arrows
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
    
    // Data points
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
      // Last data label
      textAlign(LEFT,CENTER);
      text(str(this.data.get(this.data.size()-1).y),x+w+5,lpy);
      
      // Axis mins
      if(xMin==yMin)
      {
        textAlign(RIGHT,TOP);
        text(str(floor(xMin)),x-5,y+h+5);
      }
      else
      {
        textAlign(RIGHT,BOTTOM);
        text(str(floor(yMin)),x-5,y+h);
        textAlign(LEFT,TOP);
        text(str(floor(xMin)),x,y+h+5);
      }
      
      // Axis maxs
      textAlign(LEFT,TOP);
      text(str(floor(xMax)),x+w,y+h+5);
      textAlign(RIGHT,TOP);
      text(str(floor(yMax)),x-5,y);
      
      // Title
      textAlign(CENTER);
      text(title, x+w/2, y+h+20);
      textAlign(LEFT);
    }
  }
}
