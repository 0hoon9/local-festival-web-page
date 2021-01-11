package com.project.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/search")
@Slf4j
public class SearchController {
	
	@GetMapping(value = "/getSearch", produces = "text/plan; charset=UTF-8")
	public String getSearch() {
		log.info("MIME TYPE: "+MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
}
