package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberService;
import vo.MemberVO;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("*.do")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;
	MemberService service;
	MemberVO member;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		service = new MemberService();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doHandler(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doHandler(request, response);
	}

	private void doHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		String requestURI = request.getRequestURI();
		String view = "";
		String contextPath = request.getContextPath();
		String action = requestURI.substring(contextPath.length());

		if (action.equals("/loginForm.do")) {
			view = "/loginForm.jsp";
		} else if (action.equals("/login.do")) {
			String empNo = request.getParameter("empNo");
			String pwd = request.getParameter("pwd");
			int check = service.loginCheck(empNo, pwd);
			member = service.login(empNo, pwd);
			PrintWriter out = response.getWriter();
			if (check == 1) {
				session = request.getSession();
				session.setAttribute("memberSession", member);
				response.sendRedirect("/forwiz2/list.do");
				return;
			} else if (check == 0) {
				out.print("<script>alert(\"비밀번호가 맞지 않습니다.\"); history.go(-1);</script>");
				return;
			} else {
				out.print("<script>alert(\"아이디가 맞지 않습니다.\"); history.go(-1);</script>");
				return;
			}
		} else if (action.equals("/logout.do")) {
			session.invalidate();
			PrintWriter out = response.getWriter();
			out.print("<script>alert('로그아웃 되었습니다.');" + "location.href='" + request.getContextPath()
					+ "/list.do'</script>");
			return;
		} else if (action.equals("/list.do")) {
			List<MemberVO> memberList = new ArrayList<MemberVO>();
			String search_name = request.getParameter("search_name");
			String search_empNo = request.getParameter("search_empNo");
			;
			String search_dept = request.getParameter("search_dept");
			;
			memberList = service.list(search_name, search_empNo, search_dept);
			request.setAttribute("memberList", memberList);
			view = "/memberList.jsp";
		} else if (action.equals("/registForm.do")) {
			view = "/registForm.jsp";
		} else if (action.equals("/regist.do")) {
			member = new MemberVO();
			String empNo = request.getParameter("empNo");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String addr = request.getParameter("addr");
			String birth = request.getParameter("birth");
			String gen = request.getParameter("gen");
			String joinDate = request.getParameter("joinDate");
			String phone = request.getParameter("phone");
			String tel = request.getParameter("tel");
			String dept = request.getParameter("dept");
			String position = request.getParameter("position");
			String email = request.getParameter("email");
			String admin = request.getParameter("admin");
			member.setEmpNo(empNo);
			member.setPwd(pwd);
			member.setName(name);
			member.setAddr(addr);
			member.setBirth(birth);
			member.setGen(gen);
			member.setJoinDate(joinDate);
			member.setPhone(phone);
			member.setTel(tel);
			member.setDept(dept);
			member.setPosition(position);
			member.setEmail(email);
			member.setAdmin(admin);
			member.setAddr(addr);
			service.regist(member);
			PrintWriter out = response.getWriter();
			out.print("<script>alert('등록이 완료되었습니다.');" + "location.href='" + request.getContextPath()
					+ "/list.do'</script>");
			return;
		} else if (action.equals("/confirm.do")) {
			String empNo = request.getParameter("empNo");
			int check = service.confirmId(empNo);
			if (check == 1) {
				int n = (Integer.parseInt(empNo.substring(empNo.length() - 2, empNo.length())));
				while (check == 1) {
					empNo = empNo.substring(0, 4);
					if (n < 10) {
						empNo += "0" + n;
					} else {
						empNo += n;
					}
					check = service.confirmId(empNo);
					n++;
				}
				request.setAttribute("empNo", empNo);
			}
			view = "/confirmId.jsp";
		} else if (action.equals("/detailForm.do")) {
			String empNo = request.getParameter("empNo");
			member = service.detailList(empNo);
			request.setAttribute("member", member);
			view = "/detailForm.jsp";
		} else if (action.equals("/updateForm.do")) {
			member = new MemberVO();
			String empNo = request.getParameter("empNo");
			member = service.detailList(empNo);
			request.setAttribute("member", member);
			view = "/updateForm.jsp";
		} else if (action.equals("/update.do")) {
			member = new MemberVO();
			String empNo = request.getParameter("empNo");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String addr = request.getParameter("addr");
			String birth = request.getParameter("birth");
			String gen = request.getParameter("gen");
			String joinDate = request.getParameter("joinDate");
			String phone = request.getParameter("phone");
			String tel = request.getParameter("tel");
			String dept = request.getParameter("dept");
			String position = request.getParameter("position");
			String email = request.getParameter("email");
			String admin = request.getParameter("admin");
			member.setEmpNo(empNo);
			member.setPwd(pwd);
			member.setName(name);
			member.setAddr(addr);
			member.setBirth(birth);
			member.setGen(gen);
			member.setJoinDate(joinDate);
			member.setPhone(phone);
			member.setTel(tel);
			member.setDept(dept);
			member.setPosition(position);
			member.setEmail(email);
			member.setAdmin(admin);
			member.setAddr(addr);
			service.update(member);
			PrintWriter out = response.getWriter();
			out.print("<script>alert('수정이 완료되었습니다.');" + "location.href='" + request.getContextPath()
					+ "/list.do'</script>");
			return;
		} else if (action.equals("/delete.do")) {
			System.out.println("session" + session.getAttribute("memberSession"));
			PrintWriter out = response.getWriter();
			MemberVO check = (MemberVO) session.getAttribute("memberSession");
			if (check.getAdmin().equals("AUTH_ADMIN")) {
				String empNo = request.getParameter("empNo");
				service.delete(empNo);
				out.print("<script>alert('삭제가 완료되었습니다.');" + "location.href='" + request.getContextPath()
						+ "/list.do'</script>");
				return;
			} else {
				out.println("<script>alert('권한이 없습니다.');" + "location.href='" + request.getContextPath()
						+ "/list.do'</script>");
				return;
			}
		}
		RequestDispatcher dis = request.getRequestDispatcher(view);
		System.out.println("jsp------- : " + view);
		dis.forward(request, response);
	}

}
