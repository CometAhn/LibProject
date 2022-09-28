package library;

import java.io.File;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import library.DAO.*;
import library.Entity.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/Lib")
public class LibraryController {

	private static final long serialVersionUID = 1L;
	private final Logger logger = LoggerFactory.getLogger(this.getClass()); // 로거 선언

	@Value("${lib.imgdir}")
	String fdir;
	static final int LISTCOUNT = 9;

	final LibraryDAO dao;
	final LoginDAO daoG;
	final CartDAO daoC;
	final ReviewDAO daoR;
	final RecommendDAO daoRc;
	final LoanDAO daoL;


	//// 책 시작
	// 웹 리소스 기본 경로 지정
	private final String START_PAGE = "Library/List.jsp";

	@Autowired
	public LibraryController(LibraryDAO dao, LoginDAO daoG, CartDAO daoC, ReviewDAO daoR, RecommendDAO daoRc, LoanDAO daoL) {
		this.dao = dao;
		this.daoG = daoG;
		this.daoC = daoC;
		this.daoR = daoR;
		this.daoRc = daoRc;
		this.daoL = daoL;
	}

	String controler = "Library/Control";


	@PostMapping("/add")
	public String addBook(@ModelAttribute Library library, Model m,
	                      @RequestParam("file") MultipartFile file) {

		try {
			// 저장 파일 객체 생성
			File dest = new File(fdir + "/" + file.getOriginalFilename());

			// 파일 저장
			file.transferTo(dest);

			// library 객체에 파일 이름 저장
			library.setBookCover(dest.getName());
			dao.addBook(library);

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 추가 과정에서 문제 발생!!");
			m.addAttribute("error", "책이 정상적으로 등록되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		m.addAttribute("msg", "1");
		return controler;
	}

	// getAll 메서드 구현
	@GetMapping("/list")
	public String listbook(@RequestParam int pagenum, @RequestParam String items,
	                       @RequestParam String text, Model m) {
		List<Library> list;
		int limit = LISTCOUNT;
		int spage;
		int epage;
		int total_record = dao.getlistcount(items, text);

		// 테스트 후 삭제하기!!
		// System.out.println("토탈 값 가져오니? " + total_record);

		int total_page;

		if (total_record % limit == 0) {
			total_page = total_record / limit;
			Math.floor(total_page);
		} else {
			total_page = total_record / limit;
			Math.floor(total_page);
			total_page = total_page + 1;
		}

		try {
			list = dao.getAll(pagenum, limit, items, text);

			// 페이지 넘버링 야매 ㄱ
			spage = 0 + (pagenum - 1) + ((pagenum - 1) * 8);
			epage = 8 + (pagenum - 1) + ((pagenum - 1) * 8);

			m.addAttribute("newslist", list);
			m.addAttribute("booklist", list);
			m.addAttribute("total_record", total_record);
			m.addAttribute("pagenum", pagenum);
			m.addAttribute("total_page", total_page);
			m.addAttribute("items", items);
			m.addAttribute("text", text);
			m.addAttribute("spage", spage);
			m.addAttribute("epage", epage);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "책 목록 생성이 정상적으로 처리되지 않았습니다!!");
		}
		return "Library/List";
	}

	// getBook() 메서드 구현
	@GetMapping("/getbook/{id}")
	public String getBook(@PathVariable int id, Model m) {

		try {
			Library n = dao.getBook(id);
			m.addAttribute("book", n);
			List<Review> list = daoR.getReview(id);
			System.out.println();
			m.addAttribute("reviewlist", list);


		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("책 정보를 가져오는 과정에서 문제 발생!!");
			m.addAttribute("error", "책 정보를 정상적으로 가져오지 못했습니다!!");
		}
		return "Library/View";
	}

	// 책정보 삭제
	//TODO : jsp에 삭제 버튼 없앰. 추가하자.
	@GetMapping("/delete/{id}")
	public String deleteBook(@PathVariable int id, Model m) {
		try {
			dao.delBook(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 삭제 과정에서 문제 발생!!");
			m.addAttribute("error", "책 정보를 정상적으로 삭제되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		return controler;
	}

/*	// getFileName() 메서드 구현
	private String getFilename(Part part) {
		String fileName = null;
		// 파일이름이 들어있는 헤더 영역을 가져옴
		String header = part.getHeader("content-disposition");
		System.out.println("Heder => " + header);

		// 파일 이름이 들어 있는 속성 부분의 시작 위치를 가져와 " " 사이의 값만 가지고 옴
		int start = header.indexOf("filename=");
		fileName = header.substring(start + 10, header.length() - 1);
		logger.warn("파일명 : " + fileName);
		return fileName;
	}
*/

	// 이번달 추천 책 + index
	@GetMapping("/index")
	public String home(Model m) {
		List<Recommend> list;
		try {
			// 이번달 추천 책 사용하기 위해 추가
			DecimalFormat df = new DecimalFormat("#0");
			Calendar currentCalendar = Calendar.getInstance();

			Integer month = Integer.parseInt(df.format(currentCalendar.get(Calendar.MONTH) + 1));
			System.out.println(month);
			list = daoRc.recommend(month);

			m.addAttribute("booklist", list);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("추천 책 출력 과정에서 문제 발생!!");
			m.addAttribute("error", "추천 책 출력을 정상적으로 하지 못했습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		return "Library/index";
	}
	//// 책 끝

	//// 멤버 시작
	// 로그인 페이지
	@GetMapping("map")
	public String map() {
		return "Library/map";
	}

	@GetMapping("loginpage")
	public String login() {
		return "Library/member/loginMember";
	}

	// 회원가입 페이지
	@GetMapping("register")
	public String register() {
		return "Library/member/addMember";
	}

	// 회원가입
	@PostMapping("regist")
	public String regist(@ModelAttribute Login g, Model m) {
		List<Login> list;
		try {
			String id = g.getLid();
			list = daoG.getid(id);
			for (int i = 0; i < list.size(); i++) {
				Login check = list.get(i);
				// 대소문자 구분 없이 검색한 아이디와 입력한 아이디가 같다면
				if (check.getLid().toLowerCase().equals(id.toLowerCase())) {
					// 회원가입 페이지로 이동 후 가입 된 아이디 경고창 ㄱ
					m.addAttribute("msg", "3");
					return controler;
				}
			}
			daoG.regist(g); // 이상 없다면 가입
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("계정 추가 중 오류 발생");
			m.addAttribute("error", "계정 생성이 제대로 이루어지지 않았습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		m.addAttribute("error", "0");
		return "Library/member/loginMember";
	}

	// 변경페이지 데이터 조회
	@PostMapping("/edit")
	public String edit(@RequestParam String id, Model m) throws Exception {
		Login g = null;

		try {
			g = daoG.edit(id);
			m.addAttribute("login", g);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("계정 조회 과정에서 문제 발생!!");
			m.addAttribute("error", "계정 조회에 실패했습니다!!!");
		}
		return "Library/member/updateMember";
	}

	// 업데이트
	@PostMapping("/update")
	public String update(@ModelAttribute Login g, Model m) {
		try {
			daoG.update(g);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("계정 정보 변경 중 오류 발생");
			m.addAttribute("error", "계정 정보 변경이 제대로 이루어지지 않았습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		m.addAttribute("error", "3");
		return "Library/member/loginMember";
	}

	// 탈퇴
	@PostMapping("/delete")
	public String delete(@RequestParam String id, Model m) {
		// 빌린 책을 조회해서 책이 있다면 탈퇴 x
		int count;

		try {
			count = daoC.getbookcount(id);// 빌리고 아직 반납 안한 책 수

			// 책 목록이 널이 아니라면?
			if (count != 0) {
				// 탈퇴 하지 말고 오류 출력.
				System.out.println("아직 반납 안 한 책이 있음.");

				m.addAttribute("id", id);
				m.addAttribute("msg", "0");

				return "Library/member/updateMember";
			}
			daoG.deleteID(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("계정 삭제 중 오류 발생");
			m.addAttribute("error", "계정 삭제가 제대로 이루어지지 않았습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		m.addAttribute("error", "4");
		return "Library/member/loginMember";
	}

	// 로그인
	@PostMapping("login")
	public String login(@RequestParam String id, @RequestParam(name = "password") String pw, Model m) throws Exception {
		Login g = null;

		try {
			g = daoG.login(id, pw);
			m.addAttribute("login", g.getLid());
			m.addAttribute("grade", g.isGrade());
			m.addAttribute("name", g.getName());
		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("로그인 과정에서 문제 발생!!");
			m.addAttribute("error", "로그인에 실패했습니다!!!");
		}

		if (g.getLid() == null) {
			System.out.println("sql에서 일치하는 아이디를 못 가져옴. 아이디/비번 불일치 ㄱ");
			m.addAttribute("error", "1");
			return "Library/member/loginMember";
		}
		if (g.getLid() != null && g.isUsed() == false) {
			System.out.println("탈퇴한 계정(" + g.getLid() + ")에서 로그인 시도, 탈퇴 메시지 ㄱ");
			m.addAttribute("error", "2");
			return "Library/member/loginMember";
		} else {
			m.addAttribute("msg", "0");
			return "Library/Control";
		}
	}

	// 로그아웃 페이지
	@GetMapping("/logout")
	public String logout() {
		return "Library/member/logoutMember";
	}

	//// 멤버 끝

	// 장바구니, 책 대여 시작
	// 장바구니 등록
	@GetMapping("addcart")
	public String addcart(@RequestParam String id, @RequestParam int bid, Model m) {
		m.addAttribute("bid", bid);

		// 장바구니 조회해서 등록된 책이라면 장바구니에 추가 x
		// 이미 빌린 책을 조회해서 빌린 책이라면 장바구니에 추가 x
		List<Library> list = null;
		List<AllinOne> list1 = null;
		try {
			list = daoC.getAllCart(id); // 장바구니에 있는 책
			list1 = daoC.getnonLoanbooks(id); // 빌리고 아직 반납 안한 책

			for (int i = 0; i < list.size(); i++) {
				Library check = list.get(i);
				// 등록된 상품이랑 받아온 파라미터 값이 같다면,
				if (check.getBid() == bid) {
					// 장바구니에 담지 말고 오류 출력.
					System.out.println("장바구니 추가되어 있는 책");
					m.addAttribute("msg", "0");
					return "Library/View";
				}
			}

			for (int i = 0; i < list1.size(); i++) {
				AllinOne check = list1.get(i);
				// 등록된 상품이랑 받아온 파라미터 값이 같다면,
				if (check.getBid() == bid) {
					// 장바구니에 담지 말고 오류 출력.
					System.out.println("빌리고 반납 안한 책");
					m.addAttribute("msg", "2");
					return "Library/View";
				}
			}
			daoC.addCart(id, bid);

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 담는중 중 오류 발생");
			m.addAttribute("error", "책을 장바구니에 담지 못했습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		m.addAttribute("msg", "1");
		return "Library/View";
	}

	// 장바구니 등록 후 장바구니 페이지 이동(리턴 값만 다르게)
	@GetMapping("addcarttocart")
	public String addcarttocart(@RequestParam String id, @RequestParam int bid, Model m) {
		m.addAttribute("bid", bid);
		int count;

		// 장바구니 조회해서 등록된 책이라면 장바구니에 추가 x
		// 이미 빌린 책을 조회해서 빌린 책이라면 장바구니에 추가 x
		// 대여 후 장바구니 조회 기능을 넣자. count, list
		List<Library> list = null;
		List<AllinOne> list1 = null;
		try {
			list = daoC.getAllCart(id); // 장바구니에 있는 책
			list1 = daoC.getnonLoanbooks(id); // 빌리고 아직 반납 안한 책

			for (int i = 0; i < list.size(); i++) {
				Library check = list.get(i);
				// 등록된 상품이랑 받아온 파라미터 값이 같다면,
				if (check.getBid() == bid) {
					// 장바구니에 담지 말고 오류 출력.
					System.out.println("장바구니 추가되어 있는 책");
					m.addAttribute("msg", "0");
					return "Library/View";
				}
			}

			for (int i = 0; i < list1.size(); i++) {
				AllinOne check = list1.get(i);
				// 등록된 상품이랑 받아온 파라미터 값이 같다면,
				if (check.getBid() == bid) {
					// 장바구니에 담지 말고 오류 출력.
					System.out.println("빌리고 반납 안한 책");
					m.addAttribute("msg", "2");
					return "Library/View";
				}
			}
			daoC.addCart(id, bid); // 장바구니에 넣기


		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 담는중 중 오류 발생");
			m.addAttribute("error", "책을 장바구니에 담지 못했습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		// 추가 끝.
		// 장바구니 조회 시작.
		try {
			count = daoC.getbookcount(id);
			list = daoC.getAllCart(id); // 다시 조회

			m.addAttribute("booklist", list); // 장바구니 목록
			m.addAttribute("count", count); // 책 수
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("장바구니 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "장바구니 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		return "Library/cart";
	}

	// 장바구니 조회
	@GetMapping("listcart")
	public String listcart(@RequestParam String id, Model m) {
		int count;
		List<Library> list = null;
		try {
			count = daoC.getbookcount(id);
			list = daoC.getAllCart(id);
			m.addAttribute("booklist", list);
			m.addAttribute("count", count);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("장바구니 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "장바구니 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		return "Library/cart";
	}

	// 장바구니 삭제
	@GetMapping("deleteCart")
	public String deleteCart(@RequestParam String id, @RequestParam int bid, Model m) {
		int count;
		List<Library> list = null;
		try {
			daoC.delCart(id, bid);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("장바구니 삭제 과정에서 문제 발생!!");
			m.addAttribute("error", "장바구니가 삭제되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		// 삭제 끝
		// 장바구니 조회 시작.
		try {
			count = daoC.getbookcount(id);
			list = daoC.getAllCart(id); // 다시 조회

			m.addAttribute("booklist", list); // 장바구니 목록
			m.addAttribute("count", count); // 책 수
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("장바구니 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "장바구니 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		return "Library/cart";
	}

	// 책 대여
	@GetMapping("loan")
	public String loan(@RequestParam String id, Model m) {
		List<Library> list;
		List<AllinOne> all;
		int count;

		// 장바구니 조회 시작.
		try {
			count = daoC.getbookcount(id);
			list = daoC.getAllCart(id);

			m.addAttribute("booklist", list); // 장바구니 목록
			m.addAttribute("count", count); // 책 수
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("장바구니 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "장바구니 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}

		// 연체기간(Overdue)이 오늘보다 크면 대여 금지.
		Login g;
		try {
			g = daoG.edit(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여 과정에서 문제가 발생했습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		DecimalFormat df = new DecimalFormat("#0");
		Calendar currentCalendar = Calendar.getInstance();
		long tyear = Integer.parseInt(df.format((currentCalendar.get(Calendar.YEAR) * 365)));
		long tmonth = Integer.parseInt(df.format((currentCalendar.get(Calendar.MONTH) + 1) * 30));
		long tday = Integer.parseInt(df.format(currentCalendar.get(Calendar.DATE)));
		long now = tyear + tmonth + tday;

		String Overdue = g.getOverdue();
		if (Overdue != null) {
			String[] Overdue1 = Overdue.split("-");
			Long end = (long) (Integer.parseInt(Overdue1[0]) * 365 + Integer.parseInt(Overdue1[1]) * 30 + Integer.parseInt(Overdue1[2]));

			if (now < end) {
				// 대여 불가!
				m.addAttribute("msg", "1");
				m.addAttribute("overdue", g.getOverdue());
				return "Library/cart";
			}
		}
		// 장바구니에 책이 있더라도 책의 수량이 0이면 책 대여 금지
		try {
			list = daoC.getAllCart(id); // 장바구니에 있는 책

			for (int i = 0; i < list.size(); i++) {
				Library check = list.get(i);
				// 등록된 상품의 개수가 0이면
				if (check.getStock() == 0) {
					// 대여 하지말고 오류 출력.
					// 나중에 수정하자
					//return "lib?action=listcart&id=" + id + "&msg=0";
					m.addAttribute("msg", "0");
					m.addAttribute("id", id);
					return "Library/cart";
				}
			}
			//System.out.println(" loan id값 : " + id);
			daoC.LoanBook(id);
			daoC.delCartpro(id);
			daoC.downcount(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여 과정에서 문제가 발생했습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		// 대여 끝
		// 대여 페이지 조회 시작
		try {
			List<AllinOne> list3;
			list3 = daoC.getAllLoan(id);
			m.addAttribute("booklist", list3);

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		return "Library/loan";
	}

	// 책 대여 정보
	@GetMapping("listloan")
	public String listloan(@RequestParam String id, Model m) {
		List<AllinOne> list = null;
		DecimalFormat df = new DecimalFormat("#0");
		Calendar currentCalendar = Calendar.getInstance();
		int tmonth = Integer.parseInt(df.format((currentCalendar.get(Calendar.MONTH) + 1) * 30));
		int tday = Integer.parseInt(df.format(currentCalendar.get(Calendar.DATE)));
		int now = tmonth + tday;

		m.addAttribute("now", now);

		try {
			list = daoC.getAllLoan(id);
			m.addAttribute("booklist", list);


		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		return "Library/loan";
	}

	// 책 반납
	@GetMapping("ReturnBook")
	public String ReturnBook(@RequestParam String id, @RequestParam int bid, @RequestParam int period, Model m) {
		try {
			daoC.upcount(id, bid);
			daoC.ReturnBook(id, bid);


		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여을 못했습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		// 반납 끝
		// 대여 페이지
		try {
			List<AllinOne> list;
			list = daoC.getAllLoan(id);
			m.addAttribute("booklist", list);

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		// 연체 일*3일 만큼 연체 못하도록 ㄱ
		try {
			if (period > 0) {
				daoC.overdue(period, id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("연체 기간 설정 과정에서 문제 발생!!");
			m.addAttribute("error", "연체 기간 설정이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}

		Login g;
		try {
			g = daoG.edit(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여 과정에서 문제가 발생했습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}
		DecimalFormat df = new DecimalFormat("#0");
		Calendar currentCalendar = Calendar.getInstance();
		long tyear = Integer.parseInt(df.format((currentCalendar.get(Calendar.YEAR) * 365)));
		long tmonth = Integer.parseInt(df.format((currentCalendar.get(Calendar.MONTH) + 1) * 30));
		long tday = Integer.parseInt(df.format(currentCalendar.get(Calendar.DATE)));
		long now = tyear + tmonth + tday;

		String Overdue = g.getOverdue();
		if (Overdue != null) {
			String[] Overdue1 = Overdue.split("-");
			Long end = (long) (Integer.parseInt(Overdue1[0]) * 365 + Integer.parseInt(Overdue1[1]) * 30 + Integer.parseInt(Overdue1[2]));

			if (now < end) {
				// 대여 불가!
				m.addAttribute("alert", "1");
				m.addAttribute("overdue", g.getOverdue());
				return "Library/loan";
			}
		}

		return "Library/loan";
	}
	// 장 바구니, 책 대여 끝

	// 리뷰 등록기능
	@PostMapping("/review")
	public String addReview(@ModelAttribute Review Review, Model m) {

		try {

			//리뷰 등록
			daoR.addReview(Review);
			//리뷰 등록 완료 처리
			daoR.reviewed(Review.getLogin().getLid(), Review.getLibrary().getBid());

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("리뷰 추가 과정에서 문제 발생!!");
			m.addAttribute("error", "리뷰가 정상적으로 등록되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}

		try {
			List<AllinOne> list;
			list = daoC.getAllLoan(Review.getLogin().getLid());
			m.addAttribute("booklist", list);

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("책 대여 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "책 대여 목록이 정상적으로 처리되지 않았습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}
		// 리뷰 등록 완료
		m.addAttribute("alert", "0");
		return "Library/loan";
	}

	@GetMapping("/delreview/{id}")
	public String delreview(@PathVariable int id, Model m) {
		try {
			Review n = daoR.getBookByid(id);
			// 지워도 됨. 해결함.
			//System.out.println("bid 값 맞니? " + n.getLibrary().getBid());
			m.addAttribute("bid", n.getLibrary().getBid());


		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("책 정보를 가져오는 과정에서 문제 발생!!");
			m.addAttribute("error", "책 정보를 정상적으로 가져오지 못했습니다!!");
		}
		try {
			daoR.delReview(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("리뷰 삭제 과정에서 문제 발생!!");
			m.addAttribute("error", "리뷰를 삭제하지 못했습니다!!");
			m.addAttribute("msg", "2");
			return controler;
		}


		System.out.println("완료");
		m.addAttribute("msg", "4");
		return "Library/View";
	}

	// 업데이트
	@PostMapping("/upreview")
	public String upreview(@ModelAttribute Review r, Model m) {
		try {
			daoR.update(r);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("리뷰 변경 중 오류 발생");
			m.addAttribute("error", "리뷰 변경이 제대로 이루어지지 않았습니다.");
			m.addAttribute("msg", "2");
			return controler;
		}

		try {
			Library n = dao.getBook(r.getLibrary().getBid());
			m.addAttribute("book", n);
			List<Review> list = daoR.getReview(r.getLibrary().getBid());
			System.out.println();
			m.addAttribute("reviewlist", list);
			m.addAttribute("bid", r.getLibrary().getBid());

		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("책 정보를 가져오는 과정에서 문제 발생!!");
			m.addAttribute("error", "책 정보를 정상적으로 가져오지 못했습니다!!");
		}

		m.addAttribute("msg", "3");
		return "Library/View";
	}
}