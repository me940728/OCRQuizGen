package poly.persistance.mapper;

import config.Mapper;
import poly.dto.DummyDTO;

@Mapper("DummyMapper")
public interface IDummyMapper {

	DummyDTO getDummyList() throws Exception;
}
