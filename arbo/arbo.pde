// Parses a tree hierarchy from data/tree.xml and render it in some way

XML tree;
int taille = 20;
int period = 60000;

float rotation=0;

void printXML(String filename){
  tree = loadXML(filename);
  
  XML[] branches = tree.getChildren("branch");
  for (int i = 0; i < branches.length; i++) {
    String branchName = branches[i].getString("name");
    println("[" + branchName + "]");
    
    XML[] teams = branches[i].getChildren("team");
    for (int j = 0; j < teams.length; j++) {
      String teamName = teams[j].getString("name");
      println("   " + teamName + " :");
      
      XML[] persons = teams[j].getChildren("person");
      for (int k = 0; k < persons.length; k++) {
        String personName = persons[k].getString("name");
        String gender = persons[k].getString("gender"); 
        int age = persons[k].getInt("age");
        println("      - " + personName + " (" + age + ", " + gender + ")");    
      }
      println();
    }
    println("-----------------------------------------");
  }
}

void drawXML(String filename) {
  tree = loadXML(filename);
  
  pushMatrix();
    rotate(rotation);
    ellipse(0,0,taille*4,taille*4);
  
  XML[] branches = tree.getChildren("branch");
  for (int i = 0; i < branches.length; i++) {
    
    rotate(2*PI/(branches.length));
    pushMatrix();
      rotate(-2*rotation);
      translate(0, taille*7.5);
      ellipse(0, 0, taille*3, taille*3);
    
    //String branchName = branches[i].getString("name");
    //println("[" + branchName + "]");
    
    XML[] teams = branches[i].getChildren("team");
    for (int j = 0; j < teams.length; j++) {
      //String teamName = teams[j].getString("name");
      //println("   " + teamName + " :");
      rotate(2*PI/(teams.length));
      pushMatrix();
          rotate(3*rotation);
        translate(0, taille*3.5);
        ellipse(0, 0, taille*2, taille*2);
    
      XML[] persons = teams[j].getChildren("person");
      for (int k = 0; k < persons.length; k++) {
        
        rotate(2*PI/(teams.length));
        pushMatrix();
          rotate(-4*rotation);
          translate(0, taille*1.5);
          ellipse(0, 0, taille, taille);
        popMatrix();
          
        //String personName = persons[k].getString("name");
        //String gender = persons[k].getString("gender"); 
        //int age = persons[k].getInt("age");
        //println("      - " + personName + " (" + age + ", " + gender + ")");    
      }
      popMatrix();
      //println();
      
    }
    popMatrix();
    //println("-----------------------------------------");
  }
  
  popMatrix();
  
}

void setup() {
  size(500,500);
  //printXML("tree.xml");
  println(loadXML("tree.xml"));
   
}

void draw(){
  smooth();
  background(0);
  rotation = ((float)(millis()%period)/(float)period)*2*PI;
  translate(width/2, height/2);
  //rotate(rotation);
  drawXML("tree.xml");
   
}
