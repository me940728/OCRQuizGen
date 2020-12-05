package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.CusQDTO;
import poly.persistance.mapper.ICusQMapper;
import poly.service.ICusQService;

@Service("CusQService")
public class CusQService implements ICusQService {
	
	@Resource(name = "CusQMapper")
	ICusQMapper cusQMapper;
	
	@Override
	public int insertCusQ(CusQDTO cDTO) {
		return cusQMapper.insertCusQ(cDTO);
	}

}
