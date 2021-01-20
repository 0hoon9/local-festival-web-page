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
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(service.areaCnt(cri)); //각 지역별 데이터 개수
		
		model.addAttribute("list",service.selectArea(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//한개데이터 조회
	@GetMapping({"/selectOne", "/selectOne2", "/selectOne3"})
	public void selectOne(@RequestParam("bnum") Long bnum, Model model, Criteria cri) {
		
		model.addAttribute("board", aservice.selectOne(bnum));
		//model객체를 이용해 key값 board에 selectOne메소드 저장
		model.addAttribute("cri", cri);
		
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
