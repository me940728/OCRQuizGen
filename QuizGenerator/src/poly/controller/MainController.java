package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="index")
	public String Index() {
		log.info(this.getClass());
		
		return "/index";
	}
	// 메인페이지 접속
	@RequestMapping(value="/main/mainPage.do")
	public String Main() {
		log.info(this.getClass()+ "메인접속");
		
		return "/main/mainPage";
	}
	// 마이페이지 젒속
	@RequestMapping(value="/main/MyPage.do")
	public String MyPage() {
		log.info(this.getClass()+ "게임화면 접속");
		
		return "/main/myPage";
	}
	// 게임페이지 접속		
	@RequestMapping(value="/main/StudyGame.do")
	public String Game() {
		log.info(this.getClass()+ "게임화면 접속");
		return "/main/StudyGame";
	}

	
}
