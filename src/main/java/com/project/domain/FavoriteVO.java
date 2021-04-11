package com.project.domain;

import lombok.Data;

@Data
public class FavoriteVO {
	
	// 즐겨찾기를 위한 데이터 
	
	private Long fnum; // 즐겨찾기 번호 
	private String user_id;  // 아이디
	private Long bnum;  // 글 번호
	
	private String title; // 글 제목
	private String area;  // 축제 지역
}
