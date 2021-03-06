package hello;

import java.util.concurrent.atomic.AtomicLong;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloWorldController {
    private static Logger logger = LoggerFactory.getLogger(HelloWorldController.class);

    private static final String template = "Hello, %s! ";
    private final AtomicLong counter = new AtomicLong();

    @GetMapping("/hello-world")
    @ResponseBody
    public Greeting sayHello(@RequestParam(name="name", required=false, defaultValue="Stranger") String name) {
        return new Greeting(counter.incrementAndGet(), String.format(template, name));
    }

    @GetMapping("/sayhi2")
    @ResponseBody
    public Greeting sayHi(@RequestParam(name = "name", required = false, defaultValue = "Stranger") String name) {
        logger.info("{} is comming, say hi to him/her", name);
        return new Greeting(counter.incrementAndGet(), String.format("Hi, %s ~~~", name));
    }
}
