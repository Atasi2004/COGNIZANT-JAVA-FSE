import java.io.*;
import java.net.*;

public class ChatServer {
    public static void main(String[] args) throws IOException {
        ServerSocket server = new ServerSocket(1234);
        Socket client = server.accept();
        BufferedReader in = new BufferedReader(new InputStreamReader(client.getInputStream()));
        PrintWriter out = new PrintWriter(client.getOutputStream(), true);

        out.println("Welcome to the server!");
        String line;
        while ((line = in.readLine()) != null) {
            System.out.println("Client: " + line);
        }

        client.close();
        server.close();
    }
}
