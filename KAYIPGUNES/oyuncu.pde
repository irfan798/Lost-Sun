  import gifAnimation.*;
class Oyuncu {
  

  int sag = 1 ;
  PApplet baba;


    
    
  PImage zipla;
  Gif sagaelf;
  Gif solaelf;
  Gif oyuncu_resim;
  boolean pause = true;

  PVector konum;
  PVector gercek_konum;
  PVector hiz;
  public PVector ivme;
  color renk;
  
  PVector v_assa;
  PVector v_saga;
  
  int en;
  int boy;
  
  boolean yer;
  
  float yer_cekimi;
  
  PImage canavarResim;

  
  
  Oyuncu (int x,int y, int en, int boy, color renk_ne, float yer_cekimi,PApplet baba, PImage canavarResim) {
    this.baba=baba;
    konum = new PVector(x,y);
    gercek_konum = new PVector(x,y);
    hiz = new PVector(0,0);
    ivme = new PVector(0,0);
    
    v_assa = new PVector(0,1);
    v_saga = new PVector(1,0);
    
    renk = renk_ne;
    
    this.en = en;
    this.boy = boy;
    
    yer = false;
    
    this.yer_cekimi = yer_cekimi;
    
    this.canavarResim = canavarResim;

  sagaelf = new Gif(baba, "gercekelf.gif");
  sagaelf.loop();
  solaelf = new Gif(baba, "terself.gif");
  //solaelf.play();
  zipla = loadImage("zipla.png"); 
 oyuncu_resim=sagaelf; 
    
    
  }
  
  void kontrol() {    
      
      if(tuslar[0]) {
        //ivme.sub(v_assa); //UST
        
      }
      if(tuslar[1]) {
        ivme.add(v_assa); //ALT
      }
      if(tuslar[2]) {
        ivme.add(v_saga); //SAG
        oyuncu_resim=sagaelf;
        //sagaelf.play();
        
      } else {
        sagaelf.stop();
      }
      if(tuslar[3]) {
        ivme.sub(v_saga); //SOL
        oyuncu_resim=solaelf;
      } else {
        solaelf.stop();
      }
      if(tuslar[4]) {
        if(yer) {
         ivme.add(new PVector(0, -30)); //ZIPLA
         ivme.mult(1.75);
        }     
      }
      /*
      if(!(tuslar[0] || tuslar[1] || tuslar[4])) {
         ivme.mult(new PVector(1,0) );
         //ivme.y += 1;
      }
      */
      /*if(!(tuslar[2] || tuslar[3])) {
         ivme.mult(new PVector(0,1) );
      }
      */

        
    //ivme.mult(0.7);
    ivme.mult(0.5);
      
    
  }
  
  boolean yerKontrol2() {
    if(konum.y+boy+Gkaydir.y >= 800) {
          Gkaydir.x = 0;
          Gkaydir.y = 0;
          
          kutu.konum.x = 100;
          kutu.konum.y = 450;
          return true;
    }
    return false;
  }
  
  
    boolean CarpismaKontrol(PVector obje_konum, PVector obje_buyukluk, int Carpilan, PVector kaydir) {
      //&& (konum.x+en >= obje_konum.x) && (konum.x <= obje_konum.x+obje_buyukluk.x)
      kaydir = new PVector(0,0);
      


/*
      //if( ((konum.y+boy >= obje_konum.y) && (konum.y+boy <= obje_konum.y + obje_buyukluk.y)) && ((konum.x <= obje_konum.x+obje_buyukluk.x ) && (konum.x+en >obje_konum.x+obje_buyukluk.x)) ) {
        if( (konum.x+en >= obje_konum.x - 1) && (konum.x < obje_konum.x - 1)  ) {        
        //hiz.x *= -1;
        ivme.x = 0;
        konum.x = obje_konum.x - en;
        hiz.x = 0;
        
        println("sol kenar");
      }
     
     

          if( (konum.x <= obje_konum.x + obje_buyukluk.x - 1) && (konum.x + en > obje_konum.x + obje_buyukluk.x) ) {
         
         
        //hiz.x *= -1;
        ivme.x = 0;
        konum.x = obje_konum.x + obje_buyukluk.x;
        hiz.x = 0;
        
        println("sag kenar");
      }
   
*/

      //KENAR CARPMA
      if((konum.y+boy >= obje_konum.y + obje_buyukluk.y - 10) && (konum.y +10  <= obje_konum.y) && (konum.x+en >= obje_konum.x) && (konum.x <= obje_konum.x+obje_buyukluk.x ) ) {
        hiz.x *= -1.2;
        ivme.x *= -1.2;
      }
  




 
      //if((konum.y-kaydir.y+boy >= obje_konum.y) && !(konum.y-kaydir.y > obje_konum.y + obje_buyukluk.y ) && (konum.x+en-kaydir.x >= obje_konum.x) && (konum.x-kaydir.x <= obje_konum.x+obje_buyukluk.x )) {
      //if((konum.y+boy >= obje_konum.y) && (konum.y <= obje_konum.y - obje_buyukluk.y ) && (konum.x+en >= obje_konum.x) && (konum.x <= obje_konum.x+obje_buyukluk.x )) {
        if( (obje_konum.x <= konum.x+en/2) && (konum.x+en/2 <= obje_konum.x+obje_buyukluk.x) &&
            (obje_konum.y + obje_buyukluk.y >= konum.y + boy) && ( konum.y + boy >= obje_konum.y ) && ( konum.y < obje_konum.y) ) {



        yer = true;
        if(Carpilan == 2) {
          //println("yerde:"+ konum.x + " : " + konum.y);
          //println("bes");
          //println(konum.x + " : " + konum.y);
          //println("yerde: "+ konum.x + " : " + konum.y);


        }
        
          println("x: "+(obje_konum.x + Gkaydir.x) + "y: " + (obje_konum.y + Gkaydir.y));
          konum.y = obje_konum.y - boy;
          hiz.y = 0;
        
      }
      else {
        // yer = false;
      }
      
      if( (konum.y+kaydir.y <= obje_konum.y + obje_buyukluk.y) && (konum.y+kaydir.y > obje_konum.y) && (konum.x+kaydir.x+en >= obje_konum.x) && (konum.x+kaydir.x <= obje_konum.x+obje_buyukluk.x ) ) {
        if(hiz.y < 0) {
          //println("yukari");
          hiz.y = 0;
          ivme.y *= -1;
        }
      }

      return false;      

    }
    
    void oynat() {

      hiz.add(ivme);
      hiz.mult(0.9);
       //YERCEKIMI
      if(!yer) {
        hiz.y += yer_cekimi;
      }
      konum.add(hiz);
      
      //fill(renk);
      //rect(konum.x, konum.y, en, boy);
      oyuncu_resim.play();
      image(oyuncu_resim, konum.x, konum.y);
           
      
    }
    void konumDesgisir(PVector kaydir) {
      konum.sub(kaydir);
    }
    
    void canavarKontrol(float oyuncuX, float oyuncuY) {
      
      if((abs(oyuncuX - konum.x) <= 200) && (abs(oyuncuY - konum.y) <= 100))
      {
        if(konum.x-oyuncuX > 0) {
          hiz.x = -2;
        }
        else if(konum.x - oyuncuX < 0) {
          hiz.x = 2;
        }        
          
      }
      else {
          hiz.x = 0;
        }
           
    }
    
    void canavarGoster(PVector kaydir) {

      hiz.add(ivme);
      hiz.mult(0.9);
      hiz.y += yer_cekimi;//YERCEKIMI
      konum.add(hiz);
      //konum.x = gercek_konum.x-kaydir.x;
      //konum.y = gercek_konum.y-kaydir.y;
      
      //fill(renk);
      //rect(konum.x, konum.y, en, boy);
      image(canavarResim, konum.x, konum.y+10);
           
    }
    
    boolean atesKontrol(PVector ates_konum) {
      PVector fark = PVector.sub(konum, ates_konum);
      if(fark.mag() < 50) {
        println("patla");
        return true;
      } else {
        return false;
      }
    }
    
  void kenarKontrol() {

    if (konum.x > width) {
      konum.x = 0;
    } else if (konum.x < 0) {
      konum.x = width;
    }
    
    if (konum.y > height) {
      konum.y = 0;
    } else if (konum.y < 0) {
      konum.y = height;
    }

  }     
}

