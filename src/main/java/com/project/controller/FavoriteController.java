package com.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.FavoriteVO;
import com.project.service.FavoriteService;
import com.project.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@Slf4j
@RequestMapping("/favorite/*")
public class FavoriteController {
	
	FavoriteService Fservice;
	
	// 즐겨찾기 등록 메서드
	@ResponseBody
	@PostMapping("/register")
	public String register_favorite(FavoriteVO fv) {
		return Fservice.register_favorite_service(fv);
	} 
	
	// 즐겨 찾기 읽기를 위한 메서드
	// 아이디만 전달 받아서 해당 아이디에 맞는 데이터 전달
	@ResponseBody
	@GetMapping("/read")
	public ArrayList<FavoriteVO> read_favorite(@RequestParam("user_id") String user_id) {
		
		return Fservice.read_favorite_service(user_id);
	}
	
	// 즐겨찾기 삭제를 위한 메서드
	@ResponseBody
	@PostMapping("/delete")
	public int delete_favorite_service(FavoriteVO fv, @RequestParam("nowpage") int nowpage) {
		
		// 즐겨찾기 우선 삭제함
		Fservice.delete_favorite_service(fv);
		
		// 즐겨찾기 페이징을 위해 로그인 아이디가 삭제 후에 가진 즐겨찾기 정보의 갯수 반환
		double countAll = Fservice.for_paging_service(fv.getUser_id());
		
		// 만약 해당 즐겨찾기가 존재하는 페이지 마지막 즐겨찾기 일 경우
		// 전달 받은 페이지 값을 -1 시켜서 재전송해줌
		if(Math.ceil(countAll/5) < nowpage) {
			nowpage = (int) Math.ceil(countAll/5);
		}
		
		return nowpage;
	}
	
	// 즐겨찾기 카운팅을 위한 메서드
	@ResponseBody
	@GetMapping("/count")
	public int count(@RequestParam("user_id") String user_id) {
		return Fservice.for_paging_service(user_id);
	}
	
	// 즐겨찾기 정보를 전달하는 역할
	// 비동기 전에 전달 받은 자료는 비동기 과정에서 파라미터를 통해 받아서 재전송하지 않으면 비동기 이후에 사용 불가
	// 한페이지에 있지만 실제로는 사용이 불가함... 
	@ResponseBody
	@GetMapping("/route")
	public List route(@RequestParam("user_id") String user_id, @RequestParam("nowpage") int nowpage) {
		List pass = new ArrayList();
		
		pass.add(Fservice.for_paging_service(user_id));
		pass.add(nowpage);
		
		return pass;
	}
	
}
