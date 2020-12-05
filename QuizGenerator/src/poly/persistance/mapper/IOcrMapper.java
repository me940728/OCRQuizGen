package poly.persistance.mapper;

import config.Mapper;
import poly.dto.OcrDTO;

@Mapper("OcrMapper")
public interface IOcrMapper {
	
	//수집된 내용 DB에 등록
		int InsertOcrInfo(OcrDTO pDTO) throws Exception;
}
