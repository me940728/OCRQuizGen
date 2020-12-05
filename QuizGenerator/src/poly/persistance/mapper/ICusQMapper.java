package poly.persistance.mapper;

import config.Mapper;
import poly.dto.CusQDTO;

@Mapper("CusQMapper")
public interface ICusQMapper {
	
	int insertCusQ(CusQDTO cDTO);
}
