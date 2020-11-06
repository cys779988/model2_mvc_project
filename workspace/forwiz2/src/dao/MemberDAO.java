package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import vo.MemberVO;

public class MemberDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;

	public MemberDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
/*	public List<MemberVO> selectEmployList() throws Exception{
		List<MemberVO> memberlist = new ArrayList<MemberVO>();
		try {
			con = dataFactory.getConnection();
			String query = "SELECT USER_EMPNO, USER_NAME, USER_BIRTH, USER_JOINDT, USER_PHONE, B.DEPT_NAME, C.POS_NAME"
					+ " FROM FORWIZ_USER_TB A"
					+ " LEFT JOIN FORWIZ_DEPT_TB B ON B.DEPT_CODE = A.DEPT_CODE"
					+ " LEFT JOIN FORWIZ_POSITION_TB C ON C.POS_CODE = A.POS_CODE"
					+ " WHERE 1=1";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				
				String empNo = rs.getString("user_empNo");
				String name = rs.getString("user_name");
				String birth = rs.getString("user_birth");
				String joinDate = rs.getString("user_joinDT");
				String phone = rs.getString("user_phone");
				String dept = rs.getString("dept_name");
				String position = rs.getString("pos_name");
				MemberVO vo = new MemberVO();

				vo.setEmpNo(empNo);
				vo.setName(name);
				vo.setBirth(birth);
				vo.setJoinDate(joinDate);
				vo.setPhone(phone);
				vo.setDept(dept);
				vo.setPosition(position);
				memberlist.add(vo);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberlist;
	}*/
	
	public List<MemberVO> searchEmployList(String search_name, String search_empNo, String search_dept){
		List<MemberVO> memberlist = new ArrayList<MemberVO>();
		int cnt = 0;
		try {
			con = dataFactory.getConnection();
			String query = "SELECT A.USER_EMPNO, A.USER_NAME, A.USER_BIRTH, A.USER_JOINDT, A.USER_PHONE, B.DEPT_NAME, C.POS_NAME"
					+ " FROM FORWIZ_USER_TB A"
					+ " LEFT JOIN FORWIZ_DEPT_TB B ON B.DEPT_CODE = A.DEPT_CODE"
					+ " LEFT JOIN FORWIZ_POSITION_TB C ON C.POS_CODE = A.POS_CODE"
					+ " WHERE 1=1";
			
			if(search_name != null && search_name!="")
				query += " AND A.USER_NAME LIKE '%' || ? || '%'";
			if(search_empNo != null && search_empNo!="")	
				query += " AND A.USER_EMPNO LIKE '%' || ? || '%'";
			if(search_dept != null && search_dept!="")
				query += " AND A.DEPT_CODE LIKE '%' || ? || '%'";

			pstmt = con.prepareStatement(query);
			
			if(search_name!=null && search_name!="") {
				pstmt.setString(++cnt, search_name);
				System.out.println("name : "+search_name);
				System.out.println("이름검색");
			}
			if(search_empNo!=null && search_empNo!="") {
				pstmt.setString(++cnt, search_empNo);
				System.out.println("사원번호검색");
			}
			if(search_dept!=null && search_dept!="") {
				pstmt.setString(++cnt, search_dept);
				System.out.println("부서검색");
			}
			System.out.println("prepareStatememt: " + query);
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberVO vo = new MemberVO();
				
				String empNo = rs.getString("USER_EMPNO");
				String name = rs.getString("USER_NAME");
				String birth = rs.getString("USER_BIRTH");
				String joinDate = rs.getString("USER_JOINDT");
				String phone = rs.getString("USER_PHONE");
				String dept = rs.getString("DEPT_NAME");
				String position = rs.getString("POS_NAME");
				
				vo.setEmpNo(empNo);
				vo.setName(name);
				vo.setBirth(birth);
				vo.setJoinDate(joinDate);
				vo.setPhone(phone);
				vo.setDept(dept);
				vo.setPosition(position);
				memberlist.add(vo);
				
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberlist;
	}


	public MemberVO selectEmployDetailList(String empNo){
		MemberVO vo = new MemberVO();
		try {
			con = dataFactory.getConnection();
			String query = "SELECT USER_EMPNO, USER_NAME, USER_ADDR, USER_BIRTH, USER_JOINDT, B.C_NAME USER_GEN, USER_JOINDT, USER_PHONE, USER_TEL, C.DEPT_NAME, D.POS_NAME, USER_EMAIL, E.C_CODE USER_ADMIN"
					+ " FROM FORWIZ_USER_TB A"
					+ " LEFT JOIN FORWIZ_COMMONCODE_TB B ON B.C_CODE = A.GEN_CODE"
					+ " LEFT JOIN FORWIZ_DEPT_TB C ON C.DEPT_CODE = A.DEPT_CODE"
					+ " LEFT JOIN FORWIZ_POSITION_TB D ON D.POS_CODE = A.POS_CODE"
					+ " LEFT JOIN FORWIZ_COMMONCODE_TB E ON E.C_CODE = A.ADMIN_CODE"
					+ " WHERE 1=1"
					+ " AND USER_EMPNO = ?";
			System.out.println("prepareStatememt: " + query);
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, empNo);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				
				empNo = rs.getString("user_empNo");
				String name = rs.getString("user_name");
				String addr = rs.getString("user_addr");
				String birth = rs.getString("user_birth");
				String joinDate = rs.getString("user_joinDT");
				String gen = rs.getString("user_gen");
				String phone = rs.getString("user_phone");
				String tel = rs.getString("user_tel");
				String dept = rs.getString("dept_name");
				String position = rs.getString("pos_name");
				String email = rs.getString("user_email");
				String admin = rs.getString("user_admin"); 
				
				vo.setEmpNo(empNo);
				vo.setName(name);
				vo.setAddr(addr);
				vo.setBirth(birth);
				vo.setGen(gen);
				vo.setJoinDate(joinDate);
				vo.setPhone(phone);
				vo.setTel(tel);
				vo.setDept(dept);
				vo.setPosition(position);
				vo.setEmail(email);
				vo.setAdmin(admin);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public void insertEmploy(MemberVO vo){
		try {
			con = dataFactory.getConnection();
			//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
			String empNo = vo.getEmpNo();
			String pwd = vo.getPwd();
			String name = vo.getName();
			String addr = vo.getAddr();
			String birth = vo.getBirth();
			String gen = vo.getGen();
			String joinDate = vo.getJoinDate();
			String phone = vo.getPhone();
			String tel = vo.getTel();
			String dept = vo.getDept();
			String position = vo.getPosition();
			String email = vo.getEmail();
			String admin = vo.getAdmin();
			String query = "INSERT INTO FORWIZ_USER_TB"
					+ " (USER_EMPNO"
					+ ", USER_PASSWD"
					+ ", USER_NAME"
					+ ", USER_ADDR"
					+ ", USER_BIRTH"
					+ ", GEN_CODE"
					+ ", USER_JOINDT"
					+ ", USER_PHONE"
					+ ", USER_TEL"
					+ ", DEPT_CODE"
					+ ", POS_CODE"
					+ ", USER_EMAIL"
					+ ", ADMIN_CODE)"
					+ " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, empNo);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, addr);
			pstmt.setString(5, birth);
			pstmt.setString(6, gen);
			pstmt.setString(7, joinDate);
			pstmt.setString(8, phone);
			pstmt.setString(9, tel);
			pstmt.setString(10, dept);
			pstmt.setString(11, position);
			pstmt.setString(12, email);
			pstmt.setString(13, admin);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public MemberVO employLogin(String empNo, String pwd){
		MemberVO vo = new MemberVO();
		try {
			con = dataFactory.getConnection();
			String query = "SELECT USER_EMPNO, USER_PASSWD, ADMIN_CODE"
					+ " FROM FORWIZ_USER_TB"
					+ " WHERE 1=1"
					+ " AND USER_EMPNO=?"
					+ " AND USER_PASSWD=?";
			System.out.println("prepareStatememt: " + query);
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, empNo);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
			empNo = rs.getString("user_empNo");
			pwd = rs.getString("user_passwd");
			String admin = rs.getString("admin_code");
			
			vo.setEmpNo(empNo);
			vo.setPwd(pwd);
			vo.setAdmin(admin);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	public int loginCheck(String empNo, String pwd){
		String passwd = "";
		int x = -1;
		try {
			con = dataFactory.getConnection();
			String query = "SELECT USER_PASSWD"
					+ " FROM FORWIZ_USER_TB"
					+ " WHERE USER_EMPNO=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, empNo);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				passwd = rs.getString("user_passwd");
				if(passwd.equals(pwd))
					x=1;
				else
					x=0;
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return x;
	}
	
	public void delEmploy(String empNo){
		try {
			con = dataFactory.getConnection();
			String query = "DELETE FROM FORWIZ_USER_TB"
					+ " WHERE USER_EMPNO=?";
			System.out.println("prepareStatememt:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, empNo);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void updateEmploy(MemberVO vo){
		try {
			con = dataFactory.getConnection();
			String query = "UPDATE FORWIZ_USER_TB"
					+ " SET USER_PASSWD=?, USER_NAME=?, USER_ADDR=?, USER_BIRTH=?, GEN_CODE=?, USER_PHONE=?, USER_TEL=?, DEPT_CODE=?, POS_CODE=?, USER_EMAIL=?, ADMIN_CODE=?"
					+ " WHERE USER_EMPNO=?";
			System.out.println("prepareStatememt:" + query);
			pstmt = con.prepareStatement(query);
			
			if(vo.getAdmin()==null) {
				vo.setAdmin("AUTH_NORMAL");
			}
			pstmt.setString(1, vo.getPwd());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getAddr());
			pstmt.setString(4, vo.getBirth());
			pstmt.setString(5, vo.getGen());
			pstmt.setString(6, vo.getPhone());
			pstmt.setString(7, vo.getTel());
			pstmt.setString(8, vo.getDept());
			pstmt.setString(9, vo.getPosition());
			pstmt.setString(10, vo.getEmail());
			pstmt.setString(11, vo.getAdmin());
			pstmt.setString(12, vo.getEmpNo());
			
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int confirmId(String empNo){
		int x = -1;
		try {
			con = dataFactory.getConnection();
			ResultSet rs = null;
			String query = "SELECT USER_EMPNO"
					+ " FROM FORWIZ_USER_TB"
					+ " WHERE USER_EMPNO=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, empNo);
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				x=1;
			}
			else {
				x=-1;
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return x;
	}
//	public int confirmId(String empNo){
//		int x = -1;
//		try {
//			con = dataFactory.getConnection();
//			ResultSet rs = null;
//			String query = "SELECT USER_EMPNO"
//					+ " FROM FORWIZ_USER_TB"
//					+ " WHERE USER_EMPNO=?";
//			System.out.println("prepareStatememt: " + query);
//			pstmt = con.prepareStatement(query);
//			pstmt.setString(1, empNo);
//			rs = pstmt.executeQuery();
//			
//			if(rs.next())
//				x=1;
//			else
//				x=-1;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return x;
//	}
}