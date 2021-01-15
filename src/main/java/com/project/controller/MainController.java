package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Criteria;
import com.project.domain.PageMaker;
import com.project.domain.RequestVO;
import com.project.service.AdminService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/herethere/*")
@Slf4j
public class MainController {
	@Setter(onMethod_=@Autowired)
	private AdminService service;
	
	@GetMapping("/map")
	public void search() {
		
	}
	
	@GetMapping("/main")
	public void realMain(String search) {
		System.out.println("search: "+search);
	}
	
	@GetMapping("/local_fair")
	public void local_fair(Model model, Criteria cri) {
		//페이징처리
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair2")
	public void local_fair2(Model model, Criteria cri) {
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair3")
	public void local_fair3(Model model, Criteria cri) {
		//페이징처리
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair4")
	public void local_fair4(Model model, Criteria cri) {
		//페이징처리
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair5")
	public void local_fair5(Model model, Criteria cri) {
		//페이징처리
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair6")
	public void local_fair6(Model model, Criteria cri) {
		//페이징처리
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair7")
	public void local_fair7(Model model, Criteria cri) {
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair8")
	public void local_fair8(Model model, Criteria cri) {
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	@GetMapping("/local_fair9")
	public void local_fair9(Model model, Criteria cri) {
		//페이징처리
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	//한개데이터 조회
	@GetMapping("/selectOne")
	public void selectOne(@RequestParam("bnum") Long bnum, Model model) {
		
		model.addAttribute("board", service.selectOne(bnum));
		//model객체를 이용해 key값 board에 selectOne메소드 저장
		
		service.plusCnt(bnum);
		//조회수+1
	}
	
	//등록요청
	@ResponseBody
	@PostMapping("/insertRequest")
	public void insertRequest(RequestVO request) {
		service.insertRequest(request);
	}
}
