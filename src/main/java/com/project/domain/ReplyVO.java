package com.project.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
 	private Long rnum ; // 댓글 번호
 	private Long  bnum ; // 글 번호
    private String reply ; // 댓글 내용
    private String replyer ; // 댓글러
    private Date replyDate ;  // 댓글 쓴 날
    private Date  updateDate ; // 댓글 수정일(구현 안함)
}
