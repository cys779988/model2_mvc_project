package svc;

import java.util.List;

import dao.MemberDAO;
import vo.MemberVO;

public class MemberService {
	MemberDAO dao = new MemberDAO();
	public int loginCheck(String empNo, String pwd){
		int check = dao.loginCheck(empNo, pwd);
		return check;
	}

	public MemberVO login(String empNo, String pwd){
		MemberVO member = dao.employLogin(empNo, pwd);
		return member;
	}
	
	public void regist(MemberVO member){
		String pwd = member.getPwd();
		String birth = member.getBirth();
		String addr = member.getAddr();
		String phone = member.getPhone();
		String tel = member.getTel();
		String email = member.getEmail();
		String admin = member.getEmail();
		if(pwd == null || pwd == "") {
			pwd="1111";
		}
		if(birth == null || birth == "") {
			birth="정보없음";
		}
		if(addr == null || addr == "") {
			addr="정보없음";
		}
		if(phone == null || phone == "") {
			phone="정보없음";
		}
		if(tel == null || tel == "") {
			tel="정보없음";
		}
		if(email == null || email == "") {
			email="정보없음";
		}
		if(admin == null || admin == "") {
			admin="AUTH_NORMAL";
		}
		member.setPwd(pwd);
		member.setBirth(birth);
		member.setAddr(addr);
		member.setPhone(phone);
		member.setTel(tel);
		member.setEmail(email);
		member.setAdmin(admin);
		dao.insertEmploy(member);
	}

	public List list(String search_name, String search_empNo, String search_dept) {
		List member = dao.searchEmployList(search_name, search_empNo, search_dept);
		return member;
	}

	public MemberVO detailList(String empNo) {
		MemberVO member = dao.selectEmployDetailList(empNo);
		return member;
	}

	public void update(MemberVO member) {
		dao.updateEmploy(member);
	}

	public void delete(String empNo) {
		dao.delEmploy(empNo);
	}

	public int confirmId(String empNo) {
		// TODO Auto-generated method stub
		int check = dao.confirmId(empNo);
		return check;
	}
}
