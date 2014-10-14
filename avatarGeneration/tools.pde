public class DiscPointMaker
{  
  public float diameter = 100.0f;
  
  public DiscPointMaker(float diameter)
  {
    if(diameter > 0)
    {
      this.diameter = diameter;
    }
  }
  
  public DiscPoint fromPolar(float r, float t)
  {
    return new DiscPoint(DiscPoint.POLAR, this.diameter, r, t);
  }
  
}

public class DiscPoint
{
  final static boolean POLAR = true;
  final static boolean CARTESIAN = false;
  
  private float x, y, r, t;
  
  public DiscPoint(boolean mode, float diameter, float firstCoordinate, float secondCoordinate)
  {
  }
  
  private void updateCartesian()
  {
    this.x = this.r * cos(this.t);
    this.y = this.r * sin(this.t);
  }
  
  private void updatePolar()
  {
    this.r = sqrt(this.x*this.x + this.y*this.y);
    this.t = (float)Math.atan2(this.y, this.x);
  }
  
  // cartesian coordinates
  public float x(){return this.x;}
  public float y(){return this.y;}
  // polar coordinates
  public float r(){return this.r;}
  public float t(){return this.t;}
  
  // cartesian coordinates
  public void x(float nx){this.x = nx; updatePolar();}
  public void y(float ny){this.y = ny; updatePolar();}
  // polar coordinates
  public void r(float nr){this.r = nr; updateCartesian();}
  public void t(float nt){this.t = nt; updateCartesian();}
}
