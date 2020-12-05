package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.QuizDTO;
import poly.persistance.mapper.IQuizMapper;
import poly.service.IQuizService;

@Service("QuizService")
public class QuizService implements IQuizService {
	
	@Resource(name = "QuizMapper")
	IQuizMapper quizMapper;
	
	@Override
	public int insertQuiz(QuizDTO qDTO) {
		return quizMapper.insertQuiz(qDTO);
	}

}
