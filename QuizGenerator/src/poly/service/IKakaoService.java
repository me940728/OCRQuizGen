package poly.service;

import java.util.HashMap;

public interface IKakaoService {

	// JsonNode getAccessToken(String authorize_code);
	String  getAccessToken(String authorize_code);
    // 보안 토큰 성공 후 로그인 하면 정보 받아오는 메서드
	HashMap<String, Object> getUserInfo(String access_Token);
	
}
