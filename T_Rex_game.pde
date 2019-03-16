T_Rex tRex;
Surface sol;
int cpt2;
boolean start;
boolean jump;
boolean end;
AI AI;
int cpt;
int cptLearn = 0;

void setup() {
    size(1200, 400);
    init();
    AI = new AI();
}

void everythingDraw() {
    background(255);
    sol.draw(tRex);
    tRex.draw();
}


void init() {
    cpt = 0;
    start = true;
    jump = false;
    end = false;
    tRex = new T_Rex(100, 300);
    sol = new Surface(0, 333);
    cpt2 = 0;
    cptLearn = 0;
    everythingDraw();
}

void draw() {

    if (sol.trees.size() > 0) {
        double m1 = sol.trees.get(0).x - tRex.x;
        boolean result = AI.getEvaluation(m1);
        boolean correctAnswer = tRex.verif2(sol);
        if (!jump && result) {
            jump = true;
            tRex.jump();
        }

        if (!correctAnswer) {
            cptLearn++;
            if (cptLearn == 15) {
                AI.order(m1, 0);
                cptLearn = 0;
            }
        }


        if (correctAnswer)
            AI.order(m1, 1);



        if (end) {
            init();
        }
    }
    if (start) {

        cpt2++;
        if (cpt2 == 300) {
            cpt2 = 0;
            sol.rate += 1;

        }

        /* if (!jump)
         {
             jump = tRex.verif(sol);
         }*/




        if (sol.collision)
            end = true;
        sol.move();
        cpt++;
        if (cpt == 7 || jump) {
            jump = tRex.move();
            cpt = 0;
        }
        everythingDraw();
    } else if (end) {
        PImage endImg = loadImage("gameover.png");
        PImage restart = loadImage("restart.png");
        image(endImg, 504, 180, endImg.width, endImg.height);
        image(restart, 583, 195, restart.width, restart.height);
    }
}

void keyPressed() {
    if (key == ' ') {
        if (start && !jump && !end) {
            tRex.jump();
            jump = true;
        }
        start = true;
    }
}

void mousePressed() {
    if (mouseX > 583 && mouseX < 617 && mouseY > 195 && mouseY < 227) {
        init();
    }
}