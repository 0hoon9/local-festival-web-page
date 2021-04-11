 package com.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Criteria;
import com.project.domain.ReplyVO;
import com.project.service.AdminService;
import com.project.service.MainService;
import com.project.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@Slf4j
@RequestMapping("/reply/*")
public class ReplyController {
	
	private ReplyService rService;
	
	// 댓글 작성을 위한 메서드
	@ResponseBody
	@PostMapping("/write")
	public double reply_write(ReplyVO rv) {
		rService.reply_write_service(rv); // rv로 자료 받아서 작성함
		
		double count = rService.reply_count_service(rv.getBnum());
		// 댓글 작성 후 새로 페이징을 위해 해당 글 번호에 있는 댓글 숫자 가져옴
		// 반환할 때는 1페이지 당 글이 10개라 10으로 나눠서 반환함
		// 이때 Math.ceil을 잘 써줘야 함(무조건 올림 기능, 단 자료형이 더블일때만 제대로 기능함)
		
		return Math.ceil(count/10);
	};
	
	@ResponseBody
	@GetMapping("/read")
	public ArrayList<ReplyVO> reply_read(Long bnum) {
		
		// 글 번호에 맞는 댓글 반환
		// 근데 이거 아래 메서드 쓰면서 안씀...비동기용 아님
		return rService.reply_read_service(bnum);
	};
	
	// 페이징과 댓글 반환 동시에 하도록 작성
	@ResponseBody
	@GetMapping("/read_paging")
	public ArrayList<ReplyVO> reply_read_with_paging(Long bnum, @RequestParam("page") String page) {
		
		int iPage = Integer.parseInt(page); // 페이지 정보 전달 받음
		
		Criteria cri = new Criteria(((iPage*10)-9),iPage*10);
		// 시작 페이지, 끝 페이지 정보를 가진 객체 생성

		// 해당 페이지 번호에 맞는 댓글 반환
		return rService.reply_read_with_paging_service(cri, bnum);
	};
	
	// 댓글 숫자 반환
	@ResponseBody
	@GetMapping("/reply_count")
	public double reply_count(@RequestParam("bnum") Long bnum) {
		
		// 댓글 숫자 반환을 위한 메서드
		double count = rService.reply_count_service(bnum);
		
		// 댓글 반환시 페이징을 위한 용도이므로 10으로 나눠짐
		// 왜 10으로 나누냐면 댓글 1페이지 당 댓글 10개가 들어감
		// 예를 들어 댓글 120개면 12페이지가 나와야 함
		// 그래서 10으로 나눠서 줌
		return Math.ceil(count/10);
	};
	
	// 단순 값 전달용 메서드
	@ResponseBody
	@GetMapping("/nowpage")
	public int for_paging(@RequestParam("nowpage") int nowpage) {
	
		// 현재 페이지 받아서 바로 전달함
		// 비동기로 값 전달을 위해서 사용함
		return nowpage;
	};
	
	// 댓글 삭제를 위한 메서드 
	@ResponseBody
	@PostMapping("/delete")
	public List reply_del(Model model, Long rnum, @RequestParam("nowpage") int nowpage, @RequestParam("bnum") Long bnum, @RequestParam("login_user") String login_user) {
		
		// 댓글 삭제 후 결과 값과 현재 페이지에 대한 정보를 담을 리스트 작성
		List returnList = new ArrayList();
		
		// 해당 댓글의 글쓴이 불러옴
		String rUser = rService.reply_user_search_service(rnum);
		
		// 현재 삭제 요청한 사람과 댓글의 글쓴이가 일치하는지 여부 확인 후 삭제 진행
		if(rUser.equals(login_user)) {
			rService.reply_del_service(rnum);
			returnList.add("success");
		} else {
			returnList.add("failed");
		}
		
		// 삭제 후 페이징을 위한 메서드
		double count = rService.reply_count_service(bnum);
		
		
		// 만약 현재 페이지에서 해당 댓글이 마지막 댓글이면
		// 댓글이 삭제되면 그 전 페이지로 가도록 페이지 번호를 바꿔주는 메서드
		// 예를 들어서 10페이지 마지막 댓글을 삭제하면 페이지 번호가 9로 바뀌도록 처리해줌
		if(Math.ceil(count/10) < nowpage) {
			nowpage = (int) Math.ceil(count/10);
		}
		returnList.add(nowpage);
		
		return returnList;
	};
	
	// 관리자용 댓글 삭제 메서드
	@ResponseBody
	@PostMapping("/admin_delete")
	public List admin_reply_del(Model model, Long rnum, @RequestParam("nowpage") int nowpage, @RequestParam("bnum") Long bnum) {
		
		// 관리자용 댓글 삭제 메서드는 유저 확인 과정 없음
		// 그냥 들어와서 삭제하면 되고
		
		// 나머지는 일반 댓글 삭제와 마찬가지임
		// 페이징을 위한 페이지 처리메서드는 동일
		List returnList = new ArrayList();
		
		rService.reply_del_service(rnum);
		
		returnList.add("success");
		
		double count = rService.reply_count_service(bnum);
		
		if(Math.ceil(count/10) < nowpage) {
			nowpage = (int) Math.ceil(count/10);
		}
		
		returnList.add(nowpage);
		
		return returnList;
	};
}
