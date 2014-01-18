/* YONLER
 0 -> Yukarı
 1 -> Asağı
 2 -> Sağa
 3-> Sola
 */



 import gifAnimation.*;

  

int sag = 1 ;
int y = 0;

boolean biKere = false;
boolean biKere2 = false;  
  
int tiklaZaman = 0;

PImage img_u;
PImage basla_u;
PImage cikis_u;
PImage survival_u,beyaz_u,snow,nasil,son;
int boyut_u = 16;
int kacinci_u = 0;
int frame_u = 0;
int hangi_resim_u = 0;
boolean noktalama_u = true;

boolean oyunaBasla = false;
PVector Gkaydir;


ArrayList Canavarlar = new ArrayList();

String[] Blocks;
int level = 1;
int gidilenLevel = 1;
PrintWriter output;
PImage[] img;
int kahramanin_ellidenFarki = 50;
PImage magaraback;

// Kütaphane - Ses
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim; // ses kütüphanesi
AudioSample menuClick; // anlık ses için, her ses için bir AudioSample
AudioSample topAtma;
AudioSample muzik;
AudioSample oyunLevelUp;
AudioSample canavarVurdu;

int muzikZaman;

//Ates[] toplar = new Ates[3];
ArrayList toplar = new ArrayList();
ArrayList son_toplar = new ArrayList();
PVector anag;

int top_sira;

Oyuncu kutu;

float global_yer_cekimi;

boolean bas;
boolean[] tuslar = new boolean[5];
int toplamLevelSayisi = 8;
boolean[] loaded = new boolean[toplamLevelSayisi];



void setup() {

  size(800,600);
  img_u = loadImage("images.jpg");
  basla_u = loadImage("basla.png");
  cikis_u = loadImage("cikis.png");
  survival_u = loadImage("survive.png");
  beyaz_u = loadImage("beyaz.png");
  magaraback = loadImage("arkaplan.jpg");
  snow = loadImage("snwmountain.jpg");
  nasil = loadImage("nasil.png");
  son = loadImage("son.png");
  background(img_u);
  smooth();

 
  Gkaydir = new PVector(0,0);
  //Gkaydir_eski = new PVector(0,0);
  

  

  minim=new Minim(this); // Ses Dosyası
  menuClick=minim.loadSample("click1.wav"); // ses yükleme
  topAtma = minim.loadSample("topAtma.wav");
  muzik = minim.loadSample("arka.mp3");
  oyunLevelUp = minim.loadSample("oyunDevam.wav");
  canavarVurdu = minim.loadSample("topdegdi.wav");
    muzik.trigger();
    muzikZaman = muzik.length() + millis();
    //smooth();

  bas = false;

  for (int i = 0; i < tuslar.length; i++) {
    tuslar[i] = false;
  }

  global_yer_cekimi = 3;
  
  kutu = new Oyuncu(200, 400, 50, 100, color(255, 0, 0), global_yer_cekimi,this,createImage(66, 66, RGB));
  PVector sifir_vektor = new PVector(0, 0);
  
  toplar.add( new Ates(sifir_vektor, kutu.konum.get(), 0, color(255,0,0)));
  toplar.add( new Ates(sifir_vektor, kutu.konum.get(), 90, color(0,255,0)));
  toplar.add( new Ates(sifir_vektor, kutu.konum.get(), 180, color(0,0,255)));



}



void yenidenBasla() {
  
///SIFIRLA

  toplar.clear();
  for(int i=0; i<loaded.length; i++) {
    loaded[i] = false;
  }
  level = 1;
  gidilenLevel = 1;
  
  top_sira = 0;
  
  Gkaydir = new PVector(0,0);
  
  
  

  kutu = new Oyuncu(200, 200, 50, 100, color(255, 0, 0), global_yer_cekimi,this,createImage(66, 66, RGB));

  PVector sifir_vektor = new PVector(0, 0);

  toplar.add( new Ates(sifir_vektor, kutu.konum.get(), 0, color(255,0,0)));
  toplar.add( new Ates(sifir_vektor, kutu.konum.get(), 90, color(0,255,0)));
  toplar.add( new Ates(sifir_vektor, kutu.konum.get(), 180, color(0,0,255)));  
  
}

void draw () {

  if(muzikZaman < millis()) {
    muzikZaman = millis() + muzik.length();
    muzik.trigger();
  }
    
  if(!oyunaBasla){
    
   // frame_u++;
    if(noktalama_u) {
      /*
      for(int i= 0 ; i < 200 ; i++) {
        randomNokta();
      }
      */   
      resimEfekt(img_u,50,boyut_u);
      
    imageMode(CENTER);
    image(basla_u,width/2,height/2);
    image(survival_u,width/2,height/2+100);
    image(cikis_u,width/2,height/2+200);
    
    if(tiklaZaman + 1500 > millis()) {
      
      image(nasil,width/2,height/2);
    }
    
    
     
    } 
      
    if(!noktalama_u) {
      resimEfekt(beyaz_u,100,25);
    }
  }else{
    
    imageMode(CORNER);
    
    if(level == 8) {
      if(!biKere) {
        //background(son);
        biKere = true;
      }
      resimEfekt(son,150,7);
      return;
    }
    
    
    background(magaraback);
    if(level > 4) background(snow);

    if (!loaded[level-1]) {
      levelYukle();
      if(level == 6) {
        toplar.add( new Ates(new PVector(0,0), kutu.konum.get(), 45, color(0,0,255)));
        toplar.add( new Ates(new PVector(0,0), kutu.konum.get(), 135, color(0,0,255)));
      }
      toplar.add( new Ates(new PVector(0,0), kutu.konum.get(), 270, color(0,0,255)));
    }
    if(toplar.size() == 0) {
      oyunaBasla = false;
      yenidenBasla() ;
      
    }
    nesneCizdir();
    int Bloklar = Blocks.length;
  
  
    kutu.yer = false;
    
    
    
////KAYDIR KONTROL

float kaydir;
  if(kutu.konum.x > 400) {
    kaydir = (kutu.konum.x - 400.0) / 100;
    kaydir = pow(kaydir,3) * 10;
    if(kaydir < 2) kaydir = 0;
    Gkaydir.x += kaydir;
      kaydir(-1*kaydir,true);
  }
  if(kutu.konum.x < 300) {
    //kaydir = int((500.0 / kutu.konum.x ) * 5);
    kaydir = (300 - kutu.konum.x) / 100;
    kaydir = pow(kaydir,3) * 10;
    if(kaydir < 2) kaydir = 0;
    Gkaydir.x -= kaydir;
      kaydir(kaydir,true);
  }
  float kaydiry;
  if(kutu.konum.y > 300) {
    kaydiry = (kutu.konum.y - 300.0) / 100;
    kaydiry = pow(kaydiry,3) * 10;
    if(kaydiry < 2) kaydiry = 0;
    Gkaydir.y += kaydiry;
      kaydir(-1*kaydiry, false);
  }
  if(kutu.konum.y < 200) {
    //kaydir = int((500.0 / kutu.konum.x ) * 5);
    kaydiry = (200 - kutu.konum.y) / 100;
    kaydiry = pow(kaydiry,3) * 10;
    if(kaydiry < 2) kaydiry = 0;
    Gkaydir.y -= kaydiry;
      kaydir(kaydiry, false);    
    
  } 
  
    
    for (int i=0; i<Bloklar; i += 3) {
      
      int x = int(Blocks[i]);
      int y= int(Blocks[i+1]);
      int tur = int(Blocks[i+2]);
      
     if(tur != 3){
      kutu.CarpismaKontrol(new PVector(x-Gkaydir.x, y-Gkaydir.y), new PVector(50,50), 1, new PVector(0,0));
      if(kutu.yerKontrol2()) {
        toplar.remove(0);
      }
 
      
      for(int j = 0; j < Canavarlar.size(); j++) {
        
        Oyuncu canavar = (Oyuncu)Canavarlar.get(j);
        canavar.CarpismaKontrol(new PVector(x-Gkaydir.x, y-Gkaydir.y), new PVector(50,50),5,new PVector(0,0) );

      }
     
    }
       

      
            
    }
 
    
    //kutu.kenarKontrol();
    //kutu.yerKontrol();
    //kutu.ivme.y += 1;
      
      
      kutu.kontrol();
      kutu.oynat();      
      
      for(int i = 0; i<Canavarlar.size(); i++) {
        Oyuncu canavar = (Oyuncu)Canavarlar.get(i);
        //canavar.CarpismaKontrol(new PVector(canavar.konum.x, canavar.konum.y), new PVector(50,50), 3);
        canavar.canavarKontrol(kutu.konum.x, kutu.konum.y);
        canavar.canavarGoster(Gkaydir);
        
        //Ates Kontrol
        for(int j=0; j<toplar.size(); j++) {
          Ates top = (Ates)toplar.get(j);
          if(canavar.atesKontrol(top.konum.get())) {
            if(Canavarlar.contains(canavar)) {
              Canavarlar.remove(i);
            }
            toplar.remove(j);
            canavarVurdu.trigger(); 
            //toplar = removeElement(toplar, j);
          }
        }
        
      }      
      
      
   
    for(int i = 0; i<toplar.size(); i++) {
      Ates top = (Ates)toplar.get(i);
      top.ana = kutu.konum.get();  
      top.guncelle();
      top.goster();
    }
    
    //outro
    if(level == 7) {
      if(!biKere2) {
        kutu.yer_cekimi = -0.5;
        for(int j=0; j<=800; j+=30) {
          son_toplar.add( new Ates(new PVector(j,550), new PVector(j, 550), j%360, color(0,0,255)));
        }
        biKere2 = true;
      }
      
      for(int i = 0; i<son_toplar.size(); i++) {
        Ates top = (Ates)son_toplar.get(i);
        //top.ana = kutu.konum.get(); 
        if(kutu.konum.y+Gkaydir.y < -1100) top.atesEt(kutu.konum);
        top.guncelle();
        top.goster();
      }
    }    
    tint(255,255);
  }
}


void levelYukle() {
  kutu.konum.x = 100;
  kutu.konum.y = 450;
  Blocks=loadStrings("map"+level+".txt");
  int Bloklar = Blocks.length;
  img = new PImage[Bloklar/3];
  Canavarlar.clear();
  for (int i=0; i<Bloklar/3; i++) {
    String nesneSirasi = Blocks[i*3+2];
    int x = int(Blocks[i*3]);
    int y= int(Blocks[i*3+1]);
    int nesneSiraCevir = int(nesneSirasi);
    if(nesneSiraCevir == 3){
      
      Canavarlar.add(new Oyuncu(x,y, 50, 60, color(255), global_yer_cekimi,this,loadImage("nesne"+nesneSirasi+".png")));
      println("yeah"+x+":"+y);
    }
    else {
      img[i] = loadImage("nesne"+nesneSirasi+".png");
    }
    //println(nesneSirasi);
    
   
  }
  loaded[level-1] = true;
}
/* YONLER
 0 -> Yukarı
 1 -> Asağı
 2 -> Sağa
 3-> Sola
 4-> Space
 */

void nesneCizdir() {
  int Bloklar = Blocks.length;
  for (int i=0; i<Bloklar; i += 3) {
    int s = int(Blocks[i]);
    int s1= int(Blocks[i+1]);
    String nesneSirasi = Blocks[i+2];
    int nesneSiraCevir = int(nesneSirasi);
    if(nesneSiraCevir != 3){
      image(img[i/3], s-Gkaydir.x, s1-Gkaydir.y);  
     
    }
    
    
    
    
  }
}






void keyPressed() {

  if (key == 'w') {
    tuslar[0] = true;
  }
  if (key == 's') {
    tuslar[1] = true;
  }
  if (key == 'd') {
    tuslar[2] = true;
  }
  if (key == 'a') {
    tuslar[3] = true;
  }
  if (key == ' ') {
    tuslar[4] = true;
  }    
  // kutu.ivme.normalize();
  // kutu.ivme.mult(0.7);
}

void keyReleased() {

  if (key == 'w') {
    tuslar[0] = false;
  }
  if (key == 's') {
    tuslar[1] = false;
  }
  if (key == 'd') {
    tuslar[2] = false;
  }
  if (key == 'a') {
    tuslar[3] = false;
  }
  if (key == ' ') {
    tuslar[4] = false;
  }
}


void mousePressed() {
 if(!oyunaBasla){
   if(((mouseX>(400-141)) && (mouseX < (400+141))) && ((mouseY>(300-47)) && (mouseY < (300+47)))) {
    oyunaBasla = true;
    menuClick.trigger();
   }
   
   if(((mouseX>(400-141)) && (mouseX < (400+141))) && ((mouseY>(400-47)) && (mouseY < (400+47)))) {
    tiklaZaman = millis();

   }
   
     if(((mouseX>(400-141)) && (mouseX < (400+141))) && ((mouseY>(500-47)) && (mouseY < (500+47))))  {
       menuClick.trigger();
   exit();
  }
  
 }else{
   topAtma.trigger();
  top_sira %= toplar.size();
  //println(top_sira);
  
  Ates top = (Ates)toplar.get(top_sira);
  top.atesEt(new PVector(mouseX, mouseY));


  top_sira++;
}
}  


void resimEfekt(PImage resim, float hiz, float yari_cap) {
  
  for(int i =0;i < hiz ; i++ ) {
    
    int x = int(random(resim.width));
    int y = int(random(resim.height));
    int loc = x + y*resim.width;
    
    // Look up the RGB color in the source image
    loadPixels();
    float r = red(resim.pixels[loc]);
    float g = green(resim.pixels[loc]);
    float b = blue(resim.pixels[loc]);
    noStroke();
    
    // Draw an ellipse at that location with that color
    fill(r,g,b,100);
    // Back to shapes! Instead of setting a pixel, we use the color from a pixel to draw a circle.
    ellipse(x,y,yari_cap,yari_cap); 
  }
}

void kaydir(float kaydir, boolean x_mi) {
  
  if(x_mi) {
    
    kutu.konum.x += kaydir;
    
      for(int i = 0; i<Canavarlar.size(); i++) {
        Oyuncu canavar = (Oyuncu)Canavarlar.get(i);

        canavar.konum.x += kaydir;
      }
  }
  else {

    kutu.konum.y += kaydir;
    
      for(int i = 0; i<Canavarlar.size(); i++) {
        Oyuncu canavar = (Oyuncu)Canavarlar.get(i);

        canavar.konum.y += kaydir;    
      }
  }
}

/*
public static ates[] atesYoket(ates[] gercek, ates bir_top){
    ates[] n = new ates[gercek.length - 1];
    System.arraycopy(gercek, 0, n, 0, bir_top );
    System.arraycopy(gercek, bir_top+1, n, bir_top, gercek.length - bir_top-1);
    return n;
}
*/

public static Ates[] removeElement(Ates[] original, int element){
    Ates[] n = new Ates[original.length - 1];
    System.arraycopy(original, 0, n, 0, element );
    System.arraycopy(original, element+1, n, element, original.length - element-1);
    return n;
}

