package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.UserDTO;
import poly.persistance.mapper.IUserMapper;
import poly.service.IUserService;

@Service("UserService")
public class UserService implements IUserService {
	
	@Resource(name = "UserMapper")
	IUserMapper userMapper;

	@Override
	public UserDTO loginPost(UserDTO pDTO) {
		// TODO Auto-generated method stub
		return userMapper.loginPost(pDTO);
	}

	@Override
	public int insertMember(UserDTO pDTO) {
		// TODO Auto-generated method stub
		return userMapper.insertMember(pDTO);
	}
	
}
