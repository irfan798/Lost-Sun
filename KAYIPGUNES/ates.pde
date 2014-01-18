
//Anayi hep oyuncuya esitle

//NOT: Bugun persembe bu saaten sonra cozume giden en iyi kod değil en kısa kod mübahtır
class Ates {
  
  //Geri döndüğü yer
  PVector konum, hiz, ivme, hedef, ana;
  float limit_hiz, yari_cap, aci, top_boyut;
  
  PVector[] izler = new PVector[6];
  
  color renk;
  
  boolean hedefe_gidiyor, geliyor, donuyor;
  
  PImage ates_resim;
  
  
  Ates(PVector konum, PVector ana, float aci_fark, color renk) {
    
    this.konum = konum.get(); 
    this.ana = ana.get();
    this.renk = renk;

    top_boyut = 40;
    
    hiz = new PVector(0,0);
    ivme = new PVector(0,0);
    //hedef = new PVector(0,0);
    
    limit_hiz = 12;
    aci = aci_fark;
    yari_cap = 40;
    
    
    hedefe_gidiyor = false;
    geliyor = false;
    donuyor = true;
    
    ates_resim = loadImage("ates.png");
    
    for(int i = 0; i<izler.length; i++) {
      izler[i] = konum.get();
    }
    

    
    
  }


  
  void guncelle() {
    
    //ana = kafa;
    
 int Bloklar = Blocks.length;
    for(int kml = 0; kml < Bloklar; kml +=3){
      float nesneXkoor = Float.parseFloat(Blocks[kml]);
      float nesneYkoor = Float.parseFloat(Blocks[kml+1]);
      float nesneTuru = Float.parseFloat(Blocks[kml+2]);
      
      if(nesneTuru == 3){
     
        float KontrolYapiliyor = dist(konum.x,konum.y,nesneXkoor,nesneYkoor);
       
       if(KontrolYapiliyor < 50){
      String remove_1 = (String)Blocks[kml];
      String remove_2 = (String)Blocks[kml+1];
      String remove_3 = (String)Blocks[kml+2];
      
       }
       
      
        
      }
      if(nesneTuru == 4){
        
        float KontrolYapiliyor = dist(konum.x+Gkaydir.x,konum.y+Gkaydir.y,nesneXkoor,nesneYkoor);
       
       if(KontrolYapiliyor < 50){
          level++;
          Gkaydir.x = 0;
          Gkaydir.y = 0;
          
          kutu.konum.x = 100;
          kutu.konum.y = 0;
          
       }
      
      }
    }
    //Hedefe tıklanmıssa
    if(hedefe_gidiyor) {
      donuyor = false;
      PVector fark = PVector.sub(hedef, konum);
      
      //Farkı bir pixel yap
      fark.normalize();
      //Farkı carpanla carp
      fark.mult(0.5);
      
      ivme = fark;
   
   
      if(PVector.sub(hedef, konum).mag() <= hiz.mag()*5 + 6 ) {
          //hedef = ana.get();
          geliyor = true;
          hedefe_gidiyor = false;      
        } 
       
    }
    
    if(geliyor) {
      
      donuyor = false;
      PVector fark = PVector.sub(ana, konum);
      
      //Farkı bir pixel yap
      fark.normalize();
      //Farkı carpanla carp
      fark.mult(0.5);
      
      ivme = fark;
      
    }
    
      
      //Hem geri geliyor hem de donme konumuna geldiyse
      if(geliyor && (PVector.sub(ana, konum).mag() <= yari_cap + 2)) {
        
        geliyor = false;
        hedefe_gidiyor = false;
        donuyor = true;
        
        //İvme ve hiz sıfırla
        ivme = new PVector(0,0);
        hiz = new PVector(0,0);
        
        //aci
        PVector sifir_aci = new PVector(yari_cap,0);
        PVector aci_vektor = PVector.sub(konum,ana);
        

        
        //Gelen açı radyan cinsiden dönüştür
        
        float radyan = PVector.angleBetween(sifir_aci,aci_vektor);
        aci = degrees(radyan);
        
        PVector fark_vektor = PVector.sub(sifir_aci, aci_vektor);
        if(fark_vektor.y > 0) {
          //println("ters");
          aci = -1*aci;
        }
        
//println(radyan);
        
        
        
      }
      
      hiz.add(ivme);
      hiz.limit(limit_hiz);
      
      //Surtunme
      hiz.mult(0.99);
      
      konum.add(hiz);
                
      if(donuyor) {
        PVector eski_konum = konum.get();
        //println("donuyor");
        konum = this.noktaEtrafindaDon(ana.x,ana.y,yari_cap,10);
        hiz = PVector.sub(konum,eski_konum);
        hiz.mult(1);
   
            
      }
      
      //izler
      for(int i = 0; i<izler.length-1; i++) {
        izler[i] = izler[i+1].get();
      }
      
      // Son nokta
      izler[izler.length-1] = konum.get();      
      
                              

  }
  
  void atesEt(PVector hedef) {
    if(donuyor) {
      this.hedef = hedef.get();
      hedefe_gidiyor = true;   
    } 
  }
  
  void goster() {
    stroke(0);   
    //fill(renk);
    //ellipse(konum.x,konum.y,16,16);
    for(int i = 0; i<izler.length-1; i++) {
      tint(255, i*50+50);
      image(ates_resim, izler[i].x, izler[i].y, top_boyut, top_boyut);
    }    
    
    //image(ates_resim, izler[4].x, izler[4].y, top_boyut, top_boyut);
  }
   
 
 

    
  PVector noktaEtrafindaDon(float nx,float ny,float yari_cap,float hiz) {
    
    float px = nx + cos(radians(aci))*yari_cap;
    float py = ny + sin(radians(aci))*yari_cap;
    
    float cevre = 2*yari_cap*3.14;
    float artis = cevre * hiz / 360;
    
  
  
    aci += artis;
  
    aci = (aci + 360) % 360;
    //aci = 90; 
    
   
   return new PVector(px, py);
  } 
    
}
        

