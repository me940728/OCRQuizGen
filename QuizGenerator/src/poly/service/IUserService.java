package poly.service;

import poly.dto.UserDTO;

public interface IUserService {

	UserDTO loginPost(UserDTO pDTO);

	int insertMember(UserDTO pDTO);

}
