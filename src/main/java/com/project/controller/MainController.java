package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Criteria;
import com.project.domain.PageDTO;
import com.project.domain.PageMaker;
import com.project.domain.RequestVO;
import com.project.service.AdminService;
import com.project.service.MainService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/herethere/*")
@AllArgsConstructor
@Slf4j
public class MainController {
	
	private MainService service;
	private AdminService aservice;
	
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
//		PageMaker pageMaker = new PageMaker();
//	    pageMaker.setCri(cri);
//	    pageMaker.setTotalCount(aservice.countList()); //총 데이터 개수를 전달
		int total = service.getTotal(cri);
		
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/local_fair2")
	public void local_fair2(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(service.areaCnt("서울")); //서울 데이터 개수를 전달
		
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/local_fair3")
	public void local_fair3(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    
	    int a = service.areaCnt("인천");
	    int b = service.areaCnt("대주");
	    int c = service.areaCnt("광주");
	    int result = a+b+c;
	    
	    pageMaker.setTotalCount(result); //인천,대주,광주 데이터 개수를 전달
		
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/local_fair4")
	public void local_fair4(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    
	    int a = service.areaCnt("대구");
	    int b = service.areaCnt("울산");
	    int c = service.areaCnt("부산");
	    int result = a+b+c;
	    
	    pageMaker.setTotalCount(result); //대구,울산,부산 데이터 개수를 전달
		
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/local_fair5")
	public void local_fair5(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);

	    int a = service.areaCnt("경기");
	    int b = service.areaCnt("강원");
	    int result = a+b;
	    
	    pageMaker.setTotalCount(result); //경기,강원 데이터 개수를 전달
	    
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/local_fair6")
	public void local_fair6(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);

	    int a = service.areaCnt("충남");
	    int b = service.areaCnt("충북");
	    int result = a+b;
	    
	    pageMaker.setTotalCount(result); //충남,충북 데이터 개수를 전달
	    
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/local_fair7")
	public void local_fair7(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);

	    int a = service.areaCnt("전남");
	    int b = service.areaCnt("전북");
	    int result = a+b;
	    
	    pageMaker.setTotalCount(result); //전남,전북 데이터 개수를 전달
	    
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/local_fair8")
	public void local_fair8(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);

	    int a = service.areaCnt("경남");
	    int b = service.areaCnt("경북");
	    int result = a+b;
	    
	    pageMaker.setTotalCount(result); //경남,경북 데이터 개수를 전달
	    
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/local_fair9")
	public void local_fair9(Model model, Criteria cri) {
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(service.areaCnt("제주")); //제주 데이터 개수를 전달
		
		model.addAttribute("list", aservice.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//한개데이터 조회
	@GetMapping({"/selectOne", "/selectOne2", "/selectOne3"})
	public void selectOne(@RequestParam("bnum") Long bnum, Model model) {
		
		model.addAttribute("board", aservice.selectOne(bnum));
		//model객체를 이용해 key값 board에 selectOne메소드 저장
		
		aservice.plusCnt(bnum);
		//조회수+1
	}
	
	@GetMapping("/popular_hit")
	public void popular_hit(Model model) {
		model.addAttribute("cntList", service.selectCnt());

	}
	
	@GetMapping("/popular_recommend")
	public void popular_recommend(Model model) {
		model.addAttribute("recList", service.selectRec());
	}
	
	//등록요청
	@ResponseBody
	@PostMapping("/insertRequest")
	public void insertRequest(RequestVO request) {
		aservice.insertRequest(request);
	}
	
	
	
	
	//테스트
	@GetMapping("/test")
	public void test(Model model) {
		model.addAttribute("recList", service.selectRec());
		
	}
}
