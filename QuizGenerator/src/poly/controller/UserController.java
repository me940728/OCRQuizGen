package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.UserDTO;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;


@Controller
public class UserController {
	/*
	 * 비즈니스 로직(중료 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
	 */
	@Resource(name = "UserService")
	private IUserService userService;
	
	private Logger log = Logger.getLogger(this.getClass());
	
	// 회원 로그인을 위한 Login
	@RequestMapping(value = "/Login")
	public String login() {
		log.info("Login Start!");
			return "/kakaoLogin";
	}
	
	// 로그인 체크
			@RequestMapping(value = "/LoginPost.do", method = RequestMethod.POST)
			public String loginPost(HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
				log.info("#############################################");
				log.info("LoginPost Start!");

				String user_id = CmmUtil.nvl(EncryptUtil.encAES128CBC(request.getParameter("user_id")));
				String password = CmmUtil.nvl(EncryptUtil.encHashSHA256(request.getParameter("password")));

				log.info("user_id :" + user_id);
				log.info("pwd :" + password);

				UserDTO pDTO = new UserDTO();

				pDTO.setUser_id(user_id);
				pDTO.setPassword(password);

				pDTO = userService.loginPost(pDTO);
				log.info("pDTO null? : " + (pDTO == null));

				String msg = "";
				String url = "";

				// 로그인 안된
				if (pDTO == null) {

					msg = "로그인 실패";
					url = "/Login.do";

				} else { // 로그인된거
					log.info("pDTO.getEmail : " + pDTO.getEmail());
					log.info("pDTO.getPassword() : " + pDTO.getPassword());
					msg = "로그인 성공";

					String user_no = CmmUtil.nvl(pDTO.getUser_no());
					user_id = CmmUtil.nvl(pDTO.getUser_id());
					String userPassword = CmmUtil.nvl(pDTO.getPassword());

					log.info("user_no :" + user_no);
					log.info("user_id :" + user_id);
					log.info("userPassword :" + userPassword);

					// 세션에 올림
					session.setAttribute("user_no", user_no);
					// 닉네임을 표시해야 하기 때문에
					session.setAttribute("user_name", pDTO.getUser_name());
					session.setMaxInactiveInterval(60 * 30);

					log.info("session MaxTime : " + session.getMaxInactiveInterval());

					url = "/MainPage.do";
					
					if(user_no.equals("0")) {
						url = "/rootPage.do";
						}

					}

				log.info("session(user_no) : " + pDTO.getUser_no());

				model.addAttribute("msg", msg);
				model.addAttribute("url", url);

				pDTO = null;

				log.info("LoginPost end!");
				log.info("#############################################");
				return "/redirect";
			}
			
			// 로그아웃 처리 매퍼
			@RequestMapping(value = "user/userLogOut.do")
			public String logOut(HttpSession session, Model model) throws Exception {
				log.info(this.getClass() + "user/logOut start!!");

				String msg = "";
				String url = "";
				msg = "로그아웃 하시겠습니까?";
				url = "/Login.do";

				session.invalidate(); // 세션 정보 초기화

				model.addAttribute("msg", msg);
				model.addAttribute("url", url);

				log.info(this.getClass() + "user/loginOut end!!");

				return "/userLogout";
			}
			
			// 회원가입 입력화면
			@RequestMapping(value = "/insertMember")
			public String insertUserInfo() {
				log.info("insertUserInfo Start!");

				return "/UserRegForm";
			}
			
			// 회원가입 실행
			@RequestMapping(value = "/insertMemberProc", method = RequestMethod.POST)
			public String insertMember(HttpServletRequest request, ModelMap model) throws Exception {
				log.info("insertMember Start!");
				// jsp에서 입력값을 가져옴
				String user_id = CmmUtil.nvl(EncryptUtil.encAES128CBC(request.getParameter("user_id")));
				String password = CmmUtil.nvl(EncryptUtil.encHashSHA256(request.getParameter("password")));
				String email = CmmUtil.nvl(request.getParameter("email"));
				String user_name = CmmUtil.nvl(request.getParameter("user_name"));

				UserDTO pDTO = new UserDTO();

				// jsp에서 가져온 값을 저장
				pDTO.setEmail(email);
				pDTO.setPassword(password);
				pDTO.setUser_name(user_name);
				pDTO.setUser_id(user_id);

				log.info("email : " + email);
				log.info("password : " + password);
				log.info("user_id : " + user_id);
				log.info("user_name : " + user_name);

				// DB에 저장 및 저장이 되었는지 확인
				int res = userService.insertMember(pDTO);

				String msg = "";
				String url = "/Login.do";

				if (res > 0) {
						msg = "회원가입에 성공했습니다.";
					} else {
						msg = "회원가입에 실패했습니다.";
					}

				model.addAttribute("msg", msg);
				model.addAttribute("url", url);

				pDTO = null;

				log.info("insertUserInfo end!");
				return "/redirect";
			}


}
