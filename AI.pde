class AI {

    double w1;
    double b;
    AI() {
        w1 = random(0, 1);
        b = random(0, 1);
    }

    double segmoid(double x) {
        return (1 / (1 + Math.exp(-x)));
    }

    boolean getEvaluation(double m1) {

        m1 = m1 / 500;

        double z = w1 * m1 + b;
        z = segmoid(z);

        return (z > 0.5);
    }

    void order(double m1, double y) {
        m1 = m1 / 500;
        double learning_rate = 0.01;

        double guess = segmoid(m1 * w1 + b);
        double error = y - guess;
        System.out.println(guess + "  " + y);


        w1 = w1 + (error * m1) * learning_rate;
        b = b + error * learning_rate;
    }
}