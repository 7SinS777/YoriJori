package com.yorijori.project.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJDto;

public class CustomUserDetailService implements UserDetailsService {

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		YJDao ydao = YJConstant.ydao;
		YJDto dto = ydao.login(username);
		if(dto == null) {
			System.out.println("dto is null");
			throw new UsernameNotFoundException("No user found with username");
		}
		String pw = dto.getPw();
		String auth = dto.getAuth();
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		roles.add(new SimpleGrantedAuthority(auth));
		
		UserDetails user = new User(username, pw, roles);
		return user;
	}

}
