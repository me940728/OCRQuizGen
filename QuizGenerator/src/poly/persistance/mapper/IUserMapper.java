package poly.persistance.mapper;

import config.Mapper;
import poly.dto.UserDTO;

@Mapper("UserMapper")
public interface IUserMapper {

	int insertMember(UserDTO pDTO);

	UserDTO loginPost(UserDTO pDTO);
}
