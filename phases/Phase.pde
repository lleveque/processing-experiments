public class Phase
{
  float period = 1000;
  
  Phase(){}
  
  Phase(int period)
  {
    this.period = abs(period);
  }
  
  public float p() // from 0 to 1
  {
    return (float)millis()%this.period/this.period;
  }
  
  public float n() // from 1 to 0
  {
    return 1-p();
  }
  
  public float o() // from -1 to 1
  {
    return 2*p()-1;
  }
  
  public float r() // from 0 to 2*PI
  {
    return p()*2*PI;
  }
  
  public float i() // from 1 to 0 to 1
  {
    return abs(o());
  }
  
  public float l() // from 0 to 1 to 0
  {
    return 1-i();
  }
  
  public float s() // sin
  {
    return sin(r());
  }
  
  public float c() // cos
  {
    return cos(r());
  }
  
  public float b() // byte
  {
    return 255*p();
  }
  
  public float b(float value)
  {
    return 255*value;
  }
  
}
