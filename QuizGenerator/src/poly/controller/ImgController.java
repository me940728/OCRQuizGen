package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.OcrDTO;
import poly.service.IOcrService;
import poly.service.impl.OcrService;

@Controller
public class ImgController {
	private Logger log = Logger.getLogger(this.getClass());
	public static int ccnt = 77;
	public static String value="";
	@Resource(name = "OcrService")
	private IOcrService ocrService;
	
	@RequestMapping(value = "img/img")
	public String imgimg(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, OcrDTO pDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".imgimg start!");
		log.info(this.getClass().getName() + ".imgimg end!");
		
		return "/img/img";
		
	}
	
	@RequestMapping(value = "img/img2", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String imgimg2(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, OcrDTO pDTO) throws Exception {
		
		
		log.info(this.getClass().getName() + ".imgimg2 start!");
		
		if(pDTO.getBase64() != null) {
			String ba64 = pDTO.getBase64();
			String name = "E:/picture/test" + ccnt;
			boolean lang = pDTO.isLang();
			ccnt++;
			log.info(ba64+"@@@@@@@@@@@@@");
			log.info(name+"@@@@@@@@@@@@@");
			log.info(lang+"@@@@@@@@@@@@@");
			new OcrService(ba64, name);

			value = OcrService.process(name, lang);

			log.info(value+"원본");
			value = value.trim();
			log.info(value+"오왼삭제");
			value = value.replaceAll(" ", "");
			log.info(value+"교체");

			
		}

		log.info(value+"최종");
		log.info(this.getClass().getName() + ".imgimg2 end!");
		
		return value;
		
	}

}
