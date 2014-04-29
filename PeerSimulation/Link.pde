class Link<L,R>
 {
    private final L left;
    private final R right;

    public Link(L left, R right)
    {
      this.left = left;
      this.right = right;
    }

    public L getLeft() { return left; }
    public R getRight() { return right; }

    @Override
    public int hashCode() { return left.hashCode() ^ right.hashCode(); }

    @Override
    public boolean equals(Object o)
    {
      if (o == null) return false;
      if (!(o instanceof Link)) return false;
      Link<L,R> pairo = (Link<L,R>) o;
      return this.left.equals(pairo.getLeft()) &&
             this.right.equals(pairo.getRight());
    }
    
    public void display()
    {
      stroke(255);
      fill(255);
      line(((Peer)left).x, ((Peer)left).y, ((Peer)right).x, ((Peer)right).y);
    }
 }
