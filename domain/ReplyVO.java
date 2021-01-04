package com.project.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
 	private Long rnum ; 
 	private Long  bnum ; 
    private String reply ; 
    private String replyer ; 
    private Date replyDate ; 
    private Date  updateDate ; 
}
