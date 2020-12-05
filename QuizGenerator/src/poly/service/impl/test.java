package poly.service.impl;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import net.sourceforge.tess4j.ITesseract;
import net.sourceforge.tess4j.Tesseract;

public class test {
	public test() {
		String base64 = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD/wAARCAAYADEDASIAAhEBAxEB/8QAGwABAAIDAQEAAAAAAAAAAAAAAAUHAQIGCAn/xAAtEAACAgEDAwIFAwUAAAAAAAABAgMEBQAGEQcSIRMxFBUiUYEIMkFCYXFy8f/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD6lmwEAD8LyhYkngDj3/H99bCQmQIeBzz44+3/AHVb7/p4nB3K24rE+55PnmSo4SaGjnLEEVczSCFJFhDhBw7qGKgHgkn21p0nw+4cLlt9T5bM5W7jre5D8ggyFqSw8FCKlVikUM5L8NajtsOefBAA8DQWS00nJVUUn+n93H5IHjWBaA8uR2t3EH29vf8AA+515x61RZ/cFWLG7epPtCPdV5aDZ2/YsNO0jK3EdZIQ4qhwrr683aVJULExYMtqbHizW29n/J8vtWegMFVjjgMGWOVa4qKeeyR1jlkl8EEyIpLMOAw50Hbtd9MMZVVAg7ie7kccc/48DWMZlKeXrR3cfPFPXlXvjljkV1deeAwKkgg8H+dUHtmr1Vi6h7ozMc2E9bdSVYZ6KTm/Htda8UjRi5XEsRmM4kctIjKQyona4HcvZfpfxuRxPRnCUclCIZYZsgoiWH0lRPjpygVe5uF7O3gcnxxzoLX0000HBTdD+j9rJ2czZ6b7flvXHMliw9FGeVyQ3cSRyTzwfvqVxnTrYW3rkmQwu08XRs2Y2gkkgrqjyIfJQkfwSAfxppoIlehnSRyDZ2Bh7JWX11+IriUxyAnhlLc8Ec6ksB062Hsie5f2ltHFYm1kWjWzJVgEbTFT9HcR5IBb8cnTTQR0fTfFxbsyu+MJkbmHy2eo1KN+emkDGzFWMrViyyxsiugsyjlR9Q7ef2gDptuYqxg6EeNt5vIZZ4wT8VeSBZWBPsRDHGnj/XTTQS+mmmg//9k=" + "'";
		if(decoder(base64, "E:/picture/test1.jpg"))
			System.out.println("성공");
		else
			System.out.println("실패");
	}
	
	public static boolean decoder(String base64, String target){
		int start = base64.indexOf(",");
		String str = base64.substring(start+1, base64.length());
		int end = str.indexOf("'");
		String result = str.substring(0, end);
		byte[] imageBytes = DatatypeConverter.parseBase64Binary(result);

		try {
				BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
				ImageIO.write(bufImg, "jpg", new File(target));
				return true;
		} catch (IOException e) {
			return false;
		}
	}
	

	public static String process(String fileName) throws Exception {
		

		//File imageFile = new File(CmmUtil.nvl(pDTO.getFilePath()) + "//" + CmmUtil.nvl(pDTO.getFileName()));
		File inputFile = new File(fileName);
		//File imageFile = new File("blob:http://127.0.0.1:5500/0077811c-328f-471a-82cd-98f6bded1155");
		
		// OCR 기술 사용을 위한 Tesseract 플랫폼 객체 생성
		ITesseract instance = new Tesseract();
		
		// OCR 분석에 필요한 기준 데이터(이미 각 나라의 언어별로 학습시킨 데이터 위치 폴더)
		// 저장 경로는 물리경로를 사용함(전체 경로)
		instance.setDatapath("E:\\ocrdata");
		
		// 한국어 학습 데이터 선택(기본 값은 영어)
		 instance.setLanguage("kor"); // 한국어 설정
		// instance.setLanguage("eng"); // 영어 설정
		
		// 이미지 파일로부터 텍스트 읽기
		String result = instance.doOCR(inputFile);
		
		return result;
	}
	
	public static void main(String[] args) throws Exception {
		 new test();
		 System.out.println(process("E:\\picture/test1.jpg"));
	}
}
