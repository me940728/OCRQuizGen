package poly.persistance.mapper;

import config.Mapper;
import poly.dto.QuizDTO;

@Mapper("QuizMapper")
public interface IQuizMapper {
	
	int insertQuiz(QuizDTO qDTO);
}
