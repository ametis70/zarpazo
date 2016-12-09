PImage comic;
int posX, posY;
float tamX, tamY;
void setup() {
  size(1368, 768);
  comic = loadImage("comic.png");
  tamX = 2345.268;
  tamY =  1612.02;
}

void draw() {
  background(0);
  image(comic, posX, posY, tamX, tamY);
  fill(255,0,0);
  textSize(50);
  text(posX, width/2, height/2);
  text(posY, width/2, height/2 + 100);
  text(tamX, width/2-300, height/2);
  text(tamY, width/2-300, height/2 + 100);
  text(mouseX, width/2-150, height/2+150);
  text(mouseY, width/2-150, height/2 + 250);

}

void keyPressed() {
  if (keyPressed) {
    if (keyCode == UP) {
      posY-=20;
    }
    if (keyCode == DOWN) {
      posY+=20;
    }
    if (keyCode == LEFT) {
      posX-=20;
    }

    if (keyCode == RIGHT) {
      posX+=20;
    }

    if (key == 's') {
      tamX = tamX * 1.2;
      tamY = tamY * 1.2;
    }
    if (key == 'a') {
      tamX = tamX / 1.1;
      tamY = tamY / 1.1;
    }
  }
}