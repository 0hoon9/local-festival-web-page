package com.project.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO { 
	//JPA(java persistent API(@Entity)
	private Long bnum; 
	private String title; 
	private String content; 
	private String writer; 
	private Date regDate; 
	private Date updateDate; 
	private int replyCnt; 
	
	private List<BoardAttachVO> attachList; 
}
