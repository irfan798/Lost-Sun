/*
p = Sürekli nesne ekleme
o = Sürekli nesne eklemeyi durdur
x = Maps koordinat kaydetme
leftClick = nesne ekleme
rightClick = nesne değiştirme 

*/


ArrayList koordinatlar = new ArrayList();
int nesneSirasi = 1;
int sayac=0;
int nesneSayisi = 4;
int kaydirX = 0;
int kaydirY = 0;
PrintWriter output;
ArrayList Tehlikeliler = new ArrayList();

int xEksenTik, yEksenTik, xEksenMoved, yEksenMoved;


PImage img;
PImage[] resimler = new PImage[nesneSayisi];
ArrayList resimlerA = new ArrayList();
 
void setup(){
  size(800,600);
  output = createWriter("harita.txt"); 
  cursor(CROSS);
  
  for(int i = 0; i<nesneSayisi; i++)  {
    resimler[i] = loadImage("nesne"+(i+1)+".png");
  }
}

void draw(){
  
  background(155);

   for(int r = 0; r < 800; r+=50){
    line(r-800,r,width,r);
    fill(255);
    line(r,r-800,r,height);   
  
  }
  
  for(int i = 0; i<=koordinatlar.size() -3; i+= 3)
  {
    int geciciX = (Integer)koordinatlar.get(i);
    int geciciY = (Integer)koordinatlar.get(i+1);
    int geciciTip = (Integer)koordinatlar.get(i+2);
    
    image(resimler[geciciTip-1], geciciX-kaydirX, geciciY-kaydirY);
  }
    
    

}

void mouseMoved(){
   if(key == 'p'){    
    xEksenMoved = (mouseX+kaydirX)/50*50;
    yEksenMoved = (mouseY+kaydirY)/50*50;
    koordinatlar.add(xEksenMoved);
    koordinatlar.add(yEksenMoved);
    koordinatlar.add(nesneSirasi);
    //img = loadImage("nesne"+nesneSirasi+".png");
    image(resimler[nesneSirasi-1], xEksenMoved, yEksenMoved);
   }
}

    void mouseReleased(){
       
       if(mouseButton == RIGHT){
         if(nesneSirasi>=nesneSayisi){
           nesneSirasi = 1;
         }else{
           nesneSirasi++;
         }
         
         println(nesneSirasi);
      
       }
      
      
      
      if(mouseButton == LEFT){
      
      
      xEksenTik = (mouseX+kaydirX)/50*50;
      yEksenTik = (mouseY+kaydirY)/50*50;
      
      koordinatlar.add(xEksenTik);
      koordinatlar.add(yEksenTik);
      koordinatlar.add(nesneSirasi);
      img = loadImage("nesne"+nesneSirasi+".png");
       if(nesneSirasi == 1){
      Tehlikeliler.add(nesneSirasi);
      }
      
      sayac += 3;
      
       
      output.flush(); 
       
       
      }  
    }

/***********************************************/

    void keyPressed(){
    
        if(key == 'x' || key == 'X'){
            int uzunluk = koordinatlar.size();
            int cevir = (int)uzunluk;
          
            for(int o = 0; o < cevir ;o++){
              int kaydet = (Integer)koordinatlar.get(o);
              output.println(kaydet);    
            }
            
            output.close(); 
            
        }
        
        if(key == 'd') {
          kaydirX += 50;
        }
        if(key == 'a') {
          kaydirX -= 50;
        }
        if(key == 's') {
          kaydirY += 50;
        }
        if(key == 'w') {
          kaydirY -= 50;
        }          
      
    }


