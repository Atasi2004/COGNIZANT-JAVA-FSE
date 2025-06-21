interface Playable{
    void play();
}
class Guitar implements Playable{
    @Override
    public void play() {
        System.out.println("Playing guitar");
    }
}
public class interfaceImplementation {
    public static void main(String[] args) {
        Playable p1 = new Guitar();
        p1.play();
    }
}
