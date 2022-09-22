package com.yorijori.project.dto;

public class YJDto {
	private String name;
	private String id;
	private String pw;
	private String email;
	private String phone;
	private String gender;
	private String auth;
	private String profileImage;
	private String nickName;
	private String birthday;
	
	public YJDto() {
		super();
	}

	public YJDto(String name, String id, String pw, String email, String phone, String gender, String auth) {
		super();
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.email = email;
		this.phone = phone;
		this.gender = gender;
		this.auth = auth;
	}

	public YJDto(String name, String id, String pw, String email, String phone, String gender, String auth,
			String profileImage, String nickName, String birthday) {
		super();
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.email = email;
		this.phone = phone;
		this.gender = gender;
		this.auth = auth;
		this.profileImage = profileImage;
		this.nickName = nickName;
		this.birthday = birthday;
	}

	public YJDto(String id, String profileImage, String nickName, String birthday) {
		this.id = id;
		this.profileImage = profileImage;
		this.nickName = nickName;
		this.birthday = birthday;
	}

	public YJDto(String id, String nickName, String birthday) {
		this.id = id;
		this.nickName = nickName;
		this.birthday = birthday;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
}