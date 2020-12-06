package poly.controller;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import poly.service.IKakaoService;
import poly.service.IOcrService;
import poly.service.impl.KakaoService;

@Controller
public class KakaoLoginController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "KakaoService")
	private IKakaoService kakaoService;
	
    @RequestMapping("/login")
    public String home(@RequestParam(value = "code", required = false) String code) throws Exception{
        log.info("#########" + code);
        // 로그인 성공 후 엑세스 토큰을 받아야지 동의 화면으로 넘어간다 (인터페이스 거치는게 없어서 만듦)
        String access_Token = kakaoService.getAccessToken(code);
        HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
        
        log.info("###access_Token#### : " + access_Token);
        log.info("###userInfo#### : " + userInfo.get("email"));
        log.info("###nickname#### : " + userInfo.get("nickname"));
        log.info("###profile_image#### : " + userInfo.get("profile_image"));
        
        return "/kakaoLogin.do";
    }

	/*
	 * @Autowired private IKakaoService kakaoService = new KakaoService();
	 * 
	 * @RequestMapping(value="kakaoLogin.do", produces = "application/json", method
	 * = { RequestMethod.GET, RequestMethod.POST }) public String
	 * Login(@RequestParam("code") String code) throws Exception{
	 * 
	 * log.info(this.getClass().getName() + "Controller accesss_token : " );
	 * log.info(this.getClass().getName() + "##############CODE : " + code);
	 * 
	 * return "/kakaoLogin"; }
	 */
	}
