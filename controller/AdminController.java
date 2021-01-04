package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class AdminController {

	@GetMapping("/main")
	public void main() {
		log.info("main");
	}
	
	@GetMapping("/search")
	public void search() {
		log.info("search");
	}
	
	@GetMapping("/event")
	public void event() {
		log.info("event");
	}
	
	@GetMapping("/local_travel")
	public void local_travel() {
		log.info("local_travel");
	}
	
	@GetMapping("/location")
	public void location() {
		log.info("location");
	}
	
	@GetMapping("/main_travel")
	public void main_travel() {
		log.info("main_travel");
	}
	
	@GetMapping("/myPage")
	public void myPage() {
		log.info("myPage");
	}
	
	@GetMapping("/popular")
	public void popular() {
		log.info("popular");
	}
	
	@GetMapping("/recommend")
	public void recommend() {
		log.info("recommend");
	}
	
}