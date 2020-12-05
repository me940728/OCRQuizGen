package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.CusQDTO;
import poly.dto.QuizDTO;
import poly.service.ICusQService;
import poly.service.IQuizService;

@Controller
public class CusQController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "CusQService")
	private ICusQService cusQService;

	@Resource(name = "QuizService")
	private IQuizService quizService;

	@RequestMapping(value = "img/img/enrollment", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String quizenrollment(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		request.setCharacterEncoding("euc-kr");

		log.info(this.getClass().getName() + ".quizenrollment start!");

		// 현재 유저 번호 가져와서 DB에 저장하는 것
		// 임시로 아이디 유저번호 저장
		String id = "test";
		int userno = 1;
		
		String editImgSrc = request.getParameter("editImgSrc");
		//log.info("########문제 이미지 : " + editImgSrc);
		
		// 임시 퀴즈 번호
		int quizid = 1;
		
		QuizDTO qDTO = new QuizDTO();
		
		qDTO.setId(id);
		qDTO.setFk_user_no(userno);
		qDTO.setQ_pic(editImgSrc);
		int resQ=0;
		if (editImgSrc != null && !editImgSrc.equals("")) 
			resQ = quizService.insertQuiz(qDTO);
		int resC = 0;
		
		log.info("#########resQ : " + resQ);
		log.info("#########id : " + id);
		qDTO = null;
		
		CusQDTO cDTO = new CusQDTO();
		
		cDTO.setId(id);
		cDTO.setFk_q_id(quizid);
		cDTO.setFk_user_no(userno);
		
		for (int cnt = 1; cnt <= 5; cnt++) {
			
			log.info("########지금 카운트 : " + cnt);
			String answercnt = "answer_0" + cnt;
			String answer = request.getParameter(answercnt);
			log.info("########자른 이미지 OCR : " + answer);
			
			String cropImgSrc = request.getParameter("cropImgSrc0" + cnt);
			log.info("########자른 이미지 : " + cropImgSrc);

			if (cropImgSrc == null || cropImgSrc.equals(""))
				continue;
			
			cDTO.setCq_ans(answer);
			cDTO.setCq_pic(cropImgSrc);
			
			resC += cusQService.insertCusQ(cDTO);
			
		}
		
		cDTO = null;
		
		String msg;
		String url = "/img/img.do";
		
		if (resQ > 0 && resC > 0) {
			msg = "저장되었습니다.";
		} else {
			msg = "저장이 실패했습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass().getName() + ".quizenrollment end!");

		return "/redirect";
	}

}
